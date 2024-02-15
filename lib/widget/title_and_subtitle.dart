import 'package:e_form/config/app_color.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';

class TitleAndSubtitle extends StatelessWidget {
  final String title;
  final String? description;
  final IconData? icon;
  final double padding;
  final Function()? onPressedIcon;

  const TitleAndSubtitle({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.padding = 16,
    this.onPressedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
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
              IconButton(
                  onPressed: onPressedIcon,
                  icon: Icon(
                    icon,
                    color: AppColor.iconColor,
                    size: 25,
                  )),
            ],
          )
      ]),
    );
  }
}
