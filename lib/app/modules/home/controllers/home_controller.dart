// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gazoo/app/core/widgets/bottom_sheet.dart';
import 'package:gazoo/app/data/models/bottle_lot.dart';
import 'package:gazoo/app/data/models/vendors.dart';
import 'package:gazoo/app/data/provider/vendors_provider.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../core/design/images.dart';

//  getPosition(): Cette fonction permet recuperer la position de l'utilisateur et l'affiche à l'ecran sur la map
// depotGazDisplaying(): Cette fonction permet recuperer la position des vendeurs de gaz et l'affiche à l'ecran sur la map
// Custom(): Cette fonction permet de mettre des marques(pour l'utilisateur ou les vendeurs) sur la map

class HomeController extends GetxController {
  var userPosition = RxSet<Marker>();
  var vendorsPosition = RxSet<Marker>();
  var globalMarker = RxSet<Marker>();
  var selectedBrand = "".obs;
  final cameraPosition = const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746)
      .obs;
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  final stateCurrentLocation = false.obs;
  final depotGazLocation = false.obs;
  final idVendeur = 0.obs;
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  LocationData? locationData;
  VendorsProvider vendorsProvider = VendorsProvider();
  List<Vendors> vendorsLists = <Vendors>[].obs;
  final bottlesList = RxList<BottleLot>();

  @override
  void onInit() async {
    super.onInit();
    getPosition(); // Cette fonction permet recuperer la position de l'utilisateur et l'affiche à l'ecran sur la map
    vendorsLists = await vendorsProvider.getAllvendors();
    depotGazDisplaying(); // Cette fonction permet recuperer la position des vendeurs de gaz et l'affiche à l'ecran sur la map
  }

  Future<void> getPosition() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.getLocation().then(
      (currentLocation) {
        if (currentLocation != null) {
          stateCurrentLocation.value = true;
          latitude.value = currentLocation.latitude!;
          longitude.value = currentLocation.longitude!;

          cameraPosition.value = CameraPosition(
            target: LatLng(latitude.value, longitude.value),
            zoom: 15.5,
          );

          // initialCameraPosition(
          //     latitude: currentLocation.latitude!,
          //     longitude: currentLocation.longitude!,
          //     resetCamera: true ); // Cette fonction permet de mettre la camera sur la position initial ou se trouve l'utilisateur

          customIcon(
              statut: true,
              width: 20,
              height: 20,
              assetName: "assets/images/userPosition.png",
              marker: globalMarker,
              markerId: 0,
              latitude: currentLocation.latitude!,
              longitude: currentLocation.longitude!,
              name: 'BAK',
              number: 'BAK',
              place: 'BAK',
              openDate: 'BAK',
              openHours: 'BAK');
        } else {
          stateCurrentLocation.value = false;
        }
      },
    );
  }

  // void initialCameraPosition(
  //     {required double latitude,
  //     required double longitude,
  //     bool resetCamera = false}) {
  //   print("initialCameraPosition");
  //   if (resetCamera) {
  //     cameraPosition.value = CameraPosition(target: LatLng(latitude, longitude), zoom: 15.5);
  //   }
  //   print(cameraPosition.value);
  //   goToTheCameraPosition(cameraPosition: cameraPosition.value);
  // }

  Future<void> goToTheCameraPosition({required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void customIcon(
      {required bool statut,
      required double width,
      required double height,
      required String assetName,
      required RxSet<Marker> marker,
      required int markerId,
      required double latitude,
      required double longitude,
      required String name,
      required String number,
      required String place,
      required String openDate,
      required String openHours}) {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(
                devicePixelRatio: 0.9, size: Size(width, height)),
            assetName)
        .then((icon) {
      marker.add(Marker(
        markerId: MarkerId(markerId.toString()),
        infoWindow: InfoWindow.noText,
        position: LatLng(latitude, longitude),
        icon: icon,
        onTap: () async {
          if (statut == false) {
            Get.bottomSheet(
                BottomSheetGen(
                  name: name,
                  number: number,
                  place: place,
                  openDate: openDate,
                  openHours: openHours,
                ),
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                barrierColor: const Color.fromRGBO(0, 0, 0, 0.58));
            bottlesList.clear();
            idVendeur.value = markerId;
            bottlesList.value = await vendorsProvider.getBottleLot(id: markerId);
          }
        },
      ));
    });
  }

  depotGazDisplaying() {
    vendorsLists.forEach((element) {
      int timeTablelist = element.timeTables!.timeTables.length;
      String? getTimetables() {
        for (var i = 0; i <= timeTablelist; i++) {
          if (timeTablelist == 1) {
            return "${element.timeTables!.timeTables[timeTablelist - 1].day.replaceAll('Tous les jours', '7j/7')} : ${element.timeTables!.timeTables[timeTablelist - 1].time}";
          } else {
            return "${element.timeTables!.timeTables[timeTablelist - timeTablelist].day.replaceAll('Tous les jours', '7j/7')} \n ${element.timeTables!.timeTables[timeTablelist - (timeTablelist - 1)].day.replaceAll('Tous les jours', '7j/7')}: ${element.timeTables!.timeTables[timeTablelist - timeTablelist].time} \n ${element.timeTables!.timeTables[timeTablelist - (timeTablelist - 1)].time}";
          }
        }
        return null;
      }

      customIcon(
          statut: false,
          width: 34,
          height: 34,
          assetName: AppImages.depotGazMap,
          marker: globalMarker,
          markerId: element.id,
          latitude: element.localisation!.latitude,
          longitude: element.localisation!.longitude,
          name: element.name,
          number: element.phone,
          place: element.address,
          openDate: getTimetables()!.split(':').first,
          openHours: getTimetables()!.split(':').last);
    });
    depotGazLocation.value = true;
  }
}