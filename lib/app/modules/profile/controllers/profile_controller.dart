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
  var email = ''.obs;
  var address = ''.obs;
  var phoneNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      print('No UID found. User might not be logged in.');
      return;
    }

    try {
      final docRef = _firestore.collection('users').doc(uid);
      final snapshot = await docRef.get();

      if (!snapshot.exists) {
        // Buat dokumen default jika belum ada
        await docRef.set({
          'name': 'Nama Pengguna',
          'phone': 'No. Telepon',
          'address': 'Alamat',
        });
        print('Created default user profile for $uid');
      }

      userName.value = snapshot.data()?['name'] ?? 'Nama Pengguna';
      phoneNumber.value = snapshot.data()?['phone'] ?? 'No. Telepon';
      address.value = snapshot.data()?['address'] ?? 'Alamat';
    } catch (e) {
      print('Error fetching user data: $e');
      Get.snackbar('Error', 'Gagal mengambil data profil.');
    }
  }

  Future<void> updateUserData(String field, String value) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      print('No UID found. User might not be logged in.');
      return;
    }

    try {
      final docRef = _firestore.collection('users').doc(uid);

      // Check if the document exists before updating
      final snapshot = await docRef.get();
      if (!snapshot.exists) {
        print('Document not found. Creating default document.');
        await docRef.set({
          'name': 'Nama Pengguna',
          'phone': 'No. Telepon',
          'address': 'Alamat',
        });
      }

      // Update the specific field
      await docRef.update({field: value});
      print('Updated $field to $value');
    } catch (e) {
      print('Error updating $field: $e');
      Get.snackbar('Error', 'Gagal memperbarui data $field.');
    }
  }

  void navigateToNavbar() {
    Get.toNamed('/navbar');
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();

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
