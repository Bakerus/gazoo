import 'package:flutter/material.dart';
import 'package:gazoo/app/core/utils/extensions.dart';
import 'package:gazoo/app/core/widgets/bottles_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../../modules/home/controllers/home_controller.dart';
import '../design/colors.dart';
import '../design/images.dart';
import '../design/theme.dart';

class BottomSheetGen extends StatelessWidget {
  final String name;
  final String number;
  final String place;
  final String openDate;
  final String openHours;

  const BottomSheetGen({
    super.key,
    required this.name,
    required this.number,
    required this.place,
    required this.openDate,
    required this.openHours,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Stack(alignment: AlignmentDirectional.topCenter, children: [
      BottomSheet(
        enableDrag: false,
        onClosing: () {},
        backgroundColor: Colors.transparent,
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Container(
              width: 100.0.wp,
              height: MediaQuery.of(_).size.height * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    name,
                    style: AppTheme.ligthTheme.textTheme.displaySmall!
                        .copyWith(fontSize: 13.0.sp),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                              final Uri url = Uri(
                                scheme: 'tel',
                                path: number,
                              );
                              await launchUrl(url);
                            },
                        child: Column(
                          children: [
                            Icon(Icons.phone_android_outlined,
                                size: 20.0.sp, color: AppColors.brown),
                            Text(
                              number,
                              style: AppTheme.ligthTheme.textTheme.bodyMedium!
                                  .copyWith(fontSize: 9.0.sp),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 20.0.sp,
                              color: AppColors.brown,
                            ),
                            Text(place,
                                style: AppTheme.ligthTheme.textTheme.bodyMedium!
                                    .copyWith(fontSize: 9.0.sp))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 20.0.sp,
                              color: AppColors.brown,
                            ),
                            Text(openDate,
                                style: AppTheme.ligthTheme.textTheme.bodyMedium!
                                    .copyWith(fontSize: 9.0.sp))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.timelapse_outlined,
                              size: 20.0.sp,
                              color: AppColors.brown,
                            ),
                            Text(
                              openHours,
                              style: AppTheme.ligthTheme.textTheme.bodyMedium!
                                  .copyWith(fontSize: 9.0.sp),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Caroussel
                  Obx(
                    () => controller.bottlesList.isEmpty
                        ? const SizedBox(
                            height: 280,
                            child: Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.brown, strokeWidth: 5.0)),
                          )
                        : BottlesList(bottlesList: controller.bottlesList),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 76.0.hp,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                    spreadRadius: 2)
              ]),
          child: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.white,
            child: Image.asset(
              AppImages.depotGaz,
              width: 28.0.sp,
            ),
          ),
        ),
      ),
    ]);
  }
}
