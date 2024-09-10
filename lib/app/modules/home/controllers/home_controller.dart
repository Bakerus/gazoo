import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gazoo/app/core/widgets/bottom_sheet.dart';
import 'package:gazoo/app/data/models/bottle_lot.dart';
import 'package:gazoo/app/data/models/vendors.dart';
import 'package:gazoo/app/data/provider/vendors_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/design/images.dart';
import '../../../core/widgets/snackbar.dart';
import '../../../data/provider/brand_provider.dart';
import '../../../data/models/brand.dart';

//  getPosition(): Cette fonction permet recuperer la position de l'utilisateur et l'affiche à l'ecran sur la map
// CustomIcon(): Cette fonction permet de mettre des marques(pour l'utilisateur ou les vendeurs) sur la map
//  depotGazByBrandDisplaying(String selectedBrand): Cette fonction permet d'afficher tous les vendeurs ou les vendeurs possedants une marque de gaz X
// goToTheCameraPosition(CameraPosition cameraPosition) : Cette fonction permet de deplcer la camera au niveau de la position de l'utilisateur
// removeMarkerById(MarkerId markerId) : Cette fonction permet de retirer les markers des vendeurs sur la carte
// fetchBrands() : Cette fonction permet de recuperer la liste des marques de gaz venduesP
// getTimetables({required int timeTablelist, required Vendors vendor}) : Cette fonction permet de remplacer le mot "tous les jour" par 7j/7 sur le BottomSheet

class HomeController extends GetxController {
  final globalMarker = <Marker>{}.obs;
  final cameraPosition =
      const CameraPosition(target: LatLng(37.4, -122.0), zoom: 15.0).obs;
  final stateCurrentLocation = false.obs;
  final depotGazLocation = false.obs;
  final depotGazLocationByBrand = false.obs;
  final idVendeur = 0.obs;
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final bottlesList = RxList<BottleLot>();
  final mapController = Completer<GoogleMapController>().obs;

  VendorsProvider vendorsProvider = VendorsProvider();
  List<Vendors> vendorsLists = <Vendors>[].obs;
  var brandList = <Brand>[].obs;
  var isLoading = true.obs;
  var selectedBrand = "".obs;
  int timeTablelist = 0;
  final userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    depotGazByBrandDisplaying("");
  }

  @override
  void onReady() {
    super.onInit();
    getPosition();
    getUserName();
  }

  void getUserName() {
    try {
      final storage = GetStorage();
      userName.value = storage.read("name").toString().toUpperCase();
      update(); // Notifie le GetBuilder de mettre à jour l'UI
    } catch (e) {
      Snackbar.showSnackbar(title: "Erreur", message: "user: $e");
    }
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
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Vérifie si le service de localisation est activé
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Si le service de localisation n'est pas activé, affiche une erreur ou une action à l'utilisateur
        return;
      }

      // Vérifie les permissions de localisation
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          // Les permissions sont refusées de manière permanente
          return;
        }
      }

      // Si la permission est accordée, récupère la position de l'utilisateur
      Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Met à jour les variables d'état avec la position de l'utilisateur
      stateCurrentLocation.value = true;
      latitude.value = currentPosition.latitude;
      longitude.value = currentPosition.longitude;

      // Définit la position de la caméra sur la carte
      cameraPosition.value = CameraPosition(
        target: LatLng(latitude.value, longitude.value),
        zoom: 15.5,
      );

      // Appelle la fonction pour afficher l'icône de l'utilisateur sur la carte
      customIcon(
        statut: true,
        width: 20,
        height: 20,
        assetName: "assets/images/userPosition.png",
        marker: globalMarker,
        markerId: 0,
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
        name: '',
        number: '',
        place: '',
        openDate: '',
        openHours: '',
      );
    } catch (e) {
      print('Erreur lors de la récupération de la position : $e');
      Snackbar.showSnackbar(title: "Erreur", message: "$e");
      return;
    }
  }

  Future<void> goToTheCameraPosition(
      {required CameraPosition cameraPosition}) async {
    final GoogleMapController controller = await mapController.value.future;
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
        openDate: getTimetables(timeTablelist: timeTablelist, vendor: vendor)!
            .split(':')
            .first,
        openHours: getTimetables(timeTablelist: timeTablelist, vendor: vendor)!
            .split(':')
            .last,
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
