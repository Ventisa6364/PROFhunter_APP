import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/data/datasources/auth_remote_data_source.dart';
import 'package:profhunterapp/presentation/app/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authRemoteDataSource = AuthRemoteDataSource();
  await authRemoteDataSource.initPocketBase();

  Get.put<AuthRemoteDataSource>(authRemoteDataSource, permanent: true);

  runApp(const Application());
}
