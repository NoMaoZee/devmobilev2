import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navbar_user_controller.dart';

class NavbarView extends StatelessWidget {
  final NavbarUserController controller = Get.put(NavbarUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: controller.pages[controller.selectedIndex.value],
          )),
      bottomNavigationBar: Container(
        height: 56,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Animated Selection Indicator
            Obx(() => AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: (MediaQuery.of(context).size.width - 32) *
                      controller.selectedIndex.value /
                      4,
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 32) / 4,
                    height: 56,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                )),
            // Navigation Items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                4,
                (index) => _buildNavItem(index, context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, BuildContext context) {
    final List<IconData> icons = [
      Icons.home_outlined,
      Icons.payment_outlined,
      Icons.history_outlined,
      Icons.settings_outlined,
    ];

    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;
      return InkWell(
        onTap: () => controller.changePage(index),
        child: SizedBox(
          width: (MediaQuery.of(context).size.width - 32) / 4,
          height: 56,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                icons[index],
                size: 24,
                color:
                    isSelected ? Colors.white : Colors.white.withOpacity(0.5),
              ),
              if (index == 1 && controller.hasUnpaidBills.value)
                Positioned(
                  right: 16,
                  top: 12,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
