import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentController extends GetxController {
  final orders = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() async {
    try {
      // Ambil UID dari pengguna yang sedang login
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        // Ambil data dari sub-koleksi 'userOrders' yang berada dalam 'orders/{userId}'
        final snapshot = await FirebaseFirestore.instance
            .collection('orders') // Koleksi orders
            .doc(userId) // Akses dokumen sesuai dengan userId
            .collection('userOrders') // Sub-koleksi userOrders
            .get();

        orders.value = snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id; // Tambahkan ID dokumen untuk kebutuhan lain
          return data;
        }).toList();
      } else {
        orders.clear(); // Kosongkan orders jika tidak ada pengguna login
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengambil data order: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void cancelOrder(String orderId) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        // Hapus order berdasarkan userId dan orderId
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(userId) // Akses dokumen sesuai dengan userId
            .collection('userOrders') // Sub-koleksi userOrders
            .doc(orderId) // Hapus berdasarkan orderId
            .delete();
        fetchOrders(); // Refresh data setelah pembatalan
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal membatalkan order: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
