// File: navbar_user_controller.dart

import 'package:devmobilev2/app/modules/history/views/history_view.dart';
import 'package:devmobilev2/app/modules/main_menu/views/main_menu_view.dart';
import 'package:devmobilev2/app/modules/payment/views/payment_view.dart';
import 'package:devmobilev2/app/modules/settings/views/settings_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavbarUserController extends GetxController {
  var selectedIndex = 0.obs;
  final RxBool hasUnpaidBills = false.obs;

  final List<Widget> pages = [
    MainMenuView(),
    PaymentView(),
    HistoryView(),
    SettingsView(),
  ];

  @override
  void onInit() {
    super.onInit();
    checkUnpaidBills();
  }

  void changePage(int index) {
    selectedIndex.value = index;
  }

  void setHasUnpaidBills(bool value) {
    hasUnpaidBills.value = value;
  }

  void checkUnpaidBills() {
    setHasUnpaidBills(true);
  }

  void clearUnpaidBillsNotification() {
    setHasUnpaidBills(false);
  }
}
