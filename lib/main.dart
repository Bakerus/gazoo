import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async{
  await GetStorage.init();
  GetStorage getstorage = GetStorage();
  String initialRoute() {
  print(getstorage.read("name"));
    if (getstorage.read("name") != null) {
      return Routes.HOME;
    } else {
      return Routes.SIGN_UP;
    }
  }

  runApp(
    GetMaterialApp(  
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: initialRoute(),
      getPages: AppPages.routes,
    ),
  );
}