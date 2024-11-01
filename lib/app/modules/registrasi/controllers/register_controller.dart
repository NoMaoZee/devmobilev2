import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:google_sign_in/google_sign_in.dart'; // Import Google Sign In

class RegisterController extends GetxController {
  final logger = Logger();
  var registerButtonScale = 1.0.obs; // Variabel untuk animasi skala tombol
  final FirebaseAuth _auth =
      FirebaseAuth.instance; // Inisialisasi Firebase Auth
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(); // Inisialisasi Google Sign In

  // Fungsi untuk kembali ke layar sebelumnya
  void goBack() {
    Get.back();
  }

  // Fungsi untuk registrasi
  void register() {
    logger.i("Register button clicked");
    // Tambahkan logika registrasi di sini
    // Misalnya, validasi input dan kirim data ke backend
    // Setelah berhasil registrasi, navigasi ke halaman login
    Get.toNamed('/login');
  }

  // Fungsi untuk registrasi menggunakan Google
  void registerWithGoogle() async {
    logger.i("Register with Google button clicked");
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Pengguna membatalkan login
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Buat kredensial baru
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Daftar atau masuk ke Firebase dengan kredensial Google
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // Logika setelah sukses login
      logger.i("User registered: ${userCredential.user?.displayName}");
      Get.toNamed('/mainMenu'); // Arahkan ke halaman utama setelah berhasil
    } catch (e) {
      logger.e("Failed to register with Google: $e");
      // Tampilkan pesan error jika login gagal
      Get.snackbar('Error', 'Failed to register with Google: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Fungsi untuk navigasi ke halaman login
  void navigateToLogin() {
    Get.toNamed('/login');
  }
}
