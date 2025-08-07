// ignore_for_file: unreachable_switch_default

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/core/widgets/custom_app_icon.dart';
import 'package:translators/features/google_translate/data/models/constants.dart';
import 'package:translators/features/google_translate/data/models/suppported_language.dart';
import 'package:translators/features/google_translate/logic/google_translate_app_state.dart';
import 'package:translators/features/google_translate/ui/widgets/search_language_text_field.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

enum ChooseLanguagePageType { translateFrom, translateTo }

enum ParentPage { text, image }

class ChooseLanguagePage extends StatefulWidget {
  final ChooseLanguagePageType pageType;
  final ParentPage parentPage;
  final GoogleTranslateAppState appState;

  const ChooseLanguagePage({
    super.key,
    required this.pageType,
    required this.parentPage,
    required this.appState,
  });

  @override
  ChooseLanguagePageState createState() => ChooseLanguagePageState();
}

class ChooseLanguagePageState extends State<ChooseLanguagePage> {
  late List<SupportedLanguage> filteredLanguages;
  final List<SupportedLanguage> allLanguages = [...supportedLanguages];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.pageType == ChooseLanguagePageType.translateFrom) {
      allLanguages.insert(0, detectLanguage);
    }
    filteredLanguages = allLanguages;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = widget.appState;
    var languageFrom = appState.languageFrom;
    var languageTo = appState.languageTo;

    String pageTitle;
    SupportedLanguage selectedLanguage;
    switch (widget.pageType) {
      case ChooseLanguagePageType.translateFrom:
        pageTitle = 'Translate From';
        selectedLanguage = languageFrom;
        break;
      case ChooseLanguagePageType.translateTo:
        pageTitle = 'Translate To';
        selectedLanguage = languageTo;
        break;
      default:
        throw ArgumentError('Unhandled page type: ${widget.pageType}');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0).w,
          child: const CustomAppIcon(),
        ),
        title: TitleTextWidet(
          title: pageTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).w,
              child: SearchLanguageTextField(
                onChanged: (query) {
                  setState(() {
                    filteredLanguages = allLanguages
                        .where((language) => language.name
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.check_circle,
                color: AppColors.mainBlue,
              ),
              title: Text(
                'Selected: ${selectedLanguage.name}',
                style: getBoldStyle(
                  fontSize: 18,
                  color: AppColors.mainBlue,
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: ListView.builder(
                  itemCount: filteredLanguages.length,
                  itemBuilder: (context, index) {
                    final language = filteredLanguages[index];
                    final isSelected = language == selectedLanguage;

                    return Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.mainBlue : null,
                        borderRadius: BorderRadius.circular(
                          isSelected ? 10.0 : 0.0,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          language.name,
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? Colors.white : AppColors.grey,
                          ),
                        ),
                        onTap: () {
                          switch (widget.pageType) {
                            case ChooseLanguagePageType.translateFrom:
                              appState.changeLanguageFrom(language);
                              break;
                            case ChooseLanguagePageType.translateTo:
                              appState.changeLanguageTo(language);
                              break;
                          }
                          if (widget.parentPage == ParentPage.text) {
                            appState.triggerTranslation();
                          } else {
                            appState.translateImageDetections();
                          }
                          context.pop();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
