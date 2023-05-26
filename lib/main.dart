import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async{
  
  await GetStorage.init();
  GetStorage getstorage = GetStorage();
  String initialRoute() {
    if (getstorage.read("name") != null) {
      print(getstorage.read("name"));
      return Routes.HOME;
    } else {
      print(getstorage.read("name"));
      return Routes.SIGN_UP;
    }
  }

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.ligthTheme,
      title: "Application",
      initialRoute: initialRoute(),
      getPages: AppPages.routes,
    ),
  );
}
