// ignore_for_file: must_be_immutable

import 'package:e_form/config/api_service.dart';
import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/helper.dart';
import 'package:e_form/config/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTransactionPagination extends StatefulWidget {
  const ListTransactionPagination({
    super.key,
    required this.dataTransaction,
    this.height = 240,
  });
  final List dataTransaction;
  final double height;

  @override
  State<ListTransactionPagination> createState() =>
      _ListTransactionPaginationState();
}

class _ListTransactionPaginationState extends State<ListTransactionPagination> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.dataTransaction.length,
        itemBuilder: (context, index) {
          if (widget.dataTransaction.isEmpty) {
            return Container();
          }

          final item = widget.dataTransaction[index];
          final gambarProfile = item["gambarProfile"] ?? "-";
          final reqBy = item["reqBy"] ?? "-";
          final purposeTransaction = item["purposeTransaction"] ?? "-";
          final reqDate = item["reqDate"] ?? DateTime.now();
          final noReq = item["noReq"] ?? "-";
          final purposeDivisi = item["purposeDivisi"] ?? "-";
          final status = item["status"] ?? "-";

          return InkWell(
            onTap: () {
              Get.toNamed(AppRoute.detail, arguments: item);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Helper().colorCard(item),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Row(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: NetworkImage(
                            '${ApiService.baseRoot}/upload/profile/$gambarProfile'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              reqBy,
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              purposeTransaction,
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: AppColor.borderColor),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              Utils().formatDateIndo(reqDate),
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: AppColor.greyColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          noReq,
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: AppColor.mainText),
                        ),
                        Text(
                          Utils().toTitleCase(purposeDivisi),
                          textAlign: TextAlign.right,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10,
                                    color: AppColor.mainText,
                                  ),
                        ),
                        Text(
                          Utils().toTitleCase(status),
                          textAlign: TextAlign.right,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                  color: AppColor.mainText),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
