import 'package:e_form/config/api_service.dart';
import 'package:e_form/config/app_color.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';

class CardApprovel extends StatelessWidget {
  const CardApprovel({
    super.key,
    required this.profileApprovel,
    required this.nameApprovel,
    required this.statusApprovel,
    required this.diteruskanApprovel,
    required this.deskripsiApprovel,
    required this.lastData,
  });

  final String profileApprovel;
  final String nameApprovel;
  final String statusApprovel;
  final String diteruskanApprovel;
  final String deskripsiApprovel;
  final bool lastData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          if (!lastData)
            Transform.translate(
              offset: const Offset(29, 0),
              child: Container(
                width: 2,
                height: 170,
                color: AppColor.secondary,
              ),
            ),
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: AppColor.backgroundCard,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.mainText, width: 2)),
            child: CircleAvatar(
                backgroundImage: NetworkImage(
                    '${ApiService.baseRoot}/upload/profile/$profileApprovel')),
          ),
        ]),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Container(
            height: 150,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: AppColor.backgroundCard,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 3,
                    color: AppColor.greyColor,
                    offset: Offset(1, 2),
                  )
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextMain(
                  text: nameApprovel,
                  textFontWeight: FontWeight.bold,
                  textColor: AppColor.darkText,
                  size: 14,
                ),
                TextMain(
                  text: statusApprovel,
                  textFontWeight: FontWeight.normal,
                  textColor: AppColor.darkText,
                  size: 12,
                ),
                TextMain(
                  text: diteruskanApprovel,
                  textFontWeight: FontWeight.normal,
                  textColor: AppColor.darkText,
                  size: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  child: TextMain(
                    text: deskripsiApprovel,
                    textFontWeight: FontWeight.normal,
                    textColor: AppColor.darkText,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
