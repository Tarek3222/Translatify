import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_bar_index_state.dart';

class BottomNavBarIndexCubit extends Cubit<BottomNavBarIndexState> {
  BottomNavBarIndexCubit() : super(BottomNavBarIndexInitial());
  void changeIndex(int index) {
    log('BottomNavBarIndexCubit: changeIndex called with index: $index');
    emit(BottomNavBarIndexChanged(index));
  }

  int get currentIndex {
    if (state is BottomNavBarIndexChanged) {
      return (state as BottomNavBarIndexChanged).index;
    }
    return 0; // Default index if not changed
  }
}
