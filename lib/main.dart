import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uisample/ui/sign_up_screens/sign_up_nickname.dart';
import 'package:uisample/ui/start_screen/start_screen.dart';
import 'package:uisample/viewModels/global_change_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalChangeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF7E7CD3),
        accentColor: Color(0xFFECEFF4),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily: "poppins",
          ),
          bodyText2: TextStyle(
            fontSize: 16,
            fontFamily: "poppins",
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => StartScreen(),
        SignUpNicknameScreen.routeName: (context) => SignUpNicknameScreen(),
      },
    );
  }
}
