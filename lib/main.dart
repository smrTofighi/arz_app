import 'package:arz_app/bindings/binding.dart';
import 'package:arz_app/constant.dart';
import 'package:arz_app/controllers/theme_controller.dart';
import 'package:arz_app/routes/routes.dart';
import 'package:arz_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
//? Import Lib

void main() {
  runApp(const MyApp());
}
//? Main Function ------------------------

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //? MaterialApp ----------------------
    return GetMaterialApp(
      //? Localizations ------------------
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'), // Farsi, no country code
      ],
      locale: const Locale('fa', 'IR'),
      //? Theme --------------------------
      
      theme: ThemeData(
        fontFamily: 'Samim',
        //? TextTheme --------------------
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'Samim',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: kWhiteColor,
          ),
          headline2: TextStyle(
            fontFamily: 'Samim',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: kBlackColor,
          ),
          bodyText1: TextStyle(
            fontFamily: 'Samim',
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: kBlackColor,
          ),
          headline3: TextStyle(
            fontFamily: 'Samim',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: kBackGroundColor,
          ),
          headline4: TextStyle(
            fontFamily: 'Samim',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: kBlackColor,
          ),
          headline5: TextStyle(
            fontFamily: 'Samim',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: kRedColor,
          ),
          headline6: TextStyle(
            fontFamily: 'Samim',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: kGreenColor,
          ),
        ),
      ),

      //? DebugShow ---------------------
      debugShowCheckedModeBanner: false,

      getPages: Routes.pages,
      initialRoute: '/homeScreen',
      initialBinding: MyBinding(),
      //? Home --------------------------
      home: HomeScreen(),
    );
  }
}
