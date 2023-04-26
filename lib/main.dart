import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

Icon iconThemeMode = Icon(CupertinoIcons.sun_max);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale = Locale("en");
  ThemeMode themeMode = ThemeMode.dark;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var surfaceColor = Color(0xdffffff);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('fa'), // Persian
      ],
      locale: locale,
      debugShowCheckedModeBanner: false,

      theme: themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(locale.languageCode)
          : MyAppThemeConfig.light().getTheme(locale.languageCode),
      home: MyHomePage(
        selectedLanguage: (Language newLanguage){
          setState(() {
            locale= newLanguage==Language.en ? Locale("en"):Locale("fa");
          });
        },
        toggleThemeMode: () {
          setState(() {
            if (themeMode == ThemeMode.dark) {
              themeMode = ThemeMode.light;
              iconThemeMode = Icon(CupertinoIcons.moon);
            } else {
              themeMode = ThemeMode.dark;
              iconThemeMode = Icon(CupertinoIcons.sun_max);
            }
          });
        },
      ),
      title: 'Flutter Demo',
      // theme:
    );
  }
}

class MyAppThemeConfig {
  final Color primaryColor = Colors.pink.shade400;
  final Color textColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color appbarColor;
  final Brightness brightnes;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        textColor = Colors.white,
        secondaryTextColor = Colors.white70,
        backgroundColor = Color.fromARGB(255, 30, 30, 30),
        surfaceColor = Color(0x0dffffff),
        appbarColor = Colors.black,
        brightnes = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        textColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
        backgroundColor = Colors.white,
        surfaceColor = Color(0x0d00000),
        appbarColor = Color.fromARGB(255, 235, 235, 235),
        brightnes = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
      fontFamily: "lato",
      brightness: brightnes,
      primaryColor: primaryColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor)),
      ),
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          )),
      dividerColor: surfaceColor,
      scaffoldBackgroundColor: backgroundColor,
      textTheme: languageCode == "en" ? enPrimaryTextTheme : faPrimaryTextTheme,
      // dividerColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: appbarColor,
        foregroundColor: textColor,
      ),
    );
  }

  TextTheme get enPrimaryTextTheme =>
      (TextTheme(
        bodyText1: TextStyle(
            fontSize: 15,
            color: primaryTextColor,
            fontFamily: "lato",
            fontWeight: FontWeight.w700,
            height: 1.2),
        bodyText2: TextStyle(
            fontSize: 15,
            color: secondaryTextColor,
            fontFamily: "lato",
            fontWeight: FontWeight.w100),
        headline1: TextStyle(
            fontSize: 15,
            color: primaryTextColor,
            fontFamily: "lato",
            fontWeight: FontWeight.w700),
        subtitle1: TextStyle(
          fontSize: 15,
          color: primaryTextColor,
          fontFamily: "lato",
        ),
        caption: TextStyle(
          fontSize: 10,
          color: primaryTextColor,
          fontFamily: "lato",
        ),
      ));

  TextTheme get faPrimaryTextTheme =>
      (TextTheme(
        bodyText1: TextStyle(
            fontSize: 15,
            color: primaryTextColor,
            fontFamily: "iran",
            fontWeight: FontWeight.w700,
            height: 1.5),
        bodyText2: TextStyle(
          fontSize: 13,
          color: secondaryTextColor,
          fontFamily: "iran",
        ),
        headline1: TextStyle(
            fontSize: 15,
            color: primaryTextColor,
            fontFamily: "iran",
            fontWeight: FontWeight.bold),
        subtitle1: TextStyle(
            fontSize: 15,
            color: primaryTextColor,
            fontFamily: "iran",
            fontWeight: FontWeight.bold),
      ));
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(Language language) selectedLanguage;

  const MyHomePage({super.key, required this.toggleThemeMode, required this.selectedLanguage});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum SkillType { photoshop, xd, illiustrator, afterEffect, lightRoom }

class _MyHomePageState extends State<MyHomePage> {
  Language language = Language.en;
  SkillType skill = SkillType.photoshop;

  void updateSkillType(SkillType skillType) {
    setState(() {
      this.skill = skillType;
    });
    // this.skill = skillType;
  }

