import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/networking/api_error_model.dart';
import 'package:translators/features/user_profile/data/models/user_profile_model.dart';
import 'package:translators/features/user_profile/data/repo/user_profile_repo.dart';
part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepo userProfileRepo;

  UserProfileCubit(this.userProfileRepo) : super(const UserProfileInitial());

  // Performance optimizations
  static const Duration _cacheRefreshThreshold = Duration(minutes: 2);

  // State tracking
  bool _isInitialized = false;
  DateTime? _lastFetchTime;
  String? _lastError;

  /// Get user profile with optimized caching and state management
  Future<void> getUserProfile({bool forceRefresh = false}) async {
    // Prevent multiple simultaneous requests
    if (state is UserProfileLoading && !forceRefresh) {
      return;
    }

    // Check if we have recent data and don't need to force refresh
    if (!forceRefresh && _hasRecentData()) {
      return;
    }

    // Emit loading state
    emit(const UserProfileLoading());

    try {
      // Get data from repository with force refresh option
      final result =
          await userProfileRepo.getUserProfile(forceRefresh: forceRefresh);

      result.fold(
        (failure) {
          _lastError = failure.message;
          emit(UserProfileError(errorModel: failure));
        },
        (userProfileModel) {
          _lastError = null;
          _lastFetchTime = DateTime.now();
          _isInitialized = true;
          emit(UserProfileSuccess(userProfileModel: userProfileModel));
        },
      );
    } catch (e) {
      _lastError = e.toString();
      emit(UserProfileError(
        errorModel: ApiErrorModel(message: e.toString()),
      ));
    }
  }

  /// Refresh user profile data
  Future<void> refreshUserProfile() async {
    await getUserProfile(forceRefresh: true);
  }

  /// Get cached user profile if available
  UserProfileModel? getCachedUserProfile() {
    return userProfileRepo.cachedUserProfile;
  }

  /// Check if currently loading
  bool get isLoading => state is UserProfileLoading;

  /// Check if data has been fetched
  bool get isInitialized => _isInitialized;

  /// Get last error message
  String? get lastError => _lastError;

  /// Check if we have recent data (within threshold)
  bool _hasRecentData() {
    if (!_isInitialized || _lastFetchTime == null) {
      return false;
    }

    final timeSinceLastFetch = DateTime.now().difference(_lastFetchTime!);
    return timeSinceLastFetch < _cacheRefreshThreshold;
  }

  /// Initialize with cached data if available
  Future<void> initializeWithCache() async {
    final cachedProfile = userProfileRepo.cachedUserProfile;
    if (cachedProfile != null && !_isInitialized) {
      _lastFetchTime = DateTime.now();
      _isInitialized = true;
      emit(UserProfileSuccess(userProfileModel: cachedProfile));
    }
  }

  /// Clear cache and reset state
  Future<void> clearCache() async {
    await userProfileRepo.clearCache();
    _isInitialized = false;
    _lastFetchTime = null;
    _lastError = null;
    emit(const UserProfileInitial());
  }

  /// Get cache status for debugging
  Map<String, dynamic> getCacheStatus() {
    return {
      ...userProfileRepo.getCacheStatus(),
      'isInitialized': _isInitialized,
      'lastFetchTime': _lastFetchTime?.toIso8601String(),
      'hasRecentData': _hasRecentData(),
      'currentState': state.runtimeType.toString(),
    };
  }

  /// Update user profile data (for optimistic updates)
  void updateUserProfile(UserProfileModel updatedProfile) {
    if (state is UserProfileSuccess) {
      emit(UserProfileSuccess(userProfileModel: updatedProfile));
    }
  }

  /// Handle network connectivity changes
  void onNetworkChanged(bool isConnected) {
    if (isConnected && !_isInitialized) {
      // Auto-refresh when network becomes available
      getUserProfile();
    }
  }

  @override
  Future<void> close() {
    // Clean up resources
    _lastError = null;
    _lastFetchTime = null;
    return super.close();
  }
}
