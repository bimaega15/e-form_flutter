import 'package:e_form/config/app_color.dart';
import 'package:e_form/controller/c_dashboard.dart';
import 'package:e_form/dummy/dummyHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleForm extends StatelessWidget {
  const TitleForm({
    super.key,
    required this.dummyList,
  });

  final List dummyList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CDashboard>(
        init: CDashboard(),
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: dummyList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DummyHome item = dummyList[index];
                final myStatusData = controller.getStatusData.value.toJson;
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    index == 0 ? 16 : 8,
                    5,
                    index == dummyList.length - 1 ? 16 : 8,
                    5,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {},
                      child: Container(
                        width: 150,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColor.backgroundCard,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              item.icon,
                              height: 30,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              item.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              myStatusData[item.name].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.mainText),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
