import 'package:get/get.dart';
import '../../common/services/auth_service.dart';
import '../../common/routes/names.dart';
import 'state.dart';

class ApplicationController extends GetxController {
  final state = ApplicationState();

  void changePage(int index) {
    state.currentIndex.value = index;
  }

  Future<void> logout() async {
    Get.defaultDialog(
      title: 'Déconnexion',
      middleText: 'Voulez-vous vraiment vous déconnecter?',
      textConfirm: 'Oui',
      textCancel: 'Non',
      onConfirm: () async {
        await AuthService.to.signOut();
        Get.offAllNamed(AppRoutes.INITIAL);
      },
    );
  }

  String getCurrentUserName() {
    return AuthService.to.currentUser?.displayName ?? 'Utilisateur';
  }

  String getCurrentUserEmail() {
    return AuthService.to.currentUser?.email ?? '';
  }
}
