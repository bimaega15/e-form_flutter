import 'package:e_form/config/app_color.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';

class TitleAndSubtitle extends StatelessWidget {
  final String title;
  final String? description;
  final IconData? icon;

  const TitleAndSubtitle({
    super.key,
    required this.title,
    this.description,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextMain(
                text: title,
                size: 16,
                textColor: AppColor.mainText,
                textFontWeight: FontWeight.bold),
            if (description != null)
              TextMain(
                text: description!,
                textColor: AppColor.darkText,
              ),
          ],
        ),
        if (icon != null)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                icon,
                color: AppColor.iconColor,
                size: 25,
              ),
            ],
          )
      ]),
    );
  }
}
