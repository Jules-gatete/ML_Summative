import 'package:flutter/material.dart';
import 'welcomepage.dart'; // Import the welcomepage.dart file
import 'inputpage.dart'; // Import the inputpage.dart file
import 'predictionpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hydration Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: WelcomePage(), // Set WelcomePage as the home screen
      routes: {
        '/welcomepage': (context) => WelcomePage(), // Initial route - WelcomePage
        '/inputpage': (context) => InputPage(), // Define route for InputPage
        '/predictionpage': (context) => PredictionPage(waterGoal: '',),
      },
    );
  }
}
