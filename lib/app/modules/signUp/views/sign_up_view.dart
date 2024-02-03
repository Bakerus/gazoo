import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/images.dart';
import 'package:gazoo/app/core/design/theme.dart';
import 'package:gazoo/app/core/widgets/textField.dart';
import 'package:gazoo/app/core/utils/controller.dart';
import 'package:get/get.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // GlobalAppController control = GlobalAppController();
    final GlobalAppController globalAppControl = Get.put(GlobalAppController());

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
      child: SizedBox(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: 120,
                        height: 133,
                        child: Image.asset(AppImages.gazooLogo)),
                    Text("Inscription",
                        style: AppTheme.ligthTheme.textTheme.headlineSmall),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFieldGen(
                        labelText: "Nom(s)",
                        textFieldController:
                            globalAppControl.firstNameController,
                      ),
                      TextFieldGen(
                        labelText: "Prénom(s)",
                        textFieldController:
                            globalAppControl.secondNameController,
                      ),
                      TextFieldGen(
                        labelText: "Adresse",
                        textFieldController: globalAppControl.addressController,
                      ),
                      TextFieldGen(
                        labelText: "Téléphone",
                        textFieldController: globalAppControl.numberController,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          globalAppControl.texFieldVerification(
                              control: globalAppControl);
                        },
                        style: AppTheme.ligthTheme.elevatedButtonTheme.style,
                        child: Text(
                          "Enregistrer",
                          style: AppTheme.ligthTheme.textTheme.labelLarge,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