  void updateLanguage(Language language){
    setState(() {
      widget.selectedLanguage(language);
      this.language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(

      appBar: AppBar(
        title: Text(localization.profileTitle),
        actions: [
          Icon(CupertinoIcons.chat_bubble),
          SizedBox(
            width: 15,
          ),
          InkWell(onTap: widget.toggleThemeMode, child: iconThemeMode),
          SizedBox(
            width: 10,
          ),
          Icon(CupertinoIcons.ellipsis_vertical),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        "assets/images/profile_image.png",
                        width: 80,
                        height: 80,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(localization.name,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle1),
                          SizedBox(
                            height: 2,
                          ),
                          Text(localization.job,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.location,
                                size: 16,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                localization.location,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Icon(
                      CupertinoIcons.heart,
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: Text(
                  localization.summary,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText2,
                ),
              ),
              Divider(thickness: 2),

              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localization.selectedLanguage , style: Theme.of(context).textTheme.subtitle1,),
                    CupertinoSlidingSegmentedControl<Language>(
                      groupValue: language,
                        children: {
                          Language.en:Text(localization.enLanguage),
                          Language.fa:Text(localization.faLanguage),
                        },
                      onValueChanged: (value) {
                        if (value != null) updateLanguage(value);
                      }

                    ),
                  ],
                ),
              ),
              Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      localization.skills,
                      style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1,
                    ),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 15,
                    ),
                  ],
                ),
              ),
              Wrap(
                direction: Axis.horizontal,
                children: [
                  SkillsItem(
                    title: "PhotoShop",
                    isActive: skill == SkillType.photoshop,
                    path: "assets/images/app_icon_01.png",
                    shadowColor: Colors.blue.shade500,
                    skillType: SkillType.photoshop,
                    onTap: () {
                      updateSkillType(SkillType.photoshop);
                    },
                  ),
                  SkillsItem(
                    title: "Addobe XD",
                    isActive: skill == SkillType.xd,
                    path: "assets/images/app_icon_05.png",
                    shadowColor: Colors.pink.shade300,
                    skillType: SkillType.xd,
                    onTap: () {
                      updateSkillType(SkillType.xd);
                    },
                  ),
                  SkillsItem(
                    title: "Illustrator",
                    isActive: skill == SkillType.illiustrator,
                    path: "assets/images/app_icon_04.png",
                    shadowColor: Colors.deepOrangeAccent,
                    skillType: SkillType.illiustrator,
                    onTap: () {
                      updateSkillType(SkillType.illiustrator);
                    },
                  ),
                  SkillsItem(
                    title: "AfterEffect",
                    isActive: skill == SkillType.afterEffect,
                    path: "assets/images/app_icon_03.png",
                    shadowColor: Colors.blue.shade700,
                    skillType: SkillType.afterEffect,
                    onTap: () {
                      updateSkillType(SkillType.afterEffect);
                    },
                  ),
                  SkillsItem(
                    title: "LightRoom",
                    isActive: skill == SkillType.lightRoom,
                    path: "assets/images/app_icon_02.png",
                    shadowColor: Colors.blue.shade900,
                    skillType: SkillType.afterEffect,
                    onTap: () {
                      updateSkillType(SkillType.lightRoom);
                    },
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localization.personalInformation,
                      style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: localization.email,
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        prefixIcon: Icon(CupertinoIcons.at),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        labelText: localization.password,
                        prefixIcon: Icon(CupertinoIcons.lock),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          localization.save,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkillsItem extends StatelessWidget {
  final SkillType skillType;
  final String title;

  final String path;

  final bool isActive;
  final Color shadowColor;
  final Function() onTap;

  const SkillsItem({
    Key? key,
    required this.skillType,
    required this.title,
    required this.path,
    required this.isActive,
    required this.shadowColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: isActive
            ? BoxDecoration(
          color: Theme
              .of(context)
              .dividerColor,
          borderRadius: BorderRadius.circular(16),
        )
            : null,
        width: 110,
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: isActive
                  ? BoxDecoration(boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 20,
                )
              ])
                  : null,
              child: Image.asset(
                path,
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}

enum Language{
  fa,
  en
}