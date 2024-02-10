// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/colors.dart';
import '../design/theme.dart';


class TextFieldGen extends StatelessWidget {
  final String labelText;
  final TextEditingController? textFieldController;
  final TextInputType? textInputType;

  const TextFieldGen({
    super.key,
    required this.labelText,
    this.textFieldController,
    this.textInputType
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        shadowColor: const Color.fromRGBO(0, 0, 0, 0.20),
        elevation: 2.0,
        borderRadius: BorderRadius.circular(10.0),
        child: TextField(
          keyboardType: textInputType,
          controller: textFieldController,
          cursorColor: AppColors.brown,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 10.0),
              border: InputBorder.none,
              hintText: labelText,
              hintStyle: AppTheme.ligthTheme.textTheme.bodySmall),
        ),
      ),
    );
  }
}