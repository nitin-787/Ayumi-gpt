import 'package:chatgpt/providers/chat_provider.dart';
import 'package:chatgpt/providers/models_provider.dart';
import 'package:chatgpt/providers/theme_provider.dart';
import 'package:chatgpt/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ModelsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChatProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: const ChatScreen(),
          themeMode: ThemeMode.system,
          darkTheme: MyTheme().darkTheme,
          theme: MyTheme().lightTheme,
        ),
      ),
    );
  }
}
