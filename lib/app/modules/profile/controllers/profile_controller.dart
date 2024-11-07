import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Logger _logger = Logger();

  var userName = ''.obs;
  var phoneNumber = ''.obs;
  var address = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData(); // Fetch user data when the controller initializes
  }

  // Fetch user data from Firestore
  void fetchUserData() async {
    String? userId = _auth.currentUser?.uid;
    if (userId != null) {
      try {
        var userDoc = await _firestore.collection('profile').doc(userId).get();
        if (userDoc.exists) {
          userName.value = userDoc['name'] ?? 'Admin';
          phoneNumber.value = userDoc['phone'] ?? '+62 876256592617';
          address.value = userDoc['address'] ?? 'Jl. Kapal Laut, No.23';
        }
      } catch (e) {
        _logger.e("Error fetching user data: $e");
      }
    }
  }

  Future<void> updateUserData(String field, String value) async {
    String? userId = _auth.currentUser?.uid;
    if (userId != null) {
      try {
        // Reference to the user document
        DocumentReference userDocRef =
            _firestore.collection('profile').doc(userId);

        // Check if the document exists
        var userDoc = await userDocRef.get();
        if (userDoc.exists) {
          // If document exists, update the specified field
          await userDocRef.update({field: value});
        } else {
          // If document does not exist, create it with the specified field
          await userDocRef.set({
            'name': field == 'name' ? value : userName.value,
            'phone': field == 'phone' ? value : phoneNumber.value,
            'address': field == 'address' ? value : address.value,
          });
        }

        // Update local values to reflect changes in the UI
        if (field == 'name') userName.value = value;
        if (field == 'phone') phoneNumber.value = value;
        if (field == 'address') address.value = value;

        _logger.i("User $field updated to $value");
      } catch (e) {
        _logger.e("Error updating $field: $e");
        Get.snackbar('Error', 'Failed to update $field: $e',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  // Navigate to Main Menu
  void navigateToMainMenu() {
    Get.toNamed('/mainMenu'); // Replace '/mainMenu' with your main menu route
  }

  // Logout function
  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();

      // Check if the user is currently signed in with Google
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.disconnect();
      }

      Get.offAllNamed('/login');
      _logger.i("Successfully logged out");
    } catch (e) {
      _logger.e("Failed to log out: $e");
      Get.snackbar('Error', 'Failed to log out: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
