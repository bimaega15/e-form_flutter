// ignore_for_file: must_be_immutable

import 'package:e_form/config/api_service.dart';
import 'package:e_form/config/app_color.dart';
import 'package:e_form/config/app_route.dart';
import 'package:e_form/config/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTransaction extends StatefulWidget {
  const ListTransaction({
    super.key,
    required this.dataTransaction,
  });
  final List dataTransaction;

  @override
  State<ListTransaction> createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: widget.dataTransaction.length,
        itemBuilder: (context, index) {
          final item = widget.dataTransaction[index];
          return InkWell(
            onTap: () {
              Get.toNamed(AppRoute.detail, arguments: item);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColor.backgroundCard,
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
                            '${ApiService.baseRoot}/upload/profile/${item['gambarProfile']}'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['reqBy'],
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            item['purposeTransaction'],
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: AppColor.borderColor),
                          ),
                          Text(
                            Utils().formatDateIndo(item['reqDate']),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                    color: AppColor.greyColor),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          Utils().toTitleCase(item['status']),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
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
