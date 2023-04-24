import 'package:fennechms/providers/auth.dart';
import 'package:fennechms/screens/login_screen.dart';
import 'package:fennechms/screens/signup_screen.dart';
import 'package:fennechms/screens/splash_screen.dart';
import 'package:fennechms/screens/tab_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    MaterialColor primaryColor = MaterialColor(
      const Color.fromRGBO(0, 128, 128, 1).value,
      const <int, Color>{
        50: Color.fromRGBO(0, 128, 128, 0.1),
        100: Color.fromRGBO(0, 128, 128, 0.2),
        200: Color.fromRGBO(0, 128, 128, 0.3),
        300: Color.fromRGBO(0, 128, 128, 0.4),
        400: Color.fromRGBO(0, 128, 128, 0.5),
        500: Color.fromRGBO(0, 128, 128, 0.6),
        600: Color.fromRGBO(0, 128, 128, 0.7),
        700: Color.fromRGBO(0, 128, 128, 0.8),
        800: Color.fromRGBO(0, 128, 128, 0.9),
        900: Color.fromRGBO(0, 128, 128, 1),
      },
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fennec HMS',
        theme: ThemeData(
          primarySwatch: primaryColor,
          primaryColor: primaryColor,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          SignupScreen.routeName: (context) => SignupScreen(),
          TabScreen.routeName: (context) => TabScreen(),
        },
      ),
    );
  }
}
