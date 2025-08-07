import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translators/core/utils/app_constants.dart';
import 'package:translators/features/user_profile/logic/translators_favorites_cubit/translators_favorites_cubit.dart';
import 'package:translators/features/user_profile/ui/widgets/translators_favorites_widgets/translatros_favorites_body.dart';

class TranslatorsFavoritesView extends StatelessWidget {
  const TranslatorsFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => TranslatorsFavoritesCubit()
            ..getTranslatorsFromFavorites(SharedPrefKeys.kFavoritesListForUser),
          child: const TranslatrosFavoritesBody(),
        ),
      ),
    );
  }
}
