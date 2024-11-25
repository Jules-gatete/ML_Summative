import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'predictionpage.dart'; // Import PredictionPage correctly

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
    if (ageController.text.isEmpty ||
        weightController.text.isEmpty ||
        heightController.text.isEmpty ||
        selectedGender == null ||
        selectedWorkType == null) {
      showErrorDialog('All fields are required');
      return;
    }

    try {
      final age = int.parse(ageController.text);
      final weight = double.parse(weightController.text);
      final height = double.parse(heightController.text);

      // final url = Uri.parse('http://10.0.2.2:8000/predict/'); local host link url
      final url = Uri.parse('https://ml-summative-3.onrender.com/predict/');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'age': age,
          'gender': selectedGender ?? '',
          'height': height,
          'weight': weight,
          'workout_type': selectedWorkType ?? '',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final predictedWaterIntake = data['predicted_water_intake'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PredictionPage(waterGoal: predictedWaterIntake.toString()),
          ),
        );
      } else {
        showErrorDialog(jsonDecode(response.body)['detail']);
      }
    } catch (e) {
      showErrorDialog('Invalid input. Please check your values.');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.1),
        child: AppBar(
          leading: IconButton(
            icon: Image.asset('assets/back.png'),
            onPressed: () {
              Navigator.pop(context);
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
              SizedBox(height: size.height * 0.05),
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
                  DropdownMenuItem(
                      value: 'sedentary', child: Text('Sedentary')),
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
                  style: TextStyle(
                      fontSize: size.width * 0.045, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
