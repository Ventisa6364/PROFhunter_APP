import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/pages/auth_page.dart';
import 'package:profhunterapp/presentation/pages/profile/profile.dart';

class ProfileGate extends StatelessWidget {
  const ProfileGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(() {
      if (authController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (authController.user.value != null) {
        return const ProfileScreen();
      }

      return AuthPage();
    });
  }
}