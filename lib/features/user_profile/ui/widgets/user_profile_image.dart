import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translator/core/di/depandecy_injection.dart';
import 'package:translator/features/main/ui/widgets/image_user_bloc_builder.dart';
import 'package:translator/features/user_profile/data/repo/delete_user_images_repo.dart';
import 'package:translator/features/user_profile/data/repo/upload_user_images_repo.dart';
import 'package:translator/features/user_profile/logic/delete_user_profile_image_cubit/delete_user_profile_image_cubit.dart';
import 'package:translator/features/user_profile/logic/upload_user_profile_image_cubit/upload_user_profile_image_cubit.dart';
import 'package:translator/features/user_profile/logic/user_profile_cubit/user_profile_cubit.dart';
import 'package:translator/features/user_profile/ui/widgets/circle_profile_image.dart';
import 'package:translator/features/user_profile/ui/widgets/icon_profile_image_bloc_listener.dart';

class UserProfileImage extends StatefulWidget {
  const UserProfileImage({super.key});

  @override
  State<UserProfileImage> createState() => _UserProfileImageState();
}

class _UserProfileImageState extends State<UserProfileImage> {
  bool isLeft = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedPositionedDirectional(
      duration: const Duration(milliseconds: 300),
      top: 100.h,
      start: isLeft ? 20.w : MediaQuery.of(context).size.width - 190.w,
      // end: isLeft ? 0 : 1.w,
      child: Stack(
        children: [
          InkWell(
            onTap: () => setState(() => isLeft = !isLeft),
            child: const CircleProfileImage(
              child: ImageUserBlocBuilder(
                radius: 80,
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 10.h,
            end: 10.w,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => DeleteUserProfileImageCubit(
                      getIt<DeleteUserImagesRepo>(),
                      context.read<UserProfileCubit>()),
                ),
                BlocProvider(
                  create: (context) => UploadUserProfileImageCubit(
                      getIt<UploadUserImagesRepo>(),
                      context.read<UserProfileCubit>()),
                ),
              ],
              child: const IconProfileImageBlocListener(),
            ),
          ),
        ],
      ),
    );
  }
}
