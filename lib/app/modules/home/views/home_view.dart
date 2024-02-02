import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/images.dart';
import 'package:gazoo/app/core/design/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../core/design/colors.dart';
import 'package:flutter/services.dart';
import '../controllers/home_controller.dart';
import 'station_popup.dart';
import 'marques_popup.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    GetStorage getstorage = GetStorage();
    final controller = Get.put(HomeController());
    

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 45.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.brown,
                        child: Text(
                          "G",
                          style: AppTheme.ligthTheme.textTheme.headlineMedium,
                        ),
                      ),
                      Text(
                        getstorage.read("name"),
                        style: AppTheme.ligthTheme.textTheme.displaySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Obx(
              () => Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.795,
                    width: MediaQuery.of(context).size.width * 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: (((controller.stateCurrentLocation.value==true) && (controller.depotGazLocation.value == true )) || (controller.vendorsLists.isNotEmpty) )
                          ? GoogleMap(
                              zoomControlsEnabled: false,
                              mapType: MapType.normal,
                              markers: controller.globalMarker,
                              initialCameraPosition:
                                  controller.cameraPosition.value,
                              onMapCreated: (GoogleMapController googleMapController) {
                                controller.mapController.complete(googleMapController);
                              },
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.brown, strokeWidth: 5.0),
                            ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.16),
                            blurRadius: 2.0)
                      ],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const MarquesPopup();
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                AppImages.bouteilleGaz,
                                width: 41.0,
                                height: 41.0,
                              ),
                              Obx(() => Text(
                              controller.selectedBrand.value, // Affiche la marque sélectionnée
                              style: AppTheme.ligthTheme.textTheme.titleSmall,
                             ))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.goToTheCameraPosition(
                                cameraPosition:controller.cameraPosition.value);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                AppImages.userPosition,
                                width: 41.0,
                                height: 41.0,
                              ),
                              Text(
                                "Localiser",
                                style: AppTheme.ligthTheme.textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StationPopup(
                                    vendorsLists: controller.vendorsLists);
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                AppImages.listeDepots,
                                width: 41.0,
                                height: 41.0,
                              ),
                              Text(
                                "station tradex",
                                style: AppTheme.ligthTheme.textTheme.titleSmall,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}