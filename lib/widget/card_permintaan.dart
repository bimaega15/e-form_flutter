import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/utils.dart';
import 'package:e_form/widget/text_main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPermintaan extends StatelessWidget {
  const CardPermintaan({
    super.key,
    required this.nameProduct,
    required this.qtyProduct,
    required this.priceProduct,
    required this.subTotalProduct,
    this.totalProduct,
    required this.descriptionProduct,
    required this.currencyProduct,
    required this.currenctCurs,
  });

  final String nameProduct;
  final String qtyProduct;
  final int priceProduct;
  final int subTotalProduct;
  final int? totalProduct;
  final String descriptionProduct;
  final String currencyProduct;
  final String currenctCurs;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.31,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColor.backgroundCard,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      offset: Offset(2, 2),
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextMain(
                        text: nameProduct,
                        textFontWeight: FontWeight.bold,
                      ),
                      TextMain(
                        text: qtyProduct,
                        textFontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextMain(
                            text: 'Harga',
                            size: 12,
                            textColor: AppColor.greyColor,
                          ),
                          TextMain(
                            text: Utils().formatMoneyCurrency(priceProduct),
                            size: 14,
                            textColor: AppColor.darkText,
                            textFontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const TextMain(
                            text: 'Sub Total',
                            size: 12,
                            textColor: AppColor.greyColor,
                          ),
                          TextMain(
                            text: Utils().formatMoneyCurrency(subTotalProduct),
                            size: 14,
                            textColor: AppColor.darkText,
                            textFontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      if (totalProduct != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const TextMain(
                              text: 'Total Harga',
                              size: 12,
                              textColor: AppColor.greyColor,
                            ),
                            TextMain(
                              text: Utils().formatMoneyCurrency(totalProduct),
                              size: 14,
                              textColor: AppColor.darkText,
                              textFontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                    ],
                  ),
                  const Divider(
                    color: AppColor.borderColor,
                    thickness: 0.2,
                  ),
                  TextMain(
                    text: descriptionProduct,
                    size: 14,
                    textColor: AppColor.darkText,
                    textFontWeight: FontWeight.w500,
                  ),
                  const Divider(
                    color: AppColor.borderColor,
                    thickness: 0.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mata Uang',
                            style: GoogleFonts.openSans(
                                fontSize: 12, color: AppColor.greyColor),
                          ),
                          TextMain(
                            text: currencyProduct,
                            size: 14,
                            textColor: AppColor.darkText,
                            textFontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Kurs',
                            style: GoogleFonts.openSans(
                                fontSize: 12, color: AppColor.greyColor),
                          ),
                          TextMain(
                            text: currenctCurs,
                            size: 14,
                            textColor: AppColor.darkText,
                            textFontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
