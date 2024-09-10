import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/images.dart';
import 'package:gazoo/app/core/design/theme.dart';
import 'package:gazoo/app/core/utils/extensions.dart';
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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    final controller = Get.put(HomeController(), permanent: true);

    return Scaffold(
      extendBody: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<HomeController>(
            builder: (controller) => SizedBox(
              height: 20.0.hp,
              width: 100.0.wp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.brown,
                    child: Text(
                      "G",
                      style: AppTheme.ligthTheme.textTheme.headlineMedium!
                          .copyWith(fontSize: 20.0.sp),
                    ),
                  ),
                  Text(
                    controller.userName.isEmpty
                        ? "Chargement..."
                        : controller.userName.value,
                    style: AppTheme.ligthTheme.textTheme.displaySmall!
                        .copyWith(fontSize: 13.0.sp),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 80.0.hp,
                  width: 100.0.wp,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: ((controller.stateCurrentLocation.value == true) &&
                            ((controller.depotGazLocation.value == true) ||
                                (controller.depotGazLocationByBrand.value ==
                                    true)))
                        ? GoogleMap(
                            zoomControlsEnabled: false,
                            mapType: MapType.normal,
                            markers: controller.globalMarker,
                            initialCameraPosition:
                                controller.cameraPosition.value,
                            onMapCreated:
                                (GoogleMapController googleMapController) {
                              controller.mapController.value
                                  .complete(googleMapController);
                            },
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.brown, strokeWidth: 5.0),
                          ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3.0.hp),
                  width: 85.0.wp,
                  height: 13.5.hp,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.16), blurRadius: 2.0)
                    ],
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const MarquesPopup();
                                  },
                                );
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    AppImages.bouteilleGaz,
                                    width: 21.5.sp,
                                  ),
                                  Obx(() => Text(
                                        controller.selectedBrand
                                            .value, // Affiche la marque sélectionnée
                                        style: AppTheme
                                            .ligthTheme.textTheme.titleSmall!
                                            .copyWith(fontSize: 10.0.sp),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                controller.goToTheCameraPosition(
                                    cameraPosition:
                                        controller.cameraPosition.value);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    AppImages.userPosition,
                                    width: 34.0.sp,
                                  ),
                                  Text(
                                    "Localiser",
                                    style: AppTheme
                                        .ligthTheme.textTheme.titleSmall!
                                        .copyWith(fontSize: 10.0.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StationPopup(
                                        brand: controller.selectedBrand.value,
                                        vendorsLists: controller.vendorsLists);
                                  },
                                );
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    AppImages.listeDepots,
                                    width: 34.0.sp,
                                  ),
                                  Text(
                                    "Depots",
                                    style: AppTheme
                                        .ligthTheme.textTheme.titleSmall!
                                        .copyWith(
                                      fontSize: 10.0.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
