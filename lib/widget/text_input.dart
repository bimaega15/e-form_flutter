import 'package:e_form/config/app_color.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.label,
    this.isSecureText = false,
    this.onChanged,
    this.isError = false,
  }) : super(key: key);
  final String label;
  final bool? isSecureText;
  final void Function(String)? onChanged;
  final bool? isError;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      onChanged: onChanged,
      obscureText: isSecureText == null || isSecureText == false ? false : true,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintText: label,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isError! ? AppColor.errorColor : AppColor.borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isError! ? AppColor.errorColor : AppColor.borderColor,
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
        contentPadding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
      ),
    );
  }
}
