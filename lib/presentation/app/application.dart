import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/bindings/app_binding.dart';
import 'package:profhunterapp/presentation/bindings/chat_and_message_binding.dart';
import 'package:profhunterapp/presentation/bindings/response_binding.dart';
import 'package:profhunterapp/presentation/bindings/vacancy_binding.dart';
import 'package:profhunterapp/presentation/pages/chat/chat_page.dart';
import 'package:profhunterapp/presentation/pages/home_page.dart';
import 'package:profhunterapp/presentation/pages/responses/responses_page.dart';
import 'package:profhunterapp/presentation/pages/utils/main_screen.dart';
import 'package:profhunterapp/presentation/pages/vacancy/vacancy_page.dart';
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
          initialBinding: AppBinding(widget.prefs),
          initialRoute: '/main-screen',
          theme: ThemeData().copyWith(
            extensions: [CustomTheme(palette: LightPalette())],
          ),
          darkTheme: ThemeData().copyWith(
            extensions: [CustomTheme(palette: DarkPalette())],
          ),
          debugShowCheckedModeBanner: false,
          getPages: [
            GetPage(
              name: '/vacancies',
              page: () => HomePage(),
              binding: VacancyBinding(),
            ),
            GetPage(
              name: '/main-screen',
              page: () => MainScreen(),
              binding: AppBinding(widget.prefs),
            ),
            GetPage(
              name: '/vacancy-detail',
              page: () => VacancyPage(vacancy: Get.arguments),
              binding: ResponseBinding(),
            ),
            GetPage(
              name: '/responses',
              page: () => ResponsesPage(),
              binding: ResponseBinding(),
            ),
            GetPage(
              name: '/chat',
              page: () => ChatPage(item: Get.arguments),
              binding: ChatAndMessageBinding(),
            ),
          ],
        );
      },
    );
  }
}
