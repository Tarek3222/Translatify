import 'package:flutter/material.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/widgets/app_circle_cached_network_image.dart';
import 'package:translators/core/widgets/custom_app_icon.dart';
import 'package:translators/features/chat/data/models/receiver_info_model.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class CustomChatAppBar extends StatelessWidget {
  const CustomChatAppBar({super.key, required this.receiverInfoModel});
  final ReceiverInfoModel receiverInfoModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          const CustomAppIcon(),
          horizontalSpacing(30),
          Expanded(
            child: Row(
              children: [
                AppCircleCachedNetworkImage(
                  imageUrl: receiverInfoModel.avatarUrl,
                  radius: 30,
                  memCacheHeight: 100,
                  memCacheWidth: 100,
                  maxHeightDiskCache: 200,
                  maxWidthDiskCache: 200,
                  cacheKey: receiverInfoModel.avatarUrl,
                ),
                horizontalSpacing(10),
                Expanded(
                  child: TitleTextWidet(
                    title: receiverInfoModel.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
