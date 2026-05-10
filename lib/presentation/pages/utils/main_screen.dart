import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profhunterapp/presentation/controllers/auth_controller.dart';
import 'package:profhunterapp/presentation/pages/chat/user_chats_page.dart';
import 'package:profhunterapp/presentation/pages/home_page.dart';
import 'package:profhunterapp/presentation/pages/profile/profile_gate.dart';
import 'package:profhunteruikit/uikit.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final authController = Get.find<AuthController>();

  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  final List<Widget> pages = [
    HomePage(),
    const UserChatsPage(),
    const ProfileGate(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),

      bottomNavigationBar: NavigationBottomMenu(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
