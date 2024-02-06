import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:notic/main_screen/Views/mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notic',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xffFDE5EC),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        textTheme: TextTheme(
            bodyMedium: TextStyle(
              color: Colors.black,
            ),
            labelLarge: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),

      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: TextTheme(
            bodyMedium: TextStyle(
              color: Colors.white, // رنگ متن به طور کلی در حالت دارک مود
            ),
            labelLarge: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      home: MainPage(),
    );
  }
}
