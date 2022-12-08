import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      dialogBackgroundColor: AppColors.white,
      disabledColor: AppColors.lightGrey,
      dividerColor: AppColors.lightGrey,
      primaryColor: AppColors.primary,
      secondaryHeaderColor: AppColors.darkGrey,
      shadowColor: AppColors.darkGrey,
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
        behavior: SnackBarBehavior.floating,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
      ),
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
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      canvasColor: AppColors.black,
      dialogBackgroundColor: AppColors.black,
      disabledColor: AppColors.lightGrey,
      dividerColor: AppColors.darkGrey,
      primaryColor: AppColors.primary,
      secondaryHeaderColor: AppColors.lightGrey,
      shadowColor: AppColors.darkGrey,
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
      textButtonTheme: TextButtonThemeData(
          style: _appButtonStyle.copyWith(
              foregroundColor:
                  const MaterialStatePropertyAll(AppColors.white))),
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
        displayLarge: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return null;
        }),
      ),
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
      appBarTheme: const AppBarTheme(
        color: AppColors.primary,
        foregroundColor: AppColors.black,
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
