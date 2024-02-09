import 'package:e_form/config/app_color.dart';
import 'package:e_form/widget/text_input.dart';
import 'package:flutter/material.dart';

class TextInputWithIcon extends StatelessWidget {
  const TextInputWithIcon({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor = AppColor.iconColor,
    this.size = 20,
    this.isSecureText = false,
    this.onChanged,
    this.isError = false,
  });

  final IconData icon;
  final Color? iconColor;
  final double? size;
  final String label;
  final bool? isSecureText;
  final void Function(String)? onChanged;
  final bool? isError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          icon,
          size: size,
          color: iconColor,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
          child: TextInput(
            label: label,
            isSecureText: isSecureText,
            onChanged: onChanged,
            isError: isError,
          ),
        ))
      ],
    );
  }
}
