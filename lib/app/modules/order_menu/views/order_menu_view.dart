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
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 16, 0, 88),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhanced Animated Dropdown for Laundry Type
            Hero(
              tag: 'laundryType',
              child: Material(
                color: const Color.fromARGB(0, 2, 0, 29),
                child: GestureDetector(
                  onTap: () => showLaundryTypeDropdown(context),
                  child: Obx(
                    () => TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween<double>(
                        begin: 0,
                        end: controller.selectedLaundryType.value.isEmpty
                            ? 0
                            : 1,
                      ),
                      builder: (context, double value, child) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color.lerp(Colors.grey.shade300,
                                  Colors.blue.shade300, value)!,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.selectedLaundryType.value.isEmpty
                                    ? 'Tipe Laundry'
                                    : controller.selectedLaundryType.value,
                                style: TextStyle(
                                  color: controller
                                          .selectedLaundryType.value.isEmpty
                                      ? Colors.grey
                                      : const Color.fromARGB(255, 5, 1, 48),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Transform.rotate(
                                angle: value * 3.14159,
                                child: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Enhanced Input for Description/Notes
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 38, 1, 201).withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                maxLines: 5,
                onChanged: (value) => controller.setNotes(value),
                decoration: InputDecoration(
                  hintText: 'Masukkan keterangan',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),

            // Enhanced Package Selection
            const Text(
              'Pilih jenis paket',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.setPackage('Regular'),
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutBack,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: controller.selectedPackage.value == 'Regular'
                              ? const Color.fromARGB(255, 0, 2, 109)
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  controller.selectedPackage.value == 'Regular'
                                      ? Colors.black.withOpacity(0.3)
                                      : Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.access_time,
                              color:
                                  controller.selectedPackage.value == 'Regular'
                                      ? Colors.white
                                      : Colors.black,
                              size: 28,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Regular',
                              style: TextStyle(
                                color: controller.selectedPackage.value ==
                                        'Regular'
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Estimasi 2 Hari',
                              style: TextStyle(
                                color: controller.selectedPackage.value ==
                                        'Regular'
                                    ? Colors.white70
                                    : Colors.black54,
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
                    onTap: () => controller.setPackage('Express'),
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutBack,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: controller.selectedPackage.value == 'Express'
                              ? const Color.fromARGB(255, 12, 0, 185)
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  controller.selectedPackage.value == 'Express'
                                      ? Colors.black.withOpacity(0.3)
                                      : Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.flash_on,
                              color:
                                  controller.selectedPackage.value == 'Express'
                                      ? Colors.white
                                      : Colors.black,
                              size: 28,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Express',
                              style: TextStyle(
                                color: controller.selectedPackage.value ==
                                        'Express'
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Estimasi 1 Hari',
                              style: TextStyle(
                                color: controller.selectedPackage.value ==
                                        'Express'
                                    ? Colors.white70
                                    : Colors.black54,
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

            // Enhanced Delivery Type Selection
            const Text(
              'Pilih jenis pengantar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.setDelivery('Antar Jemput'),
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutBack,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: controller.selectedDelivery.value ==
                                  'Antar Jemput'
                              ? const Color.fromARGB(255, 3, 0, 190)
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: controller.selectedDelivery.value ==
                                      'Antar Jemput'
                                  ? Colors.black.withOpacity(0.3)
                                  : Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
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
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Antar Jemput',
                              style: TextStyle(
                                color: controller.selectedDelivery.value ==
                                        'Antar Jemput'
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
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
                    onTap: () => controller.setDelivery('Jemput Aja'),
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutBack,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              controller.selectedDelivery.value == 'Jemput Aja'
                                  ? const Color.fromARGB(255, 1, 0, 87)
                                  : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: controller.selectedDelivery.value ==
                                      'Jemput Aja'
                                  ? Colors.black.withOpacity(0.3)
                                  : Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
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
                              size: 24,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Jemput Aja',
                              style: TextStyle(
                                color: controller.selectedDelivery.value ==
                                        'Jemput Aja'
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
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

            // Enhanced Payment Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (controller.validateOrder()) {
                    controller.saveOrder();
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please fill all fields',
                      backgroundColor: Colors.red[100],
                      colorText: Colors.red[900],
                      snackPosition: SnackPosition.TOP,
                      margin: const EdgeInsets.all(16),
                      borderRadius: 12,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 4, 0, 36),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Lanjutkan Pembayaran',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLaundryTypeDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Pilih Tipe Laundry',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: controller.laundryTypes.length,
                itemBuilder: (context, index) {
                  final type = controller.laundryTypes[index];
                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 200 + (index * 50)),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        controller.setLaundryType(type);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[200]!,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              type,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Obx(() => Opacity(
                                  opacity:
                                      controller.selectedLaundryType.value ==
                                              type
                                          ? 1.0
                                          : 0.0,
                                  child: const Icon(
                                    Icons.check_circle,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
