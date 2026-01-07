import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/services/auth_service.dart';
import '../../common/routes/names.dart';
import 'state.dart';

class SignInController extends GetxController {
  final state = SignInState();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    state.obscurePassword.value = !state.obscurePassword.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      final result = await AuthService.to.signInWithEmailPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (result != null) {
        Get.offAllNamed(AppRoutes.Application);
      }
    }
  }

  Future<void> signInWithGoogle() async {
    final result = await AuthService.to.signInWithGoogle();
    if (result != null) {
      Get.offAllNamed(AppRoutes.Application);
    }
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  void goToForgotPassword() {
    Get.defaultDialog(
      title: 'Réinitialiser le mot de passe',
      content: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Entrez votre email',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      textConfirm: 'Envoyer',
      textCancel: 'Annuler',
      onConfirm: () async {
        if (emailController.text.isNotEmpty) {
          await AuthService.to.resetPassword(emailController.text);
          Get.back();
        }
      },
    );
  }
}
