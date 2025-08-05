part of 'user_profile_cubit.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {
  const UserProfileInitial();
}

final class UserProfileLoading extends UserProfileState {
  final bool isRefreshing;
  final UserProfileModel? previousData;

  const UserProfileLoading({
    this.isRefreshing = false,
    this.previousData,
  });

  @override
  List<Object> get props => [isRefreshing, previousData ?? 'null'];
}

final class UserProfileSuccess extends UserProfileState {
  final UserProfileModel userProfileModel;
  final DateTime? lastUpdated;
  final bool isFromCache;

  const UserProfileSuccess({
    required this.userProfileModel,
    this.lastUpdated,
    this.isFromCache = false,
  });

  @override
  List<Object> get props => [
        userProfileModel,
        lastUpdated ?? DateTime.now(),
        isFromCache,
      ];

  /// Create a copy with updated data
  UserProfileSuccess copyWith({
    UserProfileModel? userProfileModel,
    DateTime? lastUpdated,
    bool? isFromCache,
  }) {
    return UserProfileSuccess(
      userProfileModel: userProfileModel ?? this.userProfileModel,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isFromCache: isFromCache ?? this.isFromCache,
    );
  }
}

final class UserProfileError extends UserProfileState {
  final ApiErrorModel errorModel;
  final UserProfileModel? cachedData;
  final bool hasCachedData;

  const UserProfileError({
    required this.errorModel,
    this.cachedData,
    this.hasCachedData = false,
  });

  @override
  List<Object> get props => [
        errorModel,
        cachedData ?? 'null',
        hasCachedData,
      ];

  /// Check if this is a network error with cached data available
  bool get hasFallbackData => cachedData != null;

  /// Get error message
  String get errorMessage => errorModel.message ?? 'Unknown error occurred';
}
