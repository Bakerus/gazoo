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
import '../../../data/provider/brand_provider.dart';
import '../../../data/models/brand.dart';

//  getPosition(): Cette fonction permet recuperer la position de l'utilisateur et l'affiche à l'ecran sur la map
// Custom(): Cette fonction permet de mettre des marques(pour l'utilisateur ou les vendeurs) sur la map
//  depotGazByBrandDisplaying(String selectedBrand): Cette fonction permet d'afficher tous les vendeurs ou les vendeurs possedants une marque de gaz X
class HomeController extends GetxController {
  final globalMarker = <Marker>{}.obs;
  final cameraPosition = const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746)
      .obs;
  final stateCurrentLocation = false.obs;
  final depotGazLocation = false.obs;
  final depotGazLocationByBrand = false.obs;
  final idVendeur = 0.obs;
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final bottlesList = RxList<BottleLot>();
  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  GoogleMapController? test;
  LocationData? locationData;
  VendorsProvider vendorsProvider = VendorsProvider();
  List<Vendors> vendorsLists = <Vendors>[].obs;
  var brandList = <Brand>[].obs;
  var isLoading = true.obs;
  var selectedBrand = "".obs;
  int timeTablelist = 0;
  // late Vendors vendors;

  @override
  void onInit() {
    super.onInit();
    getPosition();
    depotGazByBrandDisplaying("");
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
            bottlesList.value =
                await vendorsProvider.getBottleLot(id: markerId);
          }
        },
      ));
    });
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
        stateCurrentLocation.value = true;
        latitude.value = currentLocation.latitude!;
        longitude.value = currentLocation.longitude!;

        cameraPosition.value = CameraPosition(
          target: LatLng(latitude.value, longitude.value),
          zoom: 15.5,
        );

        customIcon(
            statut: true,
            width: 20,
            height: 20,
            assetName: "assets/images/userPosition.png",
            marker: globalMarker,
            markerId: 0,
            latitude: currentLocation.latitude!,
            longitude: currentLocation.longitude!,
            name: '',
            number: '',
            place: '',
            openDate: '',
            openHours: '');
      },
    );
  }

  Future<void> goToTheCameraPosition(
      {required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  String? getTimetables({required int timeTablelist, required Vendors vendor}) {
    if (timeTablelist == 1) {
      return "${vendor.timeTables!.timeTables[timeTablelist - 1].day.replaceAll('Tous les jours', '7j/7')} : ${vendor.timeTables!.timeTables[timeTablelist - 1].time}";
    } else {
      return "${vendor.timeTables!.timeTables[timeTablelist - timeTablelist].day.replaceAll('Tous les jours', '7j/7')} \n ${vendor.timeTables!.timeTables[timeTablelist - (timeTablelist - 1)].day.replaceAll('Tous les jours', '7j/7')}: ${vendor.timeTables!.timeTables[timeTablelist - timeTablelist].time} \n ${vendor.timeTables!.timeTables[timeTablelist - (timeTablelist - 1)].time}";
    }
  }

  depotGazByBrandDisplaying(String selectedBrand) async {
    if (selectedBrand != "") {
      vendorsLists = await vendorsProvider.getByBrand(brandName: selectedBrand);
      depotGazLocation.value = false;
      if (depotGazLocationByBrand.value == true) {
        depotGazLocationByBrand.value = false;
      }
      depotGazLocationByBrand.value = true;
    } else {
      vendorsLists = await vendorsProvider.getAllvendors();
      depotGazLocation.value = true;
    }

    for (var vendor in vendorsLists) {
       timeTablelist = vendor.timeTables!.timeTables.length;
      //  vendors = vendor;
      customIcon(
        statut: false,
        width: 34,
        height: 34,
        assetName: AppImages.depotGazMap,
        marker: globalMarker,
        markerId: vendor.id,
        latitude: vendor.localisation!.latitude,
        longitude: vendor.localisation!.longitude,
        name: vendor.name,
        number: vendor.phone,
        place: vendor.address,
        openDate: getTimetables(timeTablelist: timeTablelist, vendor: vendor)!.split(':').first,
        openHours: getTimetables(timeTablelist: timeTablelist, vendor: vendor)!.split(':').last,
      );
    }
  }

  void removeMarkerById(MarkerId markerId) {
    globalMarker.removeWhere((marker) => marker.markerId != markerId);
  }

  Future<void> fetchBrands() async {
    try {
      final List<Brand> brands = await BrandProvider().getAllBrands();
      brandList.assignAll(brands);
      brandList.insert(0, Brand(brandName: "", bottleImage: ""));
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
    }
  }
}
