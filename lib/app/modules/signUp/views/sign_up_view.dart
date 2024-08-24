import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/colors.dart';
import 'package:gazoo/app/core/design/images.dart';
import 'package:gazoo/app/core/design/theme.dart';
import 'package:gazoo/app/core/utils/extensions.dart';
import 'package:gazoo/app/core/widgets/textField.dart';
import 'package:gazoo/app/core/utils/controller.dart';
import 'package:get/get.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});
  @override
  Widget build(BuildContext context) {

    final GlobalAppController globalAppControl = Get.put(GlobalAppController());

    return Scaffold(
      body: Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0.hp, horizontal: 6.0.wp),
      child: SizedBox(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset(
                      AppImages.gazooLogo,
                      width: 100.0.sp,
                    ),
                    Text("Inscription",
                        style: AppTheme.ligthTheme.textTheme.headlineSmall!
                            .copyWith(fontSize: 18.0.sp)),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFieldGen(
                        labelText: "Nom(s) : BAKEHE",
                        textFieldController:
                            globalAppControl.firstNameController,
                      ),
                      TextFieldGen(
                        labelText: "Prénom(s) : WILLIAM STEVE",
                        textFieldController:
                            globalAppControl.secondNameController,
                      ),
                      TextFieldGen(
                        labelText: "Adresse : Nkolnguet",
                        textFieldController: globalAppControl.addressController,
                      ),
                      TextFieldGen(
                        labelText: "Telephone : 656704510",
                        textFieldController: globalAppControl.numberController,
                        textInputType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                content: Row(
                                  children: [
                                    Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            width: 13.0.wp,
                                            height: 8.0.hp,
                                            child:
                                                const CircularProgressIndicator(
                                              strokeWidth: 3,
                                              color: AppColors.brown,
                                            ),
                                          ),
                                          Image.asset(
                                            AppImages.gazooLogo,
                                            width: 50.0.sp,
                                            fit: BoxFit.cover,
                                          )
                                        ]),
                                    Text("Creation en cours...",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.0.sp,
                                          color: Colors.grey,
                                        )),
                                  ],
                                ),
                              );
                            },
                          );

                          globalAppControl.texFieldVerification(
                              control: globalAppControl);
                        },
                        style: AppTheme.ligthTheme.elevatedButtonTheme.style,
                        child: Text(
                          "Enregistrer",
                          style: AppTheme.ligthTheme.textTheme.labelLarge!
                              .copyWith(fontSize: 10.0.sp),
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
