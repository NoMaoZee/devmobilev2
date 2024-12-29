import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class OrderMenuController extends GetxController {
  var selectedPackage = 'Regular'.obs;
  var selectedDelivery = 'Antar Jemput'.obs;
  var notes = ''.obs;
  var selectedLaundryType = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var orderId = ''.obs;

  final List<String> laundryTypes = [
    'Cuci Aja',
    'Cuci Setrika',
    'Dry Cleaning',
    'Karpet',
    'Custom',
    'Sepatu & Tas',
  ];

  void setLaundryType(String type) => selectedLaundryType.value = type;
  void setPackage(String package) => selectedPackage.value = package;
  void setDelivery(String delivery) => selectedDelivery.value = delivery;
  void setNotes(String value) => notes.value = value;

  bool validateOrder() {
    return selectedLaundryType.value.isNotEmpty && notes.value.isNotEmpty;
  }

  int calculatePrice() {
    int basePrice = 0;

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

    int deliveryCost = selectedDelivery.value == 'Antar Jemput' ? 10000 : 5000;

    return basePrice + deliveryCost;
  }

  Future<String> generateOrderId() async {
    String datePart = DateFormat('ddMMyyyy').format(DateTime.now());
    int currentMax = 0;

    QuerySnapshot querySnapshot = await _firestore
        .collection('orders')
        .doc(_auth.currentUser?.uid)
        .collection('userOrders')
        .orderBy('orderDate', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String lastOrderId = querySnapshot.docs.first['uid'];
      String lastOrderDatePart = lastOrderId.substring(0, 8);
      if (lastOrderDatePart == datePart) {
        currentMax = int.parse(lastOrderId.substring(8));
      }
    }

    String orderId = datePart + (currentMax + 1).toString().padLeft(4, '0');
    return orderId;
  }

  Future<void> saveOrder() async {
    if (!validateOrder()) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    String? userId = _auth.currentUser?.uid;
    if (userId == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    try {
      String generatedOrderId = await generateOrderId();

      var orderData = {
        'uid': generatedOrderId,
        'laundryType': selectedLaundryType.value,
        'servicePackage': selectedPackage.value,
        'pickupOption': selectedDelivery.value,
        'notes': notes.value,
        'orderDate': FieldValue.serverTimestamp(),
        'price': calculatePrice(),
      };

      // Simpan data di dalam subcollection "userOrders"
      await _firestore
          .collection('orders')
          .doc(userId)
          .collection('userOrders')
          .doc(generatedOrderId)
          .set(orderData);

      orderId.value = generatedOrderId;
      Get.snackbar('Order Saved', 'Your order has been successfully saved');

      // Navigasi ke BottomNavigationBar dengan index PaymentView
      Get.offAllNamed('/navbar', arguments: {'selectedIndex': 1});
    } catch (error) {
      Get.snackbar('Error', 'Failed to save order: $error');
    }
  }
}
