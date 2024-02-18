import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.lightBlue,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.blueGrey,
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 9,
            horizontal: 16,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
          titleTextStyle: const TextStyle().copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: kColorScheme.secondaryContainer,
          ),
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            vertical: 9,
            horizontal: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 15,
              ),
            ),
      ),
      themeMode: ThemeMode.system, // Default
      home: const Expenses(),
    ),
  );
}
