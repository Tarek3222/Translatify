import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:translators/core/helpers/spacing.dart';
import 'package:translators/core/theme/app_colors.dart';
import 'package:translators/core/theme/app_styles.dart';
import 'package:translators/features/google_translate/logic/google_translate_app_state.dart';

class TextMainPage extends StatefulWidget {
  const TextMainPage({super.key});

  @override
  State<TextMainPage> createState() => _TextMainPageState();
}

class _TextMainPageState extends State<TextMainPage> {
  final ScrollController _firstController = ScrollController();
  final ScrollController _secondController = ScrollController();
  final TextEditingController _sourceTextController = TextEditingController();

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    _sourceTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GoogleTranslateAppState>();
    var languageFrom = appState.languageFrom;
    var languageTo = appState.languageTo;
    var sourceText = appState.sourceText;
    var translatedText = appState.translatedText;
    var suggestedLanguage = appState.suggestedLanguage;
    var ttsVoiceIdFrom = appState.ttsVoiceIdFrom;
    var ttsVoiceIdTo = appState.ttsVoiceIdTo;

    IconData speakerIcon = Icons.volume_up;
    IconData copyIcon = Icons.copy;
    IconData clearIcon = Icons.clear;

    String translationField() {
      if (translatedText.isEmpty) {
        return 'Translation';
      }
      return translatedText;
    }

    if (_sourceTextController.text != sourceText) {
      _sourceTextController.text = sourceText;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(20).w,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(languageFrom.name),
                  Row(
                    children: [
                      IconButton(
                        onPressed:
                            (sourceText.isEmpty || ttsVoiceIdFrom == null)
                                ? null
                                : () {
                                    appState.playSourceTextSpeech();
                                  },
                        icon: Icon(
                          speakerIcon,
                          color: AppColors.mainBlue,
                        ),
                        tooltip: 'Listen',
                      ),
                      IconButton(
                        onPressed: sourceText.isEmpty
                            ? null
                            : () async {
                                await Clipboard.setData(
                                    ClipboardData(text: sourceText));
                              },
                        icon: Icon(
                          copyIcon,
                          color: AppColors.mainBlue,
                        ),
                        tooltip: 'Copy',
                      ),
                      IconButton(
                        onPressed: sourceText.isEmpty
                            ? null
                            : () {
                                appState.updateSourceText('');
                                appState.triggerTranslation();
                              },
                        icon: Icon(
                          clearIcon,
                          color: AppColors.mainBlue,
                        ),
                        tooltip: 'Clear',
                      ),
                    ],
                  ),
                ],
              ),
              verticalSpacing(4),
              Container(
                constraints: const BoxConstraints(maxHeight: 175),
                child: Scrollbar(
                  controller: _firstController,
                  thickness: 2,
                  child: SingleChildScrollView(
                    controller: _firstController,
                    child: TextField(
                      controller: _sourceTextController,
                      decoration: InputDecoration(
                        hintText: 'Enter text',
                        hintStyle: getMediumStyle(
                          fontSize: 24,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      onChanged: (text) {
                        EasyDebounce.debounce('sourceTextDebouncer',
                            const Duration(milliseconds: 600), () {
                          appState.updateSourceText(text);
                          appState.triggerTranslation();
                        });
                      },
                      maxLines: null,
                      maxLength: 1000,
                      style: getMediumStyle(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
              if (suggestedLanguage != null)
                GestureDetector(
                  onTap: () {
                    appState.acceptSuggestedLanguage();
                    appState.triggerTranslation();
                  },
                  child: Card(
                    color: Colors.lightBlue,
                    child: Padding(
                      padding: const EdgeInsets.all(12).w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Translate from'),
                              Text(
                                suggestedLanguage.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 30,
                            color: AppColors.mainBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Divider(
                height: 30.h,
                thickness: 3,
                indent: 40.w,
                endIndent: 40.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(languageTo.name),
                  Row(
                    children: [
                      IconButton(
                        onPressed:
                            (translatedText.isEmpty || ttsVoiceIdTo == null)
                                ? null
                                : () {
                                    appState.playTranslatedTextSpeech();
                                  },
                        icon: Icon(speakerIcon, color: AppColors.mainBlue),
                        tooltip: 'Listen',
                      ),
                      IconButton(
                        onPressed: translatedText.isEmpty
                            ? null
                            : () async {
                                await Clipboard.setData(
                                    ClipboardData(text: translationField()));
                              },
                        icon: Icon(copyIcon, color: AppColors.mainBlue),
                        tooltip: 'Copy',
                      ),
                    ],
                  ),
                ],
              ),
              verticalSpacing(12),
              Container(
                constraints: const BoxConstraints(maxHeight: 175),
                child: Scrollbar(
                  controller: _secondController,
                  thickness: 2,
                  child: SingleChildScrollView(
                    controller: _secondController,
                    child: SelectableText(
                      translationField(),
                      // "In Flutter, resizeToAvoidBottomInset is a property that you can set on the Scaffold to control whether the Scaffold should resize when the on-screen keyboard appears. By default, resizeToAvoidBottomInset is set to true, which means the Scaffold will resize to avoid the bottom inset created by the on-screen keyboard.",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
