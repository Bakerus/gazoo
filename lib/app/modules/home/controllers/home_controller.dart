import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gazoo/app/core/widgets/bottom_sheet.dart';
import 'package:gazoo/app/data/models/vendors.dart';
import 'package:gazoo/app/data/provider/vendors_provider.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../core/design/images.dart';

class HomeController extends GetxController {
  var userPosition = RxSet<Marker>();
  var vendorsPosition = RxSet<Marker>();
  var globalMarker = RxSet<Marker>();
  final cameraPosition = const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746)
      .obs;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  BottomSheetGen bottomSheetGen = const BottomSheetGen();
  final stateCurrentLocation = false.obs;
  final depotGazLocation = false.obs;
  LocationData? locationData;
  VendorsProvider vendorsProvider = VendorsProvider();
  List<Vendors> vendorsLists = <Vendors>[].obs;

  @override
  void onInit() async {
    super.onInit();
    getPosition();
    vendorsLists = await vendorsProvider.getAllvendors();
    depotGazDisplaying();
  }

  Future<void> getPosition() async {
    print("get position");
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.getLocation().then(
      (currentLocation) {
        if (currentLocation != null) {
          stateCurrentLocation.value = true;
          initialCameraPosition(
              latitude: currentLocation.latitude!,
              longitude: currentLocation.longitude!);
              
          customIcon(
              statut: true,
              width: 20,
              height: 20,
              assetName: "assets/images/userPosition.png",
              marker: globalMarker,
              markerId: 'userMarker',
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

  void initialCameraPosition(
      {required double latitude, required double longitude}) {
    cameraPosition.value =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 15.5);
    _goToTheCamperaPosition(cameraPosition: cameraPosition.value);
  }

  Future<void> _goToTheCamperaPosition(
      {required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void customIcon(
      {
      required bool statut, 
      required double width,
      required double height,
      required String assetName,
      required RxSet<Marker> marker,
      required String markerId,
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
        markerId: MarkerId(markerId),
        infoWindow: InfoWindow.noText,
        position: LatLng(latitude, longitude),
        icon: icon,
        onTap: () {
          if (statut == false) {
            bottomSheetGen.bottomsheetGenerator(
              name: name,
              number: number,
              place: place,
              openDate: openDate,
              openHours: openHours,
            );
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
          markerId: element.id.toString(),
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
