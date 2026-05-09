import 'package:flutter/material.dart';
import 'package:profhunteruikit/uikit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    var theme = CustomTheme.of(context);
    return Scaffold(
      backgroundColor: theme.palette.background,
      appBar: CustomAppBarWidget(title: 'Name company'),
      body: Column(
        
      ),
    );
  }
}
