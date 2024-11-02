// lib/app/modules/order_menu/controllers/order_menu_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Tambahkan jika menggunakan Firebase Firestore

class OrderMenuController extends GetxController {
  var selectedPackage = 'Regular'.obs;
  var selectedDelivery = 'Antar Jemput'.obs;
  var notes = ''.obs;
  var selectedLaundryType = ''.obs;

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
    return selectedLaundryType.isNotEmpty && notes.isNotEmpty;
  }

  // Save order data to Firebase or temporary storage
  void saveOrder() {
    if (!validateOrder()) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    }

    // Data to be saved
    var orderData = {
      'laundryType': selectedLaundryType.value,
      'servicePackage': selectedPackage.value,
      'pickupOption': selectedDelivery.value,
      'notes': notes.value,
      'orderDate': DateTime.now(),
      'price': calculatePrice(), // Method to calculate price
    };

    // Save to Firebase Firestore
    FirebaseFirestore.instance
        .collection('orders')
        .add(orderData)
        .then((docRef) {
      Get.snackbar('Order Saved', 'Your order has been successfully saved');
      Get.toNamed('/payment',
          arguments: orderData); // Navigate to payment with data
    }).catchError((error) {
      Get.snackbar('Error', 'Failed to save order: $error');
    });
  }

  // Price calculation based on selected package and laundry type
  double calculatePrice() {
    double basePrice;
    switch (selectedLaundryType.value) {
      case 'Cuci Aja':
        basePrice = 15.0;
        break;
      case 'Cuci Setrika':
        basePrice = 20.0;
        break;
      case 'Dry Cleaning':
        basePrice = 30.0;
        break;
      case 'Karpet':
        basePrice = 40.0;
        break;
      case 'Custom':
        basePrice = 50.0;
        break;
      case 'Sepatu & Tas':
        basePrice = 25.0;
        break;
      default:
        basePrice = 15.0;
    }

    // Adjust price based on service package
    if (selectedPackage.value == 'Express') {
      basePrice *= 1.5; // Increase price by 50% for express service
    }

    return basePrice;
  }

  void payNow() {
    if (validateOrder()) {
      saveOrder();
    } else {
      Get.snackbar('Error', 'Please fill in all fields');
    }
  }

  void payLater() {
    if (validateOrder()) {
      saveOrder();
      Get.back(); // Optionally, navigate back or to another view
    } else {
      Get.snackbar('Error', 'Please fill in all fields');
    }
  }
}
