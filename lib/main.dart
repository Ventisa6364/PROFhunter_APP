import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/data/datasources/auth_remote_data_source.dart';
import 'package:profhunterapp/presentation/app/application.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(Application(prefs: prefs));
}
