import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/images.dart';
import 'package:gazoo/app/core/utils/extensions.dart';
import 'package:gazoo/app/core/widgets/bottom_sheet.dart';
import 'package:gazoo/app/data/models/vendors.dart';

import 'package:gazoo/app/core/design/colors.dart';
import 'package:gazoo/app/data/provider/vendors_provider.dart';
import 'package:gazoo/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class StationPopup extends StatefulWidget {
  final List<Vendors> vendorsLists;
  final String brand;

  const StationPopup({super.key, required this.vendorsLists, this.brand = ""});

  @override
  State<StationPopup> createState() => _StationPopupState();
}

class _StationPopupState extends State<StationPopup> {
  List<String> villes = ['Sangmelima', 'Meyomessala', 'Zoetele', 'Avebe Esse'];
  String selectedVille = 'Sangmelima'; // ou toute autre valeur par défaut
  var vendorsSelected;
  VendorsProvider vendorsProvider = VendorsProvider();

  List<bool> isButtonPressed = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Dialog(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.96),
      insetPadding: EdgeInsets.symmetric(horizontal: 8.0.wp, vertical: 5.0.hp),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: (widget.vendorsLists.isEmpty)
          ? const CircularProgressIndicator(
              strokeWidth: 5,
              color: AppColors.brown,
            )
          : Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 18.0.hp,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          AppImages.listeDepots,
                          width: 32.0.sp,
                        ),
                        Column(
                          children: [
                            Text(
                              'Points de ventes',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0.sp,
                              ),
                            ),
                            Text(
                              widget.brand,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 9.0.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 35.0.wp,
                          height: 3.5.hp,
                          child: DropdownButtonFormField<String>(
                            value: selectedVille,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedVille = newValue!;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 3.0.wp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.orange),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide:
                                    const BorderSide(color: Colors.orange),
                              ),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.orange,
                            ),
                            isDense: true,
                            isExpanded: true,
                            items: villes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                    child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 8.0.sp,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45.0.hp,
                    child: ListView.separated(
                      itemCount: widget.vendorsLists.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 3.0.hp),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              for (int i = 0; i < isButtonPressed.length; i++) {
                                if (i == index) {
                                  isButtonPressed[i] = !isButtonPressed[i];
                                } else {
                                  isButtonPressed[i] = false;
                                }
                              }
                              vendorsSelected = widget.vendorsLists[index];
                            });
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 3.0,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 2.2.hp),
                              height: 13.0.hp,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: isButtonPressed[index]
                                      ? Colors.orange
                                      : const Color.fromARGB(
                                          255, 255, 255, 255),
                                  width: 2, // Largeur de la bordure
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                         Icon(
                                           Icons.store,
                                           color: AppColors.brown,
                                           size: 24.0.sp,
                                         ),
                                        Text(
                                          widget.vendorsLists[index].name,
                                          textAlign: TextAlign.center,
                                          style:  TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 8.0.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                         Icon(
                                           Icons.location_pin,
                                           color: AppColors.brown,
                                           size: 24.0.sp,
                                         ),
                                        Text(
                                          widget.vendorsLists[index].address,
                                          style:  TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 8.0.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.phone_android_outlined,
                                              color: AppColors.brown,
                                              size: 24.0.sp,
                                            ),
                                            Text(
                                              widget.vendorsLists[index].phone,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 8.0.sp,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: double.infinity,
                      height: 5.0.hp,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Get.back();
                      Get.bottomSheet(
                          BottomSheetGen(
                              name: vendorsSelected.name,
                              number: vendorsSelected.phone,
                              place: vendorsSelected.address,
                              openDate: homeController
                                  .getTimetables(
                                      timeTablelist: vendorsSelected
                                          .timeTables.timeTables.length,
                                      vendor: vendorsSelected)!
                                  .split(':')
                                  .first,
                              openHours: homeController
                                  .getTimetables(
                                      timeTablelist: vendorsSelected
                                          .timeTables.timeTables.length,
                                      vendor: vendorsSelected)!
                                  .split(':')
                                  .last),
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          barrierColor: const Color.fromRGBO(0, 0, 0, 0.58));
                      homeController.bottlesList.clear();
                      homeController.idVendeur.value = vendorsSelected.id;
                      homeController.bottlesList.value = await vendorsProvider
                          .getBottleLot(id: vendorsSelected.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child:  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0.wp, vertical: 1.8.hp),
                      child: Text(
                        'Sélectionner',
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
            ),
    );
  }
}
