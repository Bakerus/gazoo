import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gazoo/app/core/widgets/bottomSheet.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../core/design/images.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final userPosition = const Marker(markerId: MarkerId('userMarker')).obs;
  final cameraPosition = const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746)
      .obs;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
      BottomSheetGen bottomSheetGen = const BottomSheetGen();
  final stateCurrentLocation = false.obs;
  LocationData? locationData;
  // final latitude = 0.0.obs;
  // final longitude = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getPosition();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getPosition() async {
    print("iniinitialPosition");

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
          print(stateCurrentLocation.value);
          print(
              "latitude:${currentLocation.latitude}, longitude:${currentLocation.longitude}");
          // latitude.value = currentLocation.latitude!;
          // longitude.value = currentLocation.longitude!;
          initialCameraPosition(
              latitude: currentLocation.latitude!,
              longitude: currentLocation.longitude!);
          customIcon(
              latitude: currentLocation.latitude!,
              longitude: currentLocation.longitude!);
        } else {
          stateCurrentLocation.value = false;
          print(stateCurrentLocation.value);
        }
      },
    );
    // // _locationData = await location.getLocation();
    // // latitude = _locationData.latitude!;
    // // longitude = _locationData.longitude!;
    // print("latitude:${latitude}, longitude:${longitude}");
    // initialCameraPosition(latitude: latitude, longitude: longitude);
    // customIcon(latitude: latitude, longitude: longitude);
  }

  void initialCameraPosition(
      {required double latitude, required double longitude}) {
    print("iniinitialCameraPosition");
    print(latitude);
    print(longitude);
    cameraPosition.value = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15.5,
    );
    print(cameraPosition.value);

    _goToTheCamperaPosition(cameraPosition: cameraPosition.value);
  }

  Future<void> _goToTheCamperaPosition(
      {required CameraPosition cameraPosition}) async {
    print("yo");
    print(cameraPosition);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void customIcon({required double latitude, required double longitude}) {
    print("customIcon");
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(25, 25)),
            AppImages.userPosition)
        .then((icon) {
      userPosition.value = Marker(
        markerId: const MarkerId('userMarker'),
        infoWindow: const InfoWindow(title: 'Vous etes ici'),
        position: LatLng(latitude, longitude),
        icon: icon,
        onTap: () { bottomSheetGen.bottomsheetGenerator(); },
      );
    });
  }
}
