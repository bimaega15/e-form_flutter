import 'package:e_form/config/app_color.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';

class DataTransaksi extends StatelessWidget {
  const DataTransaksi({
    super.key,
    this.titleLeft,
    this.answerLeft,
    this.answerLeftIcon,
    this.titleRight,
    this.answerRight,
    this.answerRight2,
    this.answerRight3,
  });

  final String? titleLeft;
  final String? answerLeft;
  final IconData? answerLeftIcon;
  final String? titleRight;
  final String? answerRight;
  final String? answerRight2;
  final String? answerRight3;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (titleLeft != null)
              TextMain(
                textAlign: TextAlign.left,
                text: titleLeft!,
                textColor: AppColor.greyColor,
                size: 12,
              ),
            if (answerLeft != null)
              TextMain(
                textAlign: TextAlign.left,
                text: answerLeft!,
                textColor: AppColor.darkText,
                size: 14,
              ),
            if (answerLeftIcon != null)
              Icon(
                answerLeftIcon,
                color: AppColor.secondary,
              ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (titleRight != null)
              TextMain(
                textAlign: TextAlign.left,
                text: titleRight!,
                textColor: AppColor.greyColor,
                size: 12,
              ),
            if (answerRight != null)
              TextMain(
                textAlign: TextAlign.left,
                text: answerRight!,
                textColor: AppColor.darkText,
                size: 14,
              ),
            if (answerRight2 != null)
              TextMain(
                textAlign: TextAlign.left,
                text: answerRight2!,
                textColor: AppColor.darkText,
                size: 14,
              ),
            if (answerRight3 != null)
              TextMain(
                textAlign: TextAlign.left,
                text: answerRight3!,
                textColor: AppColor.darkText,
                size: 14,
              ),
          ],
        ),
      ],
    );
  }
}
