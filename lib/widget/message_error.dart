import 'package:e_form/config/app_color.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';

class MessageError extends StatelessWidget {
  const MessageError({
    super.key,
    this.textError,
  });

  final String? textError;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: TextMain(
            text: textError!,
            textColor: AppColor.errorColor,
            size: 12,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
