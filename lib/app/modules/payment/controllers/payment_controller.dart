import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../modules/navbar/controllers/navbar_user_controller.dart'; // Pastikan impor ini benar

class PaymentController extends GetxController {
  var orders = <Map<String, dynamic>>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Menggunakan NavbarUserController, karena ini yang diimpor
  NavbarUserController get navbarController => Get.find<NavbarUserController>();

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi NavbarUserController jika belum ada
    if (!Get.isRegistered<NavbarUserController>()) {
      Get.lazyPut(() => NavbarUserController());
    }
    fetchOrderData();
  }

  void fetchOrderData() async {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    try {
      var snapshot = await _firestore
          .collection('orders')
          .doc(userId) // Mengakses dokumen berdasarkan UID pengguna
          .get();

      var userDoc = snapshot.data();
      if (userDoc != null && userDoc['orders'] != null) {
        orders.clear();
        for (var order in userDoc['orders']) {
          orders.add(order); // Menambahkan pesanan ke dalam list 'orders'
        }
        updateNavbarNotification();
      } else {
        Get.snackbar('No Orders', 'No orders found for this user.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch order data: $e');
    }
  }

  void addNewOrder(Map<String, dynamic> order) async {
    String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    try {
      // Menambahkan ID unik pada setiap pesanan untuk membedakan satu pesanan dengan yang lain
      String orderId =
          _firestore.collection('orders').doc().id; // Generate ID unik
      order['orderId'] = orderId; // Tambahkan 'orderId' ke dalam data pesanan

      // Menggunakan dokumen dengan ID sesuai UID pengguna
      var userDoc = _firestore.collection('orders').doc(userId);

      // Menambahkan pesanan baru ke dalam array 'orders' di dalam dokumen
      await userDoc.update({
        'orders': FieldValue.arrayUnion(
            [order]), // Menambahkan pesanan ke dalam array
      });

      fetchOrderData(); // Menarik kembali data untuk memperbarui tampilan
    } catch (e) {
      Get.snackbar('Error', 'Failed to add order: $e');
    }
  }

  void updateNavbarNotification() {
    try {
      bool hasUnpaidOrders = orders.any((order) =>
          order['status'] == 'pending' || order['status'] == 'unpaid');
      navbarController.setHasUnpaidBills(hasUnpaidOrders);
    } catch (e) {
      print('Error updating navbar notification: $e');
    }
  }

  void cancelOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).delete();
      Get.snackbar('Pembatalan Berhasil', 'Order telah dibatalkan');
      fetchOrderData();
    } catch (e) {
      Get.snackbar('Error', 'Gagal membatalkan order: $e');
    }
  }

  void markOrderAsPaid(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': 'paid',
        'paidAt': FieldValue.serverTimestamp(),
      });
      fetchOrderData();
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui status pembayaran: $e');
    }
  }
}
