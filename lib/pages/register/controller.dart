import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/services/auth_service.dart';
import '../../common/routes/names.dart';
import 'state.dart';

class RegisterController extends GetxController {
  final state = RegisterState();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    state.obscurePassword.value = !state.obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    state.obscureConfirmPassword.value = !state.obscureConfirmPassword.value;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre nom';
    }
    if (value.length < 3) {
      return 'Le nom doit contenir au moins 3 caractères';
    }
    return null;
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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }
    if (value != passwordController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      final result = await AuthService.to.registerWithEmailPassword(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
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

  void goToSignIn() {
    Get.back();
  }
}
