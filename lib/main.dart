import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  GetStorage getstorage = GetStorage();
  
  String initialRoute() {
    if (getstorage.read("name") != null) {
      return Routes.HOME;
    } else {
      return Routes.SIGN_UP;
    }
  }

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gazoo",
      initialRoute: initialRoute(),
      getPages: AppPages.routes,
      theme: AppTheme.ligthTheme,
    ),
  );
}
