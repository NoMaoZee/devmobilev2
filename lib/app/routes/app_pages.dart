// lib/app/routes/app_pages.dart
import 'package:devmobilev2/app/modules/main_menu/controllers/main_menu_controller.dart';
import 'package:devmobilev2/app/modules/navbar/controllers/navbar_user_controller.dart';
import 'package:devmobilev2/app/modules/navbar/views/navbar_user.dart';
import 'package:get/get.dart';
import 'package:devmobilev2/app/modules/login/views/login_view.dart';
import 'package:devmobilev2/app/modules/main_menu/views/main_menu_view.dart';
import 'package:devmobilev2/app/modules/profile/bindings/profile_bindings.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/phone_input/bindings/phone_input_binding.dart';
import '../modules/home/phone_input/views/phone_input_view.dart';
import '../modules/verifikasi_otp/bindings/verifikasi_otp_binding.dart';
import '../modules/verifikasi_otp/views/verifikasi_otp_view.dart';
import '../modules/registrasi/bindings/register_binding.dart';
import '../modules/registrasi/views/register_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/forgot_password/views/otp_view.dart';
import '../modules/forgot_password/views/create_password_view.dart';
import '../modules/forgot_password/views/password_changed_view.dart';
import '../modules/order_menu/views/order_menu_view.dart';
import '../modules/profile/views/profile_view.dart';
import 'package:devmobilev2/app/modules/payment/bindings/payment_binding.dart';
import 'package:devmobilev2/app/modules/payment/views/payment_view.dart';
import 'package:devmobilev2/app/modules/contact_payment/bindings/contact_payment_binding.dart';
import 'package:devmobilev2/app/modules/contact_payment/views/contact_payment_view.dart';
import 'package:devmobilev2/app/modules/history/views/history_view.dart';
import 'package:devmobilev2/app/modules/history/bindings/history_binding.dart';
import 'package:devmobilev2/app/modules/settings/views/settings_view.dart';
import 'package:devmobilev2/app/modules/settings/bindings/settings_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    // Route untuk Navbar
    GetPage(
      name: Routes.navbar,
      page: () => NavbarView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NavbarUserController>(() => NavbarUserController());
      }),
    ),
    // Route untuk Main Menu
    GetPage(
      name: Routes.mainMenu,
      page: () => MainMenuView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MainMenuController>(() => MainMenuController());
      }),
    ),
    // Route untuk Order Menu
    GetPage(
      name: Routes.orderMenu,
      page: () => OrderMenuView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MainMenuController>(() => MainMenuController());
      }),
    ),
    // Route lainnya
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.phoneInput,
      page: () => const PhoneInputView(),
      binding: PhoneInputBinding(),
    ),
    GetPage(
      name: _Paths.verifikasiOtp,
      page: () => const VerifikasiOtpView(),
      binding: VerifikasiOtpBinding(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.enterOtp,
      page: () => const OTPView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.createPassword,
      page: () => const CreatePasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.passwordChanged,
      page: () => const PasswordChangedView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.payment,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.contactPayment,
      page: () => const ContactPaymentView(),
      binding: ContactPaymentBinding(),
    ),
    GetPage(
      name: _Paths.history,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
  ];
}
