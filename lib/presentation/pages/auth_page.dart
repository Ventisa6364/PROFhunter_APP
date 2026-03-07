import 'package:flutter/material.dart';
import 'package:profhunteruikit/uikit.dart';
import 'package:get/get.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      body: Center(child: CustomButton.filled(onPressed: () {Get.back();}, text: 'back', theme: theme)),
    );
  }
}
