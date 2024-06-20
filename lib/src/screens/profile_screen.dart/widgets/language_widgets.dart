import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_dovie/src/global/const/colors.dart';
import 'package:provider/provider.dart';
import '../../../presentation/providers/language_change_controller.dart';

enum Language { english, azerbaijani, russian }

class AppLanguages extends StatefulWidget {
  const AppLanguages({super.key});

  @override
  State<AppLanguages> createState() => _AppLanguagesState();
}

bool status = false;
Language? selectedMenu;

class _AppLanguagesState extends State<AppLanguages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppLanguage>(
      builder: (context, provider, child) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.language,
                      size: 30,
                      color: ConstantColor.whiteColor,
                    ),
                    15.horizontalSpace,
                    Text(
                      AppLocalizations.of(context)!.applanguage.toString(),
                      style: TextStyle(
                          fontSize: 18, color: ConstantColor.whiteColor),
                    ),
                  ],
                ),
                PopupMenuButton<Language>(
                  iconColor: ConstantColor.whiteColor,
                  initialValue: selectedMenu,
                  onSelected: (Language item) {
                    if (Language.english.name == item.name) {
                      provider.changeLanguage(const Locale('en'));
                    } else if (Language.azerbaijani.name == item.name) {
                      provider.changeLanguage(const Locale('az'));
                    } else if (Language.russian.name == item.name) {
                      provider.changeLanguage(const Locale('ru'));
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<Language>>[
                    PopupMenuItem<Language>(
                        onTap: () {
                          provider.changeLanguage(const Locale('az'));
                        },
                        value: Language.azerbaijani,
                        child: Text(
                          AppLocalizations.of(context)!.az.toString(),
                          style:
                              TextStyle(color: ConstantColor.buttonColorsOne),
                        )),
                    PopupMenuItem<Language>(
                        onTap: () {
                          provider.changeLanguage(const Locale('en'));
                        },
                        value: Language.english,
                        child: Text(
                          AppLocalizations.of(context)!.en.toString(),
                          style:
                              TextStyle(color: ConstantColor.buttonColorsOne),
                        )),
                    PopupMenuItem<Language>(
                        onTap: () {
                          provider.changeLanguage(const Locale('ru'));
                        },
                        value: Language.russian,
                        child: Text(
                          AppLocalizations.of(context)!.ru.toString(),
                          style:
                              TextStyle(color: ConstantColor.buttonColorsOne),
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
