import 'package:flutter/material.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/core/utils/time_formated.dart';
import 'package:translators/core/widgets/app_circle_cached_network_image.dart';
import 'package:translators/features/chat/data/models/chats_list_response_model.dart';
import 'package:translators/features/chat/data/models/receiver_info_model.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class CustomChatListTile extends StatelessWidget {
  const CustomChatListTile({super.key, required this.chat});
  final Chats chat;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(
          Routes.chatView,
          arguments: ReceiverInfoModel(
            name: chat.receiverId!.name!,
            avatarUrl: chat.receiverId!.profilePic?.secureUrl ??
                AppConstants.unKnownImageTranslator,
            userId: chat.receiverId!.id!,
          ),
        );
      },
      contentPadding: EdgeInsets.zero,
      leading: AppCircleCachedNetworkImage(
        radius: 30,
        imageUrl: chat.receiverId?.profilePic?.secureUrl ??
            AppConstants.unKnownImageTranslator,
        memCacheHeight: 100,
        memCacheWidth: 100,
        maxHeightDiskCache: 200,
        maxWidthDiskCache: 200,
        cacheKey: chat.receiverId?.profilePic?.secureUrl,
      ),
      title: TitleTextWidet(
        title: chat.receiverId?.name ?? "Unknown",
        fontSize: 18,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: TitleTextWidet(
        title: chat.messages?.last.body ?? "Unknown message",
        textColor: AppColors.grey,
        fontSize: 14,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: TitleTextWidet(
        title: getChatTimeFormatted(
            context: context, time: chat.messages!.last.createdAt!),
        textColor: AppColors.grey,
        fontSize: 12,
      ),
    );
  }
}
