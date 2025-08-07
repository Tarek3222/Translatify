import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/home/data/models/translator_response_model.dart';
import 'package:translators/features/user_profile/data/data_source/local_data_source/favorites_translators_local_date_source.dart';

class AddToFavoriteIconButton extends StatefulWidget {
  const AddToFavoriteIconButton(
      {super.key, required this.translatorProfileModel});
  final TranslatorProfileModel translatorProfileModel;

  @override
  State<AddToFavoriteIconButton> createState() =>
      _AddToFavoriteIconButtonState();
}

class _AddToFavoriteIconButtonState extends State<AddToFavoriteIconButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    String keyFavorite = SharedPrefKeys.kFavoritesListForUser;
    String translatorId = widget.translatorProfileModel.translator!.first.id!;
    isFavorite = FavoritesTranslatorsLocalDateSource.isTranslatorInFavorites(
        keyFavorite, translatorId);
    return InkWell(
      onTap: () async {
        if (isFavorite) {
          await FavoritesTranslatorsLocalDateSource
              .deleteTranslatorFromFavorites(keyFavorite, translatorId);
          setState(() {
            !isFavorite;
          });
        } else {
          await FavoritesTranslatorsLocalDateSource.addTranslatorToFavorites(
              keyFavorite, widget.translatorProfileModel);
          setState(() {
            !isFavorite;
          });
        }
      },
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: AppColors.mainBlue,
        size: 30.sp,
      ),
    );
  }
}
