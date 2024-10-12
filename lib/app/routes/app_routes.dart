// lib/app/routes/app_routes.dart
part of 'app_pages.dart';

abstract class Routes {
  static const home = '/home';
  static const phoneInput = '/phone-input';
  static const verifikasiOtp = '/verifikasi-otp';
  static const register = '/register';
  static const login = '/login';
  static const mainMenu = '/main-menu';
  static const orderMenu = '/order-menu';
  static const profile = '/profile';
  static const payment = _Paths.payment;
  static const contactPayment = _Paths.contactPayment;
  static const history = '/history';
  static const settings = '/settings';
}

abstract class _Paths {
  static const home = '/home';
  static const phoneInput = '/phone-input';
  static const verifikasiOtp = '/verifikasi-otp';
  static const register = '/register';
  static const orderMenu = '/order-menu';
  static const payment = '/payment';
  static const contactPayment = '/contact-payment';
  static const settings = '/settings';
}
