// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';

Future<void> showImageOptionsBottomSheet({
  required BuildContext context,
  required String? imageUrl,
  required Future<void> Function(File file) onUploadImage,
  required Future<void> Function() onDeleteImage,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpacing(12),
            Container(
              width: 40.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            verticalSpacing(16),
            if (imageUrl != null && imageUrl.isNotEmpty)
              ListTile(
                leading:
                    const Icon(Icons.visibility, color: AppColors.mainBlue),
                title: titleTextAction(context, title: "View Image"),
                onTap: () {
                  Navigator.pop(context);
                  _viewImage(context, imageUrl);
                },
              ),
            if (imageUrl != null && imageUrl.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Colors.green),
                title: titleTextAction(context, title: "Update Image"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(context, onUploadImage);
                },
              ),
            if (imageUrl == null || imageUrl.isEmpty)
              ListTile(
                leading: const Icon(Icons.upload, color: Colors.green),
                title: titleTextAction(context, title: "Upload Image"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(context, onUploadImage);
                },
              ),
            if (imageUrl != null && imageUrl.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: titleTextAction(context, title: "Delete Image"),
                onTap: () {
                  Navigator.pop(context);
                  onDeleteImage();
                },
              ),
            verticalSpacing(8),
          ],
        ),
      );
    },
  );
}

Future<void> _pickImage(BuildContext context,
    Future<void> Function(File file) onUploadImage) async {
  final ImagePicker picker = ImagePicker();
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.background,
    builder: (_) => SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.green),
            title: titleTextAction(context, title: "Take a photo"),
            onTap: () async {
              Navigator.pop(context);
              final pickedFile = await picker.pickImage(
                  source: ImageSource.camera, imageQuality: 80);
              if (pickedFile != null) {
                await onUploadImage(File(pickedFile.path));
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.green),
            title: titleTextAction(context, title: "Choose from gallery"),
            onTap: () async {
              Navigator.pop(context);
              final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery, imageQuality: 80);
              if (pickedFile != null) {
                await onUploadImage(File(pickedFile.path));
              }
            },
          ),
        ],
      ),
    ),
  );
}

Widget titleTextAction(BuildContext context, {required String title}) {
  return Text(
    title,
    style: getMediumStyle(
        fontSize: 18, color: Theme.of(context).colorScheme.secondary),
  );
}

void _viewImage(BuildContext context, String imageUrl) {
  context.pushNamed(Routes.imageViewerScreen, arguments: imageUrl);
}
