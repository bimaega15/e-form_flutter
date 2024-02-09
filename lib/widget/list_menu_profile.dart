import 'package:e_form/config/app_color.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';

class ListMenuProfile extends StatelessWidget {
  const ListMenuProfile({
    super.key,
    required this.context,
    required this.icon,
    required this.label,
  });

  final BuildContext context;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: size.width,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColor.backgroundCard,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(2, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
            ),
            const SizedBox(
              width: 10,
            ),
            TextMain(
              text: label,
              size: 16,
              textFontWeight: FontWeight.bold,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(icon),
              ),
            )
          ],
        ),
      ),
    );
  }
}
