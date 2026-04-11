import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/auth/auth_controller.dart';
import 'package:profhunterapp/auth/auth_repository.dart';
import 'package:profhunterapp/auth/pb_auth_repository.dart';
import 'package:profhunterapp/presentation/widget/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authRepository = PocketBaseAuthRepository();
  await authRepository.initPocketBase();

  Get.put<AuthRepository>(authRepository);
  Get.put(AuthController(authRepository));

  runApp(const Application());
}