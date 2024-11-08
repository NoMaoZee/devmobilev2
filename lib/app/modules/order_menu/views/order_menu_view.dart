// File: lib/app/modules/order_menu/views/order_menu_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_menu_controller.dart';

class OrderMenuView extends GetView<OrderMenuController> {
  const OrderMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Order Laundry',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Animated Dropdown for Laundry Type
            GestureDetector(
              onTap: () {
                // Trigger dropdown menu opening
                showLaundryTypeDropdown(context);
              },
              child: Obx(
                () => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.selectedLaundryType.value.isEmpty
                            ? 'Tipe Laundry'
                            : controller.selectedLaundryType.value,
                        style: TextStyle(
                          color: controller.selectedLaundryType.value.isEmpty
                              ? Colors.grey
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Input for Description/Notes
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                maxLines: 5,
                onChanged: (value) => controller.setNotes(value),
                decoration: const InputDecoration(
                  hintText: 'Masukkan keterangan',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Package Selection with Animation
            const Text(
              'Pilih jenis paket',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.setPackage('Regular');
                    },
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: controller.selectedPackage.value == 'Regular'
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Regular',
                              style: TextStyle(
                                color: controller.selectedPackage.value ==
                                        'Regular'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              'Estimasi 2 Hari',
                              style: TextStyle(
                                color: controller.selectedPackage.value ==
                                        'Regular'
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.setPackage('Express');
                    },
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: controller.selectedPackage.value == 'Express'
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Express',
                              style: TextStyle(
                                color: controller.selectedPackage.value ==
                                        'Express'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              'Estimasi 1 Hari',
                              style: TextStyle(
                                color: controller.selectedPackage.value ==
                                        'Express'
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Delivery Type Selection with Animation
            const Text(
              'Pilih jenis pengantar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.setDelivery('Antar Jemput');
                    },
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: controller.selectedDelivery.value ==
                                  'Antar Jemput'
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_shipping,
                              color: controller.selectedDelivery.value ==
                                      'Antar Jemput'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Antar Jemput',
                              style: TextStyle(
                                color: controller.selectedDelivery.value ==
                                        'Antar Jemput'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.setDelivery('Jemput Aja');
                    },
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              controller.selectedDelivery.value == 'Jemput Aja'
                                  ? Colors.grey[800]
                                  : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_car,
                              color: controller.selectedDelivery.value ==
                                      'Jemput Aja'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Jemput Aja',
                              style: TextStyle(
                                color: controller.selectedDelivery.value ==
                                        'Jemput Aja'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Payment Option: Bayar Sekarang
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.validateOrder()) {
                    controller
                        .saveOrder(); // Simpan data ke Firebase dan navigasi ke pembayaran
                  } else {
                    Get.snackbar('Error', 'Please fill all fields');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Lanjutkan Pembayaran',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show Custom Laundry Type Dropdown
  void showLaundryTypeDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView(
            shrinkWrap: true,
            children: controller.laundryTypes.map((type) {
              return ListTile(
                title: Text(type),
                onTap: () {
                  controller.setLaundryType(type);
                  Navigator.pop(context); // Close the dropdown
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
