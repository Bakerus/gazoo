import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../design/colors.dart';
import '../design/images.dart';
import '../design/theme.dart';

class BottomSheetGen extends StatelessWidget {
  const BottomSheetGen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future bottomsheetGenerator_2() {
    return showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return Stack(alignment: Alignment.center, children: [
          Positioned(
              child: Container(
            color: AppColors.brown,
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height / 15,
          )),
          Positioned(
            top: -25,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 28.0,
              child: Image.asset(AppImages.depotGaz),
            ),
          )
        ]);
      },
    );
  }

  Future bottomsheetGenerator() {
    return Get.bottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.58),
      backgroundColor: Colors.white,
      Column(
        children: [
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(blurRadius: 5, color: Color.fromRGBO(0, 0, 0, 0.16), spreadRadius: 2)]
                ),
                child: CircleAvatar(
                  radius: 28.0,
                  backgroundColor: Colors.white,
                  child: Image.asset(AppImages.depotGaz, width: 34, height: 34,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  "ETS GAZ_MAN",
                  style: AppTheme.ligthTheme.textTheme.headline3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.whatsapp_outlined, color: AppColors.brown),
                    Text(
                      "656704510",
                      style: AppTheme.ligthTheme.textTheme.bodyText2,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.brown,
                        ),
                        Text("Afamba",
                            style: AppTheme.ligthTheme.textTheme.bodyText2)
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: AppColors.brown,
                        ),
                        Text("Lun-Dim",
                            style: AppTheme.ligthTheme.textTheme.bodyText2)
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.timelapse_outlined,
                          color: AppColors.brown,
                        ),
                        Text(
                          "7h-8h",
                          style: AppTheme.ligthTheme.textTheme.bodyText2,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}