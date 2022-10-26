import 'package:financial_app/design_sys/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      backgroundColor: AppColors.white,
      dialogBackgroundColor: AppColors.white,
      disabledColor: AppColors.lightGrey,
      dividerColor: AppColors.lightGrey,
      errorColor: AppColors.expense,
      primaryColor: AppColors.primary,
      secondaryHeaderColor: AppColors.darkGrey,
      shadowColor: AppColors.darkGrey,
      toggleableActiveColor: AppColors.primary,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.white,
          secondary: AppColors.white,
          onSecondary: AppColors.black,
          error: AppColors.expense,
          onError: AppColors.white,
          background: AppColors.white,
          onBackground: AppColors.black,
          surface: AppColors.white,
          onSurface: AppColors.black),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        unselectedItemColor: AppColors.lightGrey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: _appButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: _appButtonStyle),
      textButtonTheme: TextButtonThemeData(style: _appButtonStyle),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      cardTheme: const CardTheme(
        color: AppColors.white,
        margin: EdgeInsets.all(8.0),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.black.withOpacity(0.6),
        actionTextColor: AppColors.primary,
        disabledActionTextColor: AppColors.lightGrey,
        contentTextStyle: const TextStyle(color: AppColors.white),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      canvasColor: AppColors.black,
      backgroundColor: AppColors.black,
      dialogBackgroundColor: AppColors.black,
      disabledColor: AppColors.darkGrey,
      dividerColor: AppColors.darkGrey,
      errorColor: AppColors.expense,
      primaryColor: AppColors.primary,
      secondaryHeaderColor: AppColors.lightGrey,
      shadowColor: AppColors.darkGrey,
      toggleableActiveColor: AppColors.primary,
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primary,
          onPrimary: AppColors.black,
          secondary: AppColors.black,
          onSecondary: AppColors.white,
          error: AppColors.expense,
          onError: AppColors.black,
          background: AppColors.black,
          onBackground: AppColors.white,
          surface: AppColors.black,
          onSurface: AppColors.white),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkGrey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(style: _appButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: _appButtonStyle),
      textButtonTheme: TextButtonThemeData(style: _appButtonStyle),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.black,
      ),
      cardTheme: CardTheme(
        color: AppColors.darkGrey.withOpacity(0.3),
        margin: const EdgeInsets.all(8.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          side: BorderSide(
            color: AppColors.darkGrey,
            width: 0.5,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkGrey.withOpacity(0.6),
        actionTextColor: AppColors.primary,
        disabledActionTextColor: AppColors.lightGrey,
        contentTextStyle: const TextStyle(color: AppColors.white),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
      ),
    );
  }
}

ButtonStyle _appButtonStyle = const ButtonStyle(
  padding: MaterialStatePropertyAll(EdgeInsets.all(16.0)),
  textStyle: MaterialStatePropertyAll(
    TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.0,
    ),
  ),
  elevation: MaterialStatePropertyAll(0),
);
