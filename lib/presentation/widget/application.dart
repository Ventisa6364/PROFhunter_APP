import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/pages/registration_page.dart';
import 'package:profhunterapp/presentation/pages/home_page.dart';
import 'package:profhunteruikit/uikit.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(500, 1000),
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData().copyWith(
            extensions: [CustomTheme(palette: LightPalette())],
          ),
          darkTheme: ThemeData().copyWith(
            extensions: [CustomTheme(palette: DarkPalette())],
          ),
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: HomePage(),
    );
  }
}