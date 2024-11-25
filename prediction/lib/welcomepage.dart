import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // Prevent keyboard from appearing
      body: SingleChildScrollView(
        // Make the entire body scrollable
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align content to the top
              children: [
                SizedBox(height: 80), // Add space between the top and the title
                Text(
                  'Welcome to\nHydration Tracker',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 160),
                Image.asset(
                  'assets/welcome.png', // Replace with the correct path for the image asset
                  height: 200, // Set the desired height
                  width: 200, // Set the desired width
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Add navigation to the next screen here
                    Navigator.pushNamed(context, '/inputpage');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                    padding:
                        EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Get started',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
