// lib/app/modules/history/controllers/history_controller.dart
import 'package:get/get.dart';

class HistoryController extends GetxController {
  var ongoingLaundry = [].obs; // Contoh data ongoing laundry
  var completedLaundry = [].obs; // Contoh data completed laundry
  var selectedTab = 0.obs; // Menyimpan tab yang dipilih

  void changeTab(int index) {
    selectedTab.value = index;
  }
}
