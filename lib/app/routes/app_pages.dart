import 'package:get/get.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/signUp/bindings/sign_up_binding.dart';
import '../modules/signUp/views/sign_up_view.dart';
import '../modules/updateAccount/bindings/update_account_binding.dart';
import '../modules/updateAccount/views/update_account_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_UP;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_ACCOUNT,
      page: () => const UpdateAccountView(),
      binding: UpdateAccountBinding(),
      children: [
        GetPage(
          name: _Paths.UPDATE_ACCOUNT,
          page: () => const UpdateAccountView(),
          binding: UpdateAccountBinding(),
        ),
      ],
    ),
  ];
}
