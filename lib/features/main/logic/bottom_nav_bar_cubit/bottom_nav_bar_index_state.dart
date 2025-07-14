part of 'bottom_nav_bar_index_cubit.dart';

sealed class BottomNavBarIndexState extends Equatable {
  const BottomNavBarIndexState();

  @override
  List<Object> get props => [];
}

final class BottomNavBarIndexInitial extends BottomNavBarIndexState {}

final class BottomNavBarIndexChanged extends BottomNavBarIndexState {
  final int index;

  const BottomNavBarIndexChanged(this.index);

  @override
  List<Object> get props => [index];
}
