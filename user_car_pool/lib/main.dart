
import 'package:car_pool/Screens/order_status_screen.dart';
import 'package:car_pool/Screens/rides_screen.dart';
import 'package:car_pool/Screens/homepage_routes_screen.dart';
import 'package:car_pool/Screens/login_screen.dart';
import 'package:car_pool/Screens/order_details_screen.dart';
import 'package:car_pool/Screens/order_tracking_screen.dart';
import 'package:car_pool/Screens/payment_screen.dart';
import 'package:car_pool/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:car_pool/Screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent
      )
    );
    return MaterialApp(
      theme: themeData,
      routes: {
        '/': (context) => const LoginScreen(),        
        LoginScreen.routeName: (context) => const LoginScreen(),
        Signup.routeName: (context) => const Signup(),
        MainPage.routeName: (context) => const MainPage(),
        ActivityHistory.routeName: (context) => const ActivityHistory(),
        Payment.routeName:(context) => const Payment(),
        HomePage.routeName:(context) => const HomePage(),
        OrderDetails.routeName:(context) => const OrderDetails(),
        OrderTracking.routeName: (context) => const OrderTracking(),
        OrderStatus.routeName: (context) => const OrderStatus()

      },
    );
  }
}
