import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../core/design/colors.dart';
import '../../../core/utils/controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  Widget build(BuildContext context) {
    final globalAppControl = Get.put(GlobalAppController());
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
                          style: AppTheme.ligthTheme.textTheme.headline4,
                        ),
                      ),
                      Text(
                        // "latitude:${controller.latitude.value}, longitude:${controller.longitude.value}",
                         globalAppControl.firstNameController.text,
                        style: AppTheme.ligthTheme.textTheme.headline3,
                      ),

                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.795,
              width: MediaQuery.of(context).size.width * 1,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: Obx(
                    () => controller.stateCurrentLocation.value == false
                        ? const Center(child: CircularProgressIndicator(color: AppColors.brown, strokeWidth: 5.0)
                            // Text("${controller.stateCurrentLocation.value}")
                            )
                        : GoogleMap(
                            mapType: MapType.normal,
                            markers: {controller.userPosition.value},
                            initialCameraPosition:
                                controller.cameraPosition.value,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                  )),
            ),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => controller.getPosition(),
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

}
