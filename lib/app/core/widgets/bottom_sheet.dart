import 'package:flutter/material.dart';
import 'package:gazoo/app/core/widgets/bottles_list.dart';
import 'package:get/get.dart';


import '../../modules/home/controllers/home_controller.dart';
import '../design/colors.dart';
import '../design/images.dart';
import '../design/theme.dart';

class BottomSheetGen extends StatelessWidget {
  String name = "";
  String number = "";
  String place = "";
  String openDate = "";
  String openHours = "";

  BottomSheetGen({
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
        onClosing: () {},
        backgroundColor: Colors.transparent,
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Container(
              width: MediaQuery.of(_).size.width,
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
                    style: AppTheme.ligthTheme.textTheme.headline3,
                  ),
                  Column(
                    children: [
                      const Icon(Icons.phone_android_outlined,
                          color: AppColors.brown),
                      Text(
                        number,
                        style: AppTheme.ligthTheme.textTheme.bodyText2,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.brown,
                            ),
                            Text(place,
                                style: AppTheme.ligthTheme.textTheme.bodyText2)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: AppColors.brown,
                            ),
                            Text(openDate,
                                style: AppTheme.ligthTheme.textTheme.bodyText2)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.timelapse_outlined,
                              color: AppColors.brown,
                            ),
                            Text(
                              openHours,
                              style: AppTheme.ligthTheme.textTheme.bodyText2,
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
        bottom: MediaQuery.of(context).size.height * 0.76,
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
            radius: 28.0,
            backgroundColor: Colors.white,
            child: Image.asset(
              AppImages.depotGaz,
              width: 34,
              height: 34,
            ),
          ),
        ),
      ),
    ]);
  }
}
