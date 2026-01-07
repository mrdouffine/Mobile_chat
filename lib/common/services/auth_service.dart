// Mock implementation for Linux - no Firebase
import 'package:get/get.dart';
import 'storage_service.dart';

// Mock User class to replace Firebase User
class MockUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoURL;
  
  MockUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });
}

// Mock UserCredential
class MockUserCredential {
  final MockUser? user;
  MockUserCredential(this.user);
}

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  
  final Rx<MockUser?> firebaseUser = Rx<MockUser?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Mock: Check if user was logged in
    if (StorageService.to.getBool('isLoggedIn') == true) {
      String? userId = StorageService.to.getString('userId');
      if (userId != null) {
        firebaseUser.value = MockUser(
          uid: userId,
          email: StorageService.to.getString('userEmail'),
          displayName: StorageService.to.getString('userName'),
        );
      }
    }
  }

  // Get current user
  MockUser? get currentUser => firebaseUser.value;

  // Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  // Mock sign in with email and password
  Future<MockUserCredential?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      
      // Mock authentication - simulate a delay
      await Future.delayed(Duration(milliseconds: 500));
      
      // Create mock user
      String userId = 'mock_user_${DateTime.now().millisecondsSinceEpoch}';
      MockUser user = MockUser(
        uid: userId,
        email: email.trim(),
        displayName: email.split('@')[0],
      );
      
      firebaseUser.value = user;
      
      // Save login state
      await StorageService.to.setBool('isLoggedIn', true);
      await StorageService.to.setString('userId', userId);
      await StorageService.to.setString('userEmail', email);
      await StorageService.to.setString('userName', email.split('@')[0]);
      
      Get.snackbar(
        'Succès',
        'Connexion réussie (mode mock)',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      return MockUserCredential(user);
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Erreur de connexion: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // Mock register with email and password
  Future<MockUserCredential?> registerWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      isLoading.value = true;
      
      // Mock registration - simulate a delay
      await Future.delayed(Duration(milliseconds: 500));
      
      // Create mock user
      String userId = 'mock_user_${DateTime.now().millisecondsSinceEpoch}';
      MockUser user = MockUser(
        uid: userId,
        email: email.trim(),
        displayName: name,
      );
      
      firebaseUser.value = user;

      // Save login state
      await StorageService.to.setBool('isLoggedIn', true);
      await StorageService.to.setString('userId', userId);
      await StorageService.to.setString('userEmail', email);
      await StorageService.to.setString('userName', name);

      Get.snackbar(
        'Succès',
        'Inscription réussie (mode mock)',
        snackPosition: SnackPosition.BOTTOM,
      );

      return MockUserCredential(user);
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Erreur d\'inscription: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // Mock sign in with Google
  Future<MockUserCredential?> signInWithGoogle() async {
    Get.snackbar(
      'Non disponible',
      'La connexion Google n\'est pas disponible en mode mock.',
      snackPosition: SnackPosition.BOTTOM,
    );
    return null;
  }

  // Mock sign out
  Future<void> signOut() async {
    try {
      firebaseUser.value = null;
      await StorageService.to.setBool('isLoggedIn', false);
      await StorageService.to.remove('userId');
      await StorageService.to.remove('userEmail');
      await StorageService.to.remove('userName');
      
      Get.snackbar(
        'Déconnexion',
        'Vous êtes déconnecté',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Erreur lors de la déconnexion: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Mock reset password
  Future<bool> resetPassword(String email) async {
    Get.snackbar(
      'Email envoyé (mock)',
      'Un email de réinitialisation serait envoyé à $email',
      snackPosition: SnackPosition.BOTTOM,
    );
    return true;
  }
}
