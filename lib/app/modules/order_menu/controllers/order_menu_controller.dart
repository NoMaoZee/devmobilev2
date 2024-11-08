// lib/app/modules/order_menu/controllers/order_menu_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderMenuController extends GetxController {
  var selectedPackage = 'Regular'.obs;
  var selectedDelivery = 'Antar Jemput'.obs;
  var notes = ''.obs;
  var selectedLaundryType = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Tambahkan FirebaseAuth instance

  // ID untuk dokumen yang sudah disimpan, untuk menghindari duplikasi
  var orderId = ''.obs;

  final List<String> laundryTypes = [
    'Cuci Aja',
    'Cuci Setrika',
    'Dry Cleaning',
    'Karpet',
    'Custom',
    'Sepatu & Tas',
  ];

  // Setters for laundry type, package, and delivery options
  void setLaundryType(String type) => selectedLaundryType.value = type;
  void setPackage(String package) => selectedPackage.value = package;
  void setDelivery(String delivery) => selectedDelivery.value = delivery;
  void setNotes(String value) => notes.value = value;

  // Validate input before saving
  bool validateOrder() {
    return selectedLaundryType.value.isNotEmpty && notes.value.isNotEmpty;
  }

  // Calculate price based on selected package, laundry type, and delivery option
  int calculatePrice() {
    int basePrice = 0;

    // Determine base price based on laundry type and package
    if (selectedLaundryType.value == 'Cuci Aja') {
      basePrice = selectedPackage.value == 'Express' ? 20000 : 10000;
    } else if (selectedLaundryType.value == 'Cuci Setrika') {
      basePrice = selectedPackage.value == 'Express' ? 30000 : 20000;
    } else if (selectedLaundryType.value == 'Dry Cleaning') {
      basePrice = selectedPackage.value == 'Express' ? 15000 : 10000;
    } else if (selectedLaundryType.value == 'Karpet') {
      basePrice = selectedPackage.value == 'Express' ? 40000 : 25000;
    } else if (selectedLaundryType.value == 'Sepatu & Tas') {
      basePrice = selectedPackage.value == 'Express' ? 35000 : 25000;
    }
    // Add additional delivery cost based on delivery option
    int deliveryCost = selectedDelivery.value == 'Antar Jemput' ? 10000 : 5000;

    return basePrice + deliveryCost;
  }

  // Save order data to Firestore
  Future<void> saveOrder() async {
    if (!validateOrder()) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    // Cek jika order sudah tersimpan sebelumnya
    if (orderId.value.isNotEmpty) {
      Get.snackbar(
          'Order Already Exists', 'This order has already been saved.');
      return;
    }

    // Dapatkan User ID dari Firebase Authentication
    String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    var orderData = {
      'uid': userId, // Tambahkan user ID ke data order
      'laundryType': selectedLaundryType.value,
      'servicePackage': selectedPackage.value,
      'pickupOption': selectedDelivery.value,
      'notes': notes.value,
      'orderDate': FieldValue.serverTimestamp(),
      'price': calculatePrice(),
    };

    try {
      // Simpan data ke Firebase dan simpan ID dokumen
      var docRef = await _firestore.collection('orders').add(orderData);
      orderId.value = docRef.id; // Simpan ID dokumen yang baru
      Get.snackbar('Order Saved', 'Your order has been successfully saved');
      Get.toNamed('/payment', arguments: orderData); // Navigasi ke payment
    } catch (error) {
      Get.snackbar('Error', 'Failed to save order: $error');
    }
  }
}
