// lib/app/routes/app_routes.dart
part of 'app_pages.dart';

abstract class Routes {
  static const home = _Paths.home;
  static const phoneInput = _Paths.phoneInput;
  static const verifikasiOtp = _Paths.verifikasiOtp;
  static const register = _Paths.register;
  static const login = _Paths.login;
  static const forgotPassword = _Paths.forgotPassword;
  static const enterOtp = _Paths.enterOtp;
  static const createPassword = _Paths.createPassword;
  static const passwordChanged = _Paths.passwordChanged;
  static const mainMenu = _Paths.mainMenu; // gunakan ini tanpa duplikasi
  static const orderMenu = _Paths.orderMenu;
  static const profile = _Paths.profile;
  static const payment = _Paths.payment;
  static const contactPayment = _Paths.contactPayment;
  static const history = _Paths.history;
  static const settings = _Paths.settings;
  static const navbar = _Paths.navbar;
}

abstract class _Paths {
  static const home = '/home';
  static const phoneInput = '/phone_input';
  static const verifikasiOtp = '/verifikasi_otp';
  static const register = '/register';
  static const login = '/login';
  static const forgotPassword = '/forgot_password';
  static const enterOtp = '/enter_otp';
  static const createPassword = '/create_password';
  static const passwordChanged = '/password_changed';
  static const mainMenu = '/navbar'; // ganti dari '/mainMenu' ke '/navbar'
  static const orderMenu = '/order_menu';
  static const profile = '/profile';
  static const payment = '/payment';
  static const contactPayment = '/contact_payment';
  static const history = '/history';
  static const settings = '/settings';
  static const navbar = '/navbar';
}
