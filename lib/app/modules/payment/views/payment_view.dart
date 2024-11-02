// lib/app/modules/payment/views/payment_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          // Jika data order belum ada, tampilkan loading
          if (controller.orderData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Mendapatkan data dari orderData di controller
          final laundryType = controller.orderData['laundryType'] ?? 'Unknown';
          final servicePackage =
              controller.orderData['servicePackage'] ?? 'Unknown';
          final pickupOption =
              controller.orderData['pickupOption'] ?? 'Unknown';
          final notes = controller.orderData['notes'] ?? '';
          final price = controller.orderData['price'] ?? 0;

          // Mengubah Timestamp ke DateTime jika orderDate tersedia
          DateTime orderDate = DateTime.now();
          if (controller.orderData['orderDate'] is Timestamp) {
            orderDate =
                (controller.orderData['orderDate'] as Timestamp).toDate();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nota Pembayaran',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildPaymentCard(
                laundryType,
                servicePackage,
                pickupOption,
                notes,
                orderDate,
                price,
              ),
              const SizedBox(height: 0),
              ElevatedButton(
                onPressed: () => _showCancelConfirmationDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 27, 27, 27), // Warna hitam
                  foregroundColor: Colors.white, // Warna teks putih
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Border radius 8
                  ),
                  elevation: 4, // Efek bayangan tombol
                  padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20), // Padding untuk ukuran tombol
                ),
                child: const Text(
                  'Batal Pembayaran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // Membuat Payment Card
  Widget _buildPaymentCard(String laundryType, String servicePackage,
      String pickupOption, String notes, DateTime orderDate, int price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
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

  // Menampilkan dialog konfirmasi pembatalan
  void _showCancelConfirmationDialog(BuildContext context) {
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
                    .cancelOrder(); // Panggil fungsi untuk membatalkan pembayaran
              },
            ),
          ],
        );
      },
    );
  }
}
