// lib/app/modules/payment/controllers/payment_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentController extends GetxController {
  var orders = <Map<String, dynamic>>[].obs; // List to hold multiple orders
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth instance

  @override
  void onInit() {
    super.onInit();
    fetchOrderData();
  }

  void fetchOrderData() async {
    // Get the User ID from Firebase Authentication
    String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    try {
      // Retrieve all orders for the user from Firestore
      var snapshot = await _firestore
          .collection('orders')
          .where('uid', isEqualTo: userId) // Filter by user ID
          .orderBy('orderDate', descending: true)
          .get();

      // Clear the list and add fetched orders
      orders.clear();
      for (var doc in snapshot.docs) {
        var order = doc.data();
        order['id'] = doc.id; // Include document ID
        orders.add(order);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch order data: $e');
    }
  }

  // Function to cancel an order
  void cancelOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).delete();
      Get.snackbar('Pembatalan Berhasil', 'Order telah dibatalkan');
      fetchOrderData(); // Refresh orders after cancellation
    } catch (e) {
      Get.snackbar('Error', 'Gagal membatalkan order: $e');
    }
  }
}
