import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/images.dart';
import 'package:gazoo/app/core/utils/extensions.dart';
import 'package:gazoo/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/design/colors.dart';

class MarquesPopup extends StatefulWidget {
  const MarquesPopup({super.key});

  @override
  State<MarquesPopup> createState() => _MarquesPopupState();
}

class _MarquesPopupState extends State<MarquesPopup> {
  int selectedIndex = 0;
  String selectedBrand = "";
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController
        .fetchBrands(); // Appel de la méthode pour récupérer les données
    // Initialisation de la variable selectedBrand avec la première marque
    selectedBrand = homeController.brandList.isNotEmpty
        ? homeController.brandList[0].brandName
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.96),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Obx(() => (homeController.isLoading.value)
          ? const Center(
              child: CircularProgressIndicator(
                  color: AppColors.brown, strokeWidth: 5.0))
          : Container(
              height: 50.0.hp,
              padding: EdgeInsets.symmetric(vertical: 4.0.hp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    AppImages.bouteilleGaz,
                    width: 28.0.sp,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    'Marques disponibles',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.lowblack,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.0.sp,
                    ),
                  ),
                  SizedBox(
                    height: 15.0.hp,
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      diameterRatio: 1.5,
                      offAxisFraction: -0.05,
                      physics: const FixedExtentScrollPhysics(),
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (BuildContext context, int index) {
                          final isSelected = selectedIndex == index;
                          final fontSize = isSelected ? 13.0 : 9.0;
                          final scale = isSelected ? 1.2 : 1.0;
                          final marqueName =
                              homeController.brandList[index].brandName;
                          return Center(
                            child: Container(
                              decoration: isSelected
                                  ? BoxDecoration(
                                      border: Border.all(
                                        color: Colors.orange,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                    )
                                  : null,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(
                                    horizontal: 8.0.wp),
                                child: Transform.scale(
                                  scale: scale,
                                  child: Text(
                                    marqueName,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: fontSize.sp,
                                      fontWeight: FontWeight.w400,
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: homeController.brandList.length,
                      ),
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          selectedIndex = index;
                          selectedBrand = homeController.brandList[index]
                              .brandName; // Mise à jour de la marque sélectionnée
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      homeController.selectedBrand.value =
                          selectedBrand; // Met à jour la marque sélectionnée dans HomeController
                      homeController.removeMarkerById(const MarkerId("0"));
                      homeController.depotGazByBrandDisplaying(selectedBrand);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0.wp, vertical: 1.8.hp),
                      child: Text(
                        'Selectionner',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
    );
  }
}
