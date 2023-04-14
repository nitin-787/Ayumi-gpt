import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/providers/chat_provider.dart';
import 'package:chatgpt/providers/models_provider.dart';
import 'package:chatgpt/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        darkTheme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundDark,
          // text color
          canvasColor: darkText,
          cardColor: drawerColorDark,
          indicatorColor: iconDark,
          appBarTheme: AppBarTheme(
            color: darkPrimary,
          ),
        ),
        theme: ThemeData(
          // text color & icon color
          canvasColor: lightText,
          cardColor: drawerColorDark,
          indicatorColor: iconLight,
          scaffoldBackgroundColor: scaffoldBackgroundLight,
          appBarTheme: AppBarTheme(
            color: lightPrimary,
          ),
        ),
      ),
    );
  }
}
