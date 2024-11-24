import 'dart:convert'; // For encoding data to JSON
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String? selectedGender;
  String? selectedWorkType;

  Future<void> getWaterIntakePrediction() async {
    final url = Uri.parse('http://10.0.2.2:8000/predict-water-intake');

    final response = await http.get(
      url.replace(queryParameters: {
        'age': ageController.text,
        'gender': selectedGender ?? '',
        'height': heightController.text,
        'weight': weightController.text,
        'workout_type': selectedWorkType ?? '',
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the prediction
      final data = jsonDecode(response.body);
      final predictedWaterIntake = data['predicted_daily_water_intake'];
      
      // Show the prediction in an alert dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Predicted Daily Water Intake'),
          content: Text(predictedWaterIntake),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // If the server did not return a 200 OK response, show an error
      throw Exception('Failed to load prediction');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.1), // Responsive height
        child: AppBar(
          leading: IconButton(
            icon: Image.asset('assets/back.png'), // Replace with your image path
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              'Hydrate Your Way to Wellness',
              style: TextStyle(
                fontSize: size.width * 0.05, 
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: size.height * 0.05), // Responsive spacing
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Age',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              DropdownButtonFormField<String>(
                value: selectedGender,
                hint: Text('Gender'),
                items: [
                  DropdownMenuItem(value: 'male', child: Text('Male')),
                  DropdownMenuItem(value: 'female', child: Text('Female')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Weight (kg)',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Height (m)',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              DropdownButtonFormField<String>(
                value: selectedWorkType,
                hint: Text('Work Type'),
                items: [
                  DropdownMenuItem(value: 'sedentary', child: Text('Sedentary')),
                  DropdownMenuItem(value: 'light', child: Text('Light')),
                  DropdownMenuItem(value: 'moderate', child: Text('Moderate')),
                  DropdownMenuItem(value: 'heavy', child: Text('Heavy')),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedWorkType = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              ElevatedButton(
                onPressed: getWaterIntakePrediction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Calculate',
                  style: TextStyle(fontSize: size.width * 0.045, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
