import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:translator/core/theme/app_colors.dart';

class AppLoadingIndecator extends StatelessWidget {
  const AppLoadingIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: AppColors.mainBlue,
        size: 70.w,
      ),
    );
  }
}
