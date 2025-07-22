import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/features/user_profile/data/repo/delete_user_images_repo.dart';
import 'package:translator/features/user_profile/data/repo/upload_user_images_repo.dart';
import 'package:translator/features/user_profile/logic/delete_user_cover_image_cubit/delete_user_cover_image_cubit.dart';
import 'package:translator/features/user_profile/logic/upload_user_cover_image_cubit/upload_user_cover_image_cubit.dart';
import 'package:translator/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:translator/features/user_profile/ui/widgets/cover_image_background_bloc_builder.dart';
import 'package:translator/features/user_profile/ui/widgets/icon_cover_image_bloc_listener.dart';

class UserCoverImage extends StatelessWidget {
  const UserCoverImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CoverImageBackgroundBlocBuilder()
            .animate()
            .fade()
            .scale()
            .shake(),
        PositionedDirectional(
          top: 10.h,
          end: 10.w,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => DeleteUserCoverImageCubit(
                    getIt<DeleteUserImagesRepo>(),
                    context.read<UserProfileCubit>()),
              ),
              BlocProvider(
                create: (context) => UploadUserCoverImageCubit(
                    getIt<UploadUserImagesRepo>(),
                    context.read<UserProfileCubit>()),
              ),
            ],
            child: const IconCoverImageBlocListener(),
          ),
        ),
      ],
    );
  }
}
