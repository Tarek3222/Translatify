import 'package:flutter/material.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/routing/routes.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/core/widgets/app_circle_cached_network_image.dart';
import 'package:translators/features/chat/data/models/receiver_info_model.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class CustomChatListTile extends StatelessWidget {
  const CustomChatListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(Routes.chatView,
            arguments: ReceiverInfoModel(
              name: "Tarek Ahmed",
              avatarUrl: AppConstants.unKnownImageTranslator,
              userId: "",
            ));
      },
      contentPadding: EdgeInsets.zero,
      leading: const AppCircleCachedNetworkImage(
        radius: 30,
        imageUrl: AppConstants.unKnownImageTranslator,
      ),
      title: const TitleTextWidet(
        title: "Tarek Ahmed",
        fontSize: 18,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: const TitleTextWidet(
        title: "Hello, how are you?",
        textColor: AppColors.grey,
        fontSize: 14,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const TitleTextWidet(
        title: "12:00 PM",
        textColor: AppColors.grey,
        fontSize: 12,
      ),
    );
  }
}
