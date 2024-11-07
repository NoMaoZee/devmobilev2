// lib/app/modules/payment/controllers/payment_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentController extends GetxController {
  var orderData = {}.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Tambahkan FirebaseAuth instance

  @override
  void onInit() {
    super.onInit();
    fetchOrderData();
  }

  void fetchOrderData() async {
    // Dapatkan User ID dari Firebase Authentication
    String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    if (Get.arguments != null) {
      // Jika terdapat argument dari navigasi sebelumnya, gunakan data ini
      orderData.value = Get.arguments;
      orderData['id'] = Get.arguments['id']; // Pastikan ID disimpan
    } else {
      try {
        // Ambil data order dari Firestore berdasarkan user ID
        var snapshot = await _firestore
            .collection('orders')
            .where('uid', isEqualTo: userId) // Filter berdasarkan uid pengguna
            .orderBy('orderDate', descending: true)
            .limit(1)
            .get();

        if (snapshot.docs.isNotEmpty) {
          orderData.value = snapshot.docs.first.data();
          orderData['id'] = snapshot.docs.first.id; // Simpan ID dokumen
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to fetch order data: $e');
      }
    }
  }

  // Fungsi untuk membatalkan order
  void cancelOrder() async {
    if (orderData['id'] != null) {
      try {
        await _firestore.collection('orders').doc(orderData['id']).delete();
        Get.snackbar('Pembatalan Berhasil', 'Order telah dibatalkan');
        orderData.clear();
        Get.offAllNamed('/mainMenu'); // Kembali ke menu utama
      } catch (e) {
        Get.snackbar('Error', 'Gagal membatalkan order: $e');
      }
    } else {
      Get.snackbar('Error', 'ID order tidak ditemukan');
    }
  }

  void navigateToMainMenu() {
    Get.offAllNamed('/mainMenu');
  }
}
