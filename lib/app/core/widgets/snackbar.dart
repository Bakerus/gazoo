import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../design/colors.dart';
import '../design/fonts.dart';

class Snackbar extends StatelessWidget {
  const Snackbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

 static SnackbarController showSnackbar(
      {required String title, required String message}) {
    return Get.snackbar("...", "...",
        titleText: Text(
          title,
          style: const TextStyle(
              fontFamily: AppFonts.poppins,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.red),
        ),
        messageText: Text(
          message,
          style: Get.theme.textTheme.bodySmall,
        ),
        // icon: IconButton(onPressed: null, icon: Icon(Icons.close)),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 35.0, left: 10.0, right: 10.0),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1));
  }
}
