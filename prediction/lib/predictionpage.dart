import 'package:flutter/material.dart';

class PredictionPage extends StatelessWidget {
  final String waterGoal;

  PredictionPage({required this.waterGoal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Tailored Hydration Guide"),
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset('assets/back.png'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/predict.png', // Replace with your local image asset path
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 60),
              Text(
                "Your daily water goal:",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$waterGoal liters",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40), // Control spacing here
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 30.0), // Adjust bottom padding
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the input page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  ),
                  child: Text(
                    "Go Back",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
