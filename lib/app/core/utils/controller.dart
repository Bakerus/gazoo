import 'package:flutter/cupertino.dart';
import 'package:gazoo/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';
import '../widgets/snackbar.dart';

class GlobalAppController extends GetxController {
  static GlobalAppController get to => Get.find();
  TextEditingController numberController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void onClose() {
    numberController.dispose();
    super.onClose();
  }

  void texFieldVerification({required GlobalAppController control}) {
    if (control.firstNameController.text.isEmpty ||
        control.secondNameController.text.isEmpty ||
        control.addressController.text.isEmpty ||
        control.numberController.text.isEmpty) {
      Snackbar.showSnackbar(
          title: "Erreur", message: "Vous avez laissé des champs vides");
    } else {
      if (GetUtils.isPhoneNumber(control.numberController.text)==false) {
        Snackbar.showSnackbar(
            title: "Erreur",
            message: "Le numero que vous avez entrez n'est pas valide");
      } else if (control.firstNameController.text.contains(RegExp(r'[0-9]'))) {
        Snackbar.showSnackbar(
            title: "Erreur",
            message: "Le nom que vous avez entrez n'est pas valide");
      } else if (control.secondNameController.text.contains(RegExp(r'[0-9]'))) {
        Snackbar.showSnackbar(
            title: "Erreur",
            message: "Le prenom que vous avez entrez n'est pas valide");
      } else if (control.addressController.text.contains(RegExp(r'[0-9]'))) {
        Snackbar.showSnackbar(
            title: "Erreur",
            message: "L'addresse que vous avez entrez n'est pas valide");
      } else {
        Get.to(HomeView());
      }
    }
  }
}
