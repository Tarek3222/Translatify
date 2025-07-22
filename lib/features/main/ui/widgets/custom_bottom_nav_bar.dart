// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:translator/core/theme/app_colors.dart';
import 'package:translator/core/theme/app_styles.dart';
import 'package:translator/features/main/logic/bottom_nav_bar_cubit/bottom_nav_bar_index_cubit.dart';
import 'package:translator/features/main/ui/widgets/image_user_bloc_builder.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GNav(
      selectedIndex: context.watch<BottomNavBarIndexCubit>().currentIndex,
      onTabChange: (index) {
        context.read<BottomNavBarIndexCubit>().changeIndex(index);
      },
      curve: Curves.easeOutExpo,
      duration: const Duration(milliseconds: 300),
      gap: 3,
      activeColor: AppColors.mainBlue,
      tabBackgroundColor: AppColors.mainBlue.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12).r,
      textStyle: getMediumStyle(
        fontSize: 12,
        color: AppColors.mainBlue,
      ),
      rippleColor: AppColors.mainBlue, // tab button ripple color when pressed
      hoverColor: AppColors.black, // tab button hover color
      haptic: true, // haptic feedback
      tabBorderRadius: 12,
      tabs: const [
        GButton(
          icon: Icons.home_outlined,
          text: 'Home',
        ),
        GButton(
          icon: Icons.message_outlined,
          text: 'Chats',
        ),
        GButton(
          icon: Icons.person_outline,
          leading: ImageUserBlocBuilder(
            radius: 18,
          ),
          text: 'Profile',
        )
      ],
    );
  }
}
