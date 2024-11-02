import 'package:get/get.dart';
import 'package:devmobilev2/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Inisialisasi Firebase Auth
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(); // Inisialisasi Google Sign In

  // Method untuk navigasi ke halaman login saat logout
  Future<void> logout() async {
    try {
      // Sign out dari Firebase
      await _auth.signOut();
      // Sign out dari Google
      await _googleSignIn.signOut();
      Get.offAllNamed(Routes.login); // Navigasi ke login screen
    } catch (e) {
      // Tampilkan error jika logout gagal
      Get.snackbar('Error', 'Failed to sign out: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Method untuk navigasi ke main menu saat menekan tombol 'Selesai' atau arrow back
  void navigateToMainMenu() {
    Get.toNamed('/mainMenu'); // Navigasi ke main menu
  }
}
