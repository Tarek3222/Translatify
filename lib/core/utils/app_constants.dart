import 'package:translator/core/utils/current_user_data.dart';

bool isLoggedIn = false;

abstract class SharedPrefKeys {
  static const String kUserDataKey = 'userData';
  static const String kUserProfileKey = 'userProfile';
  static const String kTranslatorsList = 'translatorsList';
  static String kFavoritesListForUser = "${getEmailCurruntUser()}_favorites";
  static String kOrderListForUser = "${getEmailCurruntUser()}orders";
  static String kPaymnetsListForUser = "${getEmailCurruntUser()}payments";
  static String kCustomerId = "customerId";
}

abstract class AppConstants {
  static const String unKnownImageTranslator =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/960px-Unknown_person.jpg";
}
