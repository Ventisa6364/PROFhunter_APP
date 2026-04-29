import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/bindings/auth_binding.dart';
import 'package:profhunterapp/presentation/pages/home_page.dart';
import 'package:profhunteruikit/uikit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Application extends StatefulWidget {
  final SharedPreferences prefs;
  Application({super.key, required this.prefs});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(376, 832),
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AuthBinding(widget.prefs),
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
