import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translators/core/helpers/extensions.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/features/google_translate/data/models/constants.dart';
import 'package:translators/features/google_translate/logic/app_state.dart';
import 'package:translators/features/google_translate/ui/views/image_main_page.dart';
import 'package:translators/features/google_translate/ui/views/subpages/choose_language_page.dart';
import 'package:translators/features/google_translate/ui/views/text_main_page.dart';
import 'package:translators/features/home/ui/widgets/title_text_widet.dart';

class GoogleTranslateView extends StatefulWidget {
  const GoogleTranslateView({super.key});

  @override
  State<GoogleTranslateView> createState() => _GoogleTranslateViewState();
}

class _GoogleTranslateViewState extends State<GoogleTranslateView> {
  var selectedIndex = 0;
  late ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    var appState = context.watch<GoogleTranslateAppState>();
    var languageFrom = appState.languageFrom;
    var languageTo = appState.languageTo;
    var translatedText = appState.translatedText;

    var disableSwapButton = languageFrom == detectLanguage;
    IconData swapIcon;
    if (disableSwapButton) {
      swapIcon = Icons.arrow_right_alt;
    } else {
      swapIcon = Icons.swap_horiz;
    }

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const TextMainPage();
        break;
      case 1:
        page = const ImageMainPage();
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex!');
    }

    var mainArea = ColoredBox(
      // ignore: deprecated_member_use
      color: colorScheme.background,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      appBar: _buildAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _buildBody(mainArea);
        },
      ),
      bottomNavigationBar: _buildBottomNav(appState),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FloatingActionButton(
                heroTag: 'sourceLanguage',
                mini: true,
                onPressed: () {
                  navigateToChooseLanguagePage(
                    context,
                    ChooseLanguagePageType.translateFrom,
                    [ParentPage.text, ParentPage.image][selectedIndex],
                    appState,
                  );
                },
                tooltip: 'Pick source language',
                child: Text(
                  languageFrom.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            IconButton(
              onPressed: !disableSwapButton
                  ? () {
                      appState.swapLanguageFromAndTo();
                      if (selectedIndex == 0) {
                        appState.swapVoiceId();
                        appState.swapPrevTTSInfo();
                        appState.updateSourceText(translatedText);
                        appState.triggerTranslation();
                      }
                      if (selectedIndex == 1) {
                        appState.translateImageDetections();
                      }
                    }
                  : null,
              icon: Icon(
                swapIcon,
                color: colorScheme.secondary,
              ),
              tooltip: 'Swap',
            ),
            Expanded(
              child: FloatingActionButton(
                heroTag: 'targetLanguage',
                mini: true,
                onPressed: () {
                  navigateToChooseLanguagePage(
                    context,
                    ChooseLanguagePageType.translateTo,
                    [ParentPage.text, ParentPage.image][selectedIndex],
                    appState,
                  );
                },
                tooltip: 'Pick target language',
                child: Text(
                  languageTo.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      // backgroundColor: colorScheme.surfaceVariant,
      leading: InkWell(
        onTap: () {
          context.pop();
        },
        child: const Icon(Icons.arrow_back_ios_new),
      ),
      title: const Row(
        children: [
          Spacer(),
          Icon(
            Icons.translate,
          ),
          TitleTextWidet(
            title: "Translatify",
            textColor: AppColors.white,
            fontSize: 22,
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(Widget mainArea) {
    return Column(
      children: [
        Expanded(child: mainArea),
      ],
    );
  }

  Widget _buildBottomNav(GoogleTranslateAppState appState) {
    return SafeArea(
      child: BottomNavigationBar(
        // ignore: deprecated_member_use
        backgroundColor: colorScheme.background,
        showUnselectedLabels: false,
        unselectedItemColor: colorScheme.secondary,
        selectedItemColor: AppColors.mainBlue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Text',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_enhance),
            label: 'Image',
          ),
        ],
        // backgroundColor: colorScheme.secondary,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
          appState.clearStateWhenNavigate();
          if (value == 0) {
            // Text main page
            appState.initializeTtsVoiceIds();
          }
        },
      ),
    );
  }

  void navigateToChooseLanguagePage(
    BuildContext context,
    ChooseLanguagePageType pageType,
    ParentPage parentPage,
    GoogleTranslateAppState appState,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseLanguagePage(
          pageType: pageType,
          parentPage: parentPage,
          appState: appState,
        ),
      ),
    );
  }
}
