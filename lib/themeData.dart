import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFFFCF4F1),
      indicatorColor: Colors.black,
      segmentedButtonTheme: const SegmentedButtonThemeData(
          style: ButtonStyle(
              side: MaterialStatePropertyAll(BorderSide(color: Colors.black)))),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.black))),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.black),
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              side: MaterialStatePropertyAll(BorderSide(color: Colors.black)))),
      appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.black),
      tabBarTheme: const TabBarTheme(labelColor: Colors.black),
      listTileTheme: ListTileThemeData(tileColor: Colors.blueGrey[100]),
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.grey),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: Colors.black,
        hintStyle: const TextStyle(color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(0),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
      ),
      fontFamily: "SpaceGrotesk",
      textTheme: Typography().black,
      primaryTextTheme: Typography().black);
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Color(0xff141414),
      indicatorColor: Colors.white,
      appBarTheme: AppBarTheme(foregroundColor: Colors.white),
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: Colors.blueGrey),
      iconTheme: IconThemeData(color: Colors.white),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Color(0xff1B1B1B),
      ),
      dialogBackgroundColor: Color(0xff252525),
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.grey),
      popupMenuTheme: PopupMenuThemeData(color: Color(0xff1f1f1f)),
      segmentedButtonTheme: SegmentedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.white;
                }
                return Color(0xff1B1B1B);
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.selected)) {
                return Color(0xff1B1B1B);
              } else {
                return Colors.white;
              }
            }),
            overlayColor: MaterialStatePropertyAll(Color(0xffffffff)),
          ),
          selectedIcon: null),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.white))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xff111111)),
              side: MaterialStatePropertyAll(BorderSide(color: Colors.white)))),
      listTileTheme: ListTileThemeData(
          tileColor: Color(0xff252525),
          textColor: Colors.white,
          iconColor: Colors.grey[400]),
      inputDecorationTheme: InputDecorationTheme(
        suffixIconColor: Colors.white,
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(0),
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
      fontFamily: "SpaceGrotesk",
      textTheme: Typography().white,
      primaryTextTheme: Typography().white);
}
