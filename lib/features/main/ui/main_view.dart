import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/features/home/ui/widgets/home_view_body.dart';
import 'package:translators/features/main/logic/bottom_nav_bar_cubit/bottom_nav_bar_index_cubit.dart';
import 'package:translators/features/main/ui/widgets/custom_bottom_nav_bar.dart';
import 'package:translators/features/user_profile/ui/widgets/user_profile_tab_body.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  final List<Widget> pages = const [
    HomeViewBody(),
    Center(child: Text("Chats")),
    UserProfileTabBody(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<BottomNavBarIndexCubit, BottomNavBarIndexState>(
          builder: (context, state) {
            return IndexedStack(
              index: (state is BottomNavBarIndexChanged) ? state.index : 0,
              children: pages,
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.mainBlue,
        tooltip: "Google Translate",
        child: Image.asset(
          "assets/images/translate.png",
          width: 40.w,
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
