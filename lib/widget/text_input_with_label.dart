// ignore_for_file: unnecessary_null_comparison

import 'package:e_form/config/app_color.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputWithLabel extends StatelessWidget {
  const TextInputWithLabel({
    super.key,
    required this.label,
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.typeTextInputType = TextInputType.text,
    this.textInputFormatter,
    this.isError,
    this.maxLines = 1,
    this.obscureText = false,
    this.onTapSuffixIcon,
    this.heightError = 40,
  });

  final String label;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final IconData? suffixIcon;
  final Function(String)? onChanged;
  final TextInputType typeTextInputType;
  final textInputFormatter;
  final String? isError;
  final int? maxLines;
  final bool obscureText;
  final Function()? onTapSuffixIcon;
  final double? heightError;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];
    if (textInputFormatter != null) {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        textInputFormatter
      ];
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            obscureText: obscureText,
            autofocus: true,
            textDirection: TextDirection.ltr,
            keyboardType: typeTextInputType,
            readOnly: readOnly,
            controller: controller,
            maxLines: maxLines,
            onTap: onTap,
            onChanged: onChanged,
            inputFormatters: inputFormatters.isEmpty ? null : inputFormatters,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              border: const OutlineInputBorder(),
              labelText: label,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isError != null && isError != ''
                      ? AppColor.errorColor
                      : Color(0xFF363636),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isError != null && isError != ''
                      ? AppColor.errorColor
                      : AppColor.borderColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.errorColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.errorColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: AppColor.backgroundCard,
              contentPadding:
                  const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      onPressed: onTapSuffixIcon, icon: Icon(suffixIcon))
                  : null,
            ),
          ),
          if (isError != null && isError != '')
            SizedBox(
              height: heightError,
              child: TextMain(
                  text: isError!,
                  size: 12,
                  textColor: AppColor.errorColor,
                  textFontWeight: FontWeight.w400),
            )
        ]);
  }
}
