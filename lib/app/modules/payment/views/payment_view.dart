// lib/app/modules/payment/views/payment_view.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // Display a loading spinner if orders are not yet loaded
          if (controller.orders.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Display a scrollable list of payment cards for each order
          return ListView.builder(
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              var order = controller.orders[index];
              final laundryType = order['laundryType'] ?? 'Unknown';
              final servicePackage = order['servicePackage'] ?? 'Unknown';
              final pickupOption = order['pickupOption'] ?? 'Unknown';
              final notes = order['notes'] ?? '';
              final price = order['price'] ?? 0;

              DateTime orderDate = DateTime.now();
              if (order['orderDate'] is Timestamp) {
                orderDate = (order['orderDate'] as Timestamp).toDate();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPaymentCard(
                    laundryType,
                    servicePackage,
                    pickupOption,
                    notes,
                    orderDate,
                    price,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _showCancelConfirmationDialog(
                        context, order['id']), // Pass the order ID for cancel
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // Black color
                      foregroundColor: Colors.white, // White text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20), // Padding for size
                    ),
                    child: const Text(
                      'Batal Pembayaran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        }),
      ),
    );
  }

  // Create Payment Card widget
  Widget _buildPaymentCard(String laundryType, String servicePackage,
      String pickupOption, String notes, DateTime orderDate, int price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Laundry Type: $laundryType',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Service Package: $servicePackage'),
            Text('Pickup Option: $pickupOption'),
            Text('Notes: $notes'),
            Text('Order Date: ${orderDate.toLocal()}'.split(' ')[0]),
            const Divider(),
            Text(
              'Total: Rp $price',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Show confirmation dialog for order cancellation
  void _showCancelConfirmationDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Pembatalan'),
          content:
              const Text('Apakah Anda yakin ingin membatalkan pembayaran ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop();
                controller
                    .cancelOrder(orderId); // Call function to cancel order
              },
            ),
          ],
        );
      },
    );
  }
}
