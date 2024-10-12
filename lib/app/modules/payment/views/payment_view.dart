// lib/app/modules/payment/views/payment_view.dart
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Riwayat Tagihan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildPaymentCard(
              'Budiono Siregar',
              'Cuci Custom - Express',
              'Jumat, 27 September 2024',
              'Laundry Selesai',
              '50.000',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF393E46), // Warna latar belakang
                foregroundColor: Colors.white, // Warna teks
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: controller.navigateToContactPayment,
              child: const Text('Bayar Sekarang'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Bukti Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('NOTA - 000054321'),
            const SizedBox(height: 16),
            _buildPaymentCard(
              'Dimas Gacor',
              'Cuci Custom - Regular',
              'Jumat, 27 September 2024',
              'Laundry Selesai',
              '28.000',
              isPaid: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF393E46), // Warna latar belakang
                foregroundColor: Colors.white, // Warna teks
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: controller.navigateToMainMenu,
              child: const Text('Selesai'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(
      String name, String service, String date, String status, String amount,
      {bool isPaid = false}) {
    return Card(
      color: Colors.white, // Menetapkan warna putih pada card
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(service),
            Text(date),
            Text(status),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total tagihan pembayaran'),
                Text('Rp $amount',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            if (isPaid) const SizedBox(height: 8),
            if (isPaid)
              Row(
                children: [
                  Image.asset(
                    'assets/whatsapp2.jpg',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text('Rp $amount',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
