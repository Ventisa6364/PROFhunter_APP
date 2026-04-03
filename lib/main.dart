import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:profhunterapp/auth/auth_controller.dart';
import 'package:profhunterapp/auth/auth_repository.dart';
import 'package:profhunterapp/auth/pb_auth_repository.dart';
import 'package:profhunterapp/presentation/widget/application.dart';

void main() {
  final pb = PocketBase('http://10.0.2.2:8090');

  final authRepository = PocketBaseAuthRepository(pb);

  Get.put<AuthRepository>(authRepository);
  Get.put(AuthController(authRepository));

  runApp(const Application());
}