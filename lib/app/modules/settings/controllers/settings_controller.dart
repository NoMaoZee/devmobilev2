import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  void logout() {
    Get.offAllNamed(Routes.login);
  }
}
