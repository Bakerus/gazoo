import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/colors.dart';

class AppTheme {
  static final ligthTheme = ThemeData(
    fontFamily: "Poppins",
    iconTheme: const IconThemeData(
      color: AppColors.brown,
      size: 8,
    ),
    textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 8,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w300,
            color: AppColors.lowblack),
        headlineSmall: TextStyle(
            fontSize: 20,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.brown),
        headlineMedium: TextStyle(
            fontSize: 26,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.white),
        displaySmall: TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: AppColors.lowblack),
        bodyLarge: TextStyle(
            fontSize: 10,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.brown),
        bodyMedium: TextStyle(
            fontSize: 10,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.lowblack),
        titleMedium: TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.highblack),
        titleSmall: TextStyle(
            fontSize: 10,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            color: AppColors.lowblack),
        bodySmall: TextStyle(
            fontSize: 12,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w300,
            color: AppColors.grey),
        labelLarge: TextStyle(
            fontSize: 12,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.white)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 15, horizontal: 80)),
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.brown),
          foregroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFFFFFFFF)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              // side: BorderSide(width: 1.0, color: AppColors.greenMaterial[900]!),
              borderRadius: BorderRadius.circular(25.0),
            ),
          )),
    ),
  );
}
