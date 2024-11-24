# ML_Summative
Water Intake Prediction
Water Intake Estimator
Overview
Water Intake Estimator is a mobile app designed to predict the ideal daily water intake for users based on their personal data such as age, gender, height, weight, and activity level. The app uses a machine learning model to calculate the recommended water intake to help users maintain proper hydration.
Features
User Input: Users can enter their personal details like age, gender, height, weight, and activity level.
Prediction: The app calculates the estimated daily water intake based on the input provided.
Save and Reset: Users can save the calculated water intake goal and reset it if needed.
Hydration Guide: A simple, visually appealing interface guides users on their hydration journey.
Installation and Setup
Requirements
Flutter SDK
Dart
FastAPI (for backend)
Backend Setup (FastAPI)
Clone the backend repository.
Install the required dependencies:
 pip install fastapi uvicorn


Start the FastAPI server:
 uvicorn main:app --reload


Frontend Setup (Flutter)
Clone this repository.
Install Flutter and dependencies.
Run the Flutter app:
 flutter run


Links
Video Demonstration
Watch the video walkthrough of the app here:
 Water Intake Estimator Video Walkthrough
Deployed App
You can view the deployed version of the app on Render here:
 Water Intake Estimator - Deployed App
Dataset
The dataset used for training the water intake prediction model can be found here:
https://www.kaggle.com/datasets/valakhorasani/gym-members-exercise-dataset

Usage
Launch the app on your mobile device.
Enter your personal details (age, gender, height, weight, and activity level).
Click on "Calculate" to get your daily water intake goal.
Save or reset the value based on your preferences.
Acknowledgments
The app uses machine learning for predicting daily water intake. The model was trained using a dataset that includes various factors influencing water consumption needs.
Thanks to the Flutter and FastAPI communities for providing great tools to build this app.
