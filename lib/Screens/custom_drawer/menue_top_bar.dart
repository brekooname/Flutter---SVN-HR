import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sven_hr/localization/app_translations.dart';
import 'package:sven_hr/localization/app_translations_delegate.dart';
import 'package:sven_hr/main.dart';
import 'package:sven_hr/utilities/app_theme.dart';

import 'drawer_user_controller.dart';

class MenueTopBar extends StatefulWidget {
  final String screenName;

  MenueTopBar({@required this.screenName});

  @override
  _MenueTopBarState createState() => _MenueTopBarState();
}

class _MenueTopBarState extends State<MenueTopBar> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: AppBar().preferredSize.height,
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppTheme.kPrimaryColor.withOpacity(0.7),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Container(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                     this.widget.screenName,
                      style: TextStyle(
                        fontSize: 22,
                        color: AppTheme.nearlyWhite,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8, ),
                child: Container(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                  child: InkWell(
                    borderRadius:
                    BorderRadius.circular(AppBar().preferredSize.height),
                    child: Icon(
                      Icons.notifications,
                      color: AppTheme.nearlyWhite,
                    ),
                    onTap: () {
                      setState(() {

                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: Container(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                  child: PopupMenuButton<String>(
                    // overflow menu

                    onSelected: (language){
                      print(language);
                      newLocaleDelegate=AppTranslationsDelegate(newLocale: Locale(languagesMap[language]));
                      MyApp.setLocale(context, Locale(languagesMap[language]));
                      setState(() {

                      });
                    },
                    icon: new Icon(Icons.language, color: Colors.white),
                    itemBuilder: (BuildContext context) {
                      return languagesList
                          .map<PopupMenuItem<String>>((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void onLocaleChange(Locale locale) async {
    setState(() {
      AppTranslations.load(locale);
    });
  }
}
