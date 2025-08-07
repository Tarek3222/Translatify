import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:translators/core/networking/api_error_handler.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/core/networking/api_service.dart';
import 'package:translators/core/networking/network_info.dart';
import 'package:translators/features/user_profile/data/data_source/local_data_source/user_profile_local_data_source.dart';
import 'package:translators/features/user_profile/data/models/user_profile_model.dart';

class UserProfileRepo {
  final ApiService _apiService;
  final NetworkInfo _networkInfo;
  final UserProfileLocalDataSource _userProfileLocalDataSource;

  // Performance optimizations
  static const Duration _cacheTimeout = Duration(minutes: 5);

  // Cache for user profile data
  UserProfileModel? _cachedUserProfile;
  DateTime? _lastCacheTime;

  // Connection state tracking
  bool _isLoading = false;
  String? _lastError;

  UserProfileRepo(
    this._apiService,
    this._networkInfo,
    this._userProfileLocalDataSource,
  );

  /// Get user profile with optimized caching and error handling
  Future<Either<ApiErrorModel, UserProfileModel>> getUserProfile({
    bool forceRefresh = false,
  }) async {
    // Prevent multiple simultaneous requests
    if (_isLoading && !forceRefresh) {
      return _getCachedResult();
    }

    _isLoading = true;

    try {
      // Check cache first if not forcing refresh
      if (!forceRefresh && _isCacheValid()) {
        final cachedResult = _getCachedResult();
        if (cachedResult.isRight()) {
          _isLoading = false;
          return cachedResult;
        }
      }

      // Check network connectivity
      if (await _networkInfo.isConnected) {
        return await _fetchFromNetwork();
      } else {
        return await _fetchFromLocal();
      }
    } catch (e) {
      _lastError = e.toString();
      _isLoading = false;
      return Left(ApiErrorHandler.handle(e));
    }
  }

  /// Fetch data from network with optimized error handling
  Future<Either<ApiErrorModel, UserProfileModel>> _fetchFromNetwork() async {
    try {
      final response = await _apiService.getUserProfile();

      // Parse response efficiently
      final userProfile = _parseUserProfileResponse(response);

      // Cache the result
      await _cacheUserProfile(userProfile);

      _isLoading = false;
      return Right(userProfile);
    } catch (e) {
      _lastError = e.toString();
      _isLoading = false;

      // Try to get cached data on network error
      try {
        final cachedData =
            await _userProfileLocalDataSource.getLastUserProfile();
        _cacheUserProfile(cachedData);
        return Right(cachedData);
      } catch (cacheError) {
        return Left(ApiErrorHandler.handle(e));
      }
    }
  }

  /// Fetch data from local storage with fallback
  Future<Either<ApiErrorModel, UserProfileModel>> _fetchFromLocal() async {
    try {
      final localData = await _userProfileLocalDataSource.getLastUserProfile();
      _cacheUserProfile(localData);

      _isLoading = false;
      return Right(localData);
    } catch (e) {
      _lastError = e.toString();
      _isLoading = false;
      return Left(ApiErrorModel(message: e.toString()));
    }
  }

  /// Parse user profile response efficiently
  UserProfileModel _parseUserProfileResponse(String response) {
    try {
      final jsonData = jsonDecode(response);
      return UserProfileModel.fromJson(jsonData);
    } catch (e) {
      throw FormatException('Invalid JSON response: ${e.toString()}');
    }
  }

  /// Cache user profile data with timestamp
  Future<void> _cacheUserProfile(UserProfileModel userProfile) async {
    _cachedUserProfile = userProfile;
    _lastCacheTime = DateTime.now();

    // Cache to local storage asynchronously
    _userProfileLocalDataSource
        .cacheUserProfile(
      userProfileToCache: jsonEncode(userProfile.toJson()),
    )
        .catchError((error) {
      // Log error but don't fail the operation
      log('Failed to cache user profile: $error');
    });
  }

  /// Check if cache is still valid
  bool _isCacheValid() {
    if (_cachedUserProfile == null || _lastCacheTime == null) {
      return false;
    }

    final cacheAge = DateTime.now().difference(_lastCacheTime!);
    return cacheAge < _cacheTimeout;
  }

  /// Get cached result if available
  Either<ApiErrorModel, UserProfileModel> _getCachedResult() {
    if (_cachedUserProfile != null) {
      return Right(_cachedUserProfile!);
    }

    if (_lastError != null) {
      return Left(ApiErrorModel(message: _lastError!));
    }

    return const Left(ApiErrorModel(message: 'No cached data available'));
  }

  /// Clear cache and force refresh
  Future<void> clearCache() async {
    _cachedUserProfile = null;
    _lastCacheTime = null;
    _lastError = null;
    _isLoading = false;
  }

  /// Get cache status for debugging
  Map<String, dynamic> getCacheStatus() {
    return {
      'hasCachedData': _cachedUserProfile != null,
      'lastCacheTime': _lastCacheTime?.toIso8601String(),
      'isLoading': _isLoading,
      'lastError': _lastError,
      'cacheAge': _lastCacheTime != null
          ? DateTime.now().difference(_lastCacheTime!).inSeconds
          : null,
    };
  }

  /// Check if currently loading
  bool get isLoading => _isLoading;

  /// Get last error message
  String? get lastError => _lastError;

  /// Get cached user profile
  UserProfileModel? get cachedUserProfile => _cachedUserProfile;
}
