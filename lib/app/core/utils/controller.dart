import 'package:flutter/cupertino.dart';
import 'package:gazoo/app/data/models/clients.dart';
import 'package:gazoo/app/data/provider/clients_provider.dart';
import 'package:gazoo/app/modules/home/views/home_view.dart';
import 'package:gazoo/app/modules/signUp/views/sign_up_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../widgets/snackbar.dart';

class GlobalAppController extends GetxController {
  static GlobalAppController get to => Get.find();
  TextEditingController numberController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  ClientsProvider clientsProvider = ClientsProvider();
  GetStorage getStorage = GetStorage();
  final islogged = false.obs;

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
      if (GetUtils.isPhoneNumber(control.numberController.text) == false) {
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
        createAccountController();
      }
    }
  }

  Future createAccountController() async {
    Clients? clients = await clientsProvider.createAccount(
        name: firstNameController.text,
        surname: secondNameController.text,
        address: addressController.text,
        phone: numberController.text);

    if (clients != null) {
      printInfo(info: clients.toString());
      getStorage.write("name", firstNameController.text);
      islogged.value = true;
      Get.off(const HomeView());
    }
    else{
      Get.to(const SignUpView());
    }
  }
}
