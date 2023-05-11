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
        headline6: TextStyle(
            fontSize: 10,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w300,
            color: AppColors.white),
        headline5: TextStyle(
            fontSize: 20,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.brown),
        headline4: TextStyle(
            fontSize: 26,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.white),
        headline3: TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: AppColors.lowblack),
        bodyText1: TextStyle(
            fontSize: 10,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.brown),
        bodyText2: TextStyle(
            fontSize: 10,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.lowblack),
        subtitle1: TextStyle(
            fontSize: 16,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            color: AppColors.highblack),
        subtitle2: TextStyle(
            fontSize: 10,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            color: AppColors.lowblack),
        caption: TextStyle(
            fontSize: 12,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w300,
            color: AppColors.grey),
        button: TextStyle(
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
