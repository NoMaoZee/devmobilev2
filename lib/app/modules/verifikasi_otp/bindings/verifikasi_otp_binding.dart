import 'package:get/get.dart';
import '../controllers/verifikasi_otp_controller.dart';

class VerifikasiOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifikasiOtpController>(
      () => VerifikasiOtpController(),
    );
  }
}
