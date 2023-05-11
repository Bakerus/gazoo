import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/colors.dart';
import 'package:gazoo/app/core/utils/controller.dart';
import 'package:get/get.dart';
import '../../../core/design/theme.dart';
import '../../../core/widgets/textField.dart';
import '../controllers/update_account_controller.dart';

class UpdateAccountView extends GetView<UpdateAccountController> {
  const UpdateAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final globalAppControl = Get.put(GlobalAppController());

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.brown,
                          child: Text(
                            "G",
                            style: AppTheme.ligthTheme.textTheme.headline4,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40.0, horizontal: 15.0),
                          child: Text(
                              globalAppControl.firstNameController.text,
                            style: AppTheme.ligthTheme.textTheme.headline3,
                          ),
                        )
                      ],
                    ),
                    Text("Modifier mes informations",
                        style: AppTheme.ligthTheme.textTheme.headline5),
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
                        onPressed: (() {
                          globalAppControl.texFieldVerification(
                              control: globalAppControl);
                        }),
                        style: AppTheme.ligthTheme.elevatedButtonTheme.style,
                        child: Text(
                          "Enregistrer",
                          style: AppTheme.ligthTheme.textTheme.button,
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
