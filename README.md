# ML Summative: Water Intake Estimator  

## Overview  
The **Water Intake Estimator** is a mobile application designed to predict the ideal daily water intake for users. Using personal data such as age, gender, height, weight, and activity level, the app leverages a machine learning model to recommend optimal hydration levels, helping users maintain their health and well-being.  

---

## Features  
- **User Input**: Input personal details like :
     - age:
     - gender:(male, female)
     - height: 
     - weight:
and 
     - workout_type: ("sedentary", "light", "moderate", and  "heavy")
       
- **Prediction**: Calculate the recommended daily water intake using a trained ML model.  
- **Save and Reset**: Save the calculated water intake goal or reset it as needed.  
- **Hydration Guide**: User-friendly interface to guide users on their hydration journey.  

---

## Installation and Setup  

### Requirements  
- **Flutter SDK**  
- **Dart**  
- **FastAPI** (for backend)  

### Backend Setup (FastAPI)  
1. Clone the backend repository:  
   ```bash
   git clone https://github.com/Jules-gatete/ML_Summative.git

   ```  
2. Install the required dependencies:  
   ```bash
   pip install -r requirements.txt
   ```  
3. Start the FastAPI server:  
   ```bash
uvicorn Daily_Water_Intake_Estimator:app --reload
   ```  

### Frontend Setup (Flutter)  
1. Clone this repository:  
   ```bash
   git clone https://github.com/Jules-gatete/ML_Summative.git
   ```  
2. Install Flutter and required dependencies.  
3. Run the Flutter app:  
   ```bash
   flutter run
   ```  

---

## Links  

- **Video Demonstration**  
  Watch the video walkthrough of the app here:  
  [https://vimeo.com/1033258692/ba62359d27?share=copy)  

- **Deployed API**  
  The API is deployed and publicly available on Render:  
  [Water Intake Estimator - Deployed API](https://ml-summative-3.onrender.com)  
  Swagger UI for testing locally:  
  [http://127.0.0.1:8000/docs#/default/predict_water_intake_get_predict_water_intake_get)  

- **Dataset**  
  The dataset used for training the water intake prediction model is available here:  
  [https://www.kaggle.com/datasets/valakhorasani/gym-members-exercise-dataset)

  

---

## Usage  

1. Launch the app on your mobile device.  
2. Enter your personal details (age, gender, height, weight, and activity level).  
3. Click on "Calculate" to get your recommended daily water intake goal in liters. 

---

## Acknowledgments  

- This app leverages machine learning model to predict daily water intake based on personalized data.  
 
- The model was trained using a dataset that includes multiple factors influencing hydration needs.  

