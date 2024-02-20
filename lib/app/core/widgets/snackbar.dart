import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../design/colors.dart';


class Snackbar extends StatelessWidget {
  const Snackbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

 static List<BoxShadow> boxShadows = [
  const BoxShadow(
    color: AppColors.grey, 
    offset: Offset(0, 2), 
    blurRadius: 6, 
    spreadRadius: 1, 
  ),
];

  static SnackbarController showSnackbar(
      {required String title, required String message}) {
    return Get.snackbar("...", "...",
        boxShadows: boxShadows,
        borderWidth: 1.0,
        duration: const Duration(seconds: 5),
        titleText: Text(
          title,
          style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.red),
        ),
        messageText: Text(
          message,
          style: Get.theme.textTheme.bodySmall,
        ),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 35.0, left: 10.0, right: 10.0),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1));
  }
}
