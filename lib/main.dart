import 'package:flutter/material.dart';
import 'package:gazoo/app/core/design/theme.dart';
import 'package:gazoo/app/routes/app_pages.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  GetStorage getstorage = GetStorage();

  runApp(MyApp(getstorage));
}

class MyApp extends StatelessWidget {
  final GetStorage storage;

  MyApp(this.storage);

  String initialRoute() {
    if (storage.read("name") != null) {
      return Routes.HOME;
    } else {
      return Routes.SIGN_UP;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gazoo",
      initialRoute: initialRoute(),
      getPages: AppPages.routes,
      theme: AppTheme.ligthTheme,
    );
  }
}
