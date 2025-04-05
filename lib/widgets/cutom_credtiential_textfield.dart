import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parshant_app/core/constants/constants.dart';

class CredentialsTextField extends StatelessWidget {
  final String labelText;
  final bool prefixText;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;

  const CredentialsTextField({
    super.key,
    required this.labelText,
    this.prefixText = false,
    required this.textEditingController,
    this.keyboardType = TextInputType.multiline,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: keyboardType,
        controller: textEditingController,
        style: AppTextStyles.fontSize18(),
        cursorColor: AppColors.primaryColor,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9@#.₹_&+()/ ]')),
          FilteringTextInputFormatter.deny(RegExp(r'[\s]')),
        ],
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
          ),
          labelText: labelText,
          prefixText: prefixText ? '+91 ' : null,
          prefixStyle: prefixText ? AppTextStyles.fontSize18() : null,
          labelStyle: AppTextStyles.fontSize18(color: Colors.grey),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: AppColors.textBodyPart3,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: AppColors.textBodyPart1,
            ),
          ),
        ),
      ),
    );
  }
}
