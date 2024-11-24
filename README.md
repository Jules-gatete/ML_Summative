# ML Summative: Water Intake Estimator  

## Overview  
The **Water Intake Estimator** is a mobile application designed to predict the ideal daily water intake for users. Using personal data such as age, gender, height, weight, and activity level, the app leverages a machine learning model to recommend optimal hydration levels, helping users maintain their health and well-being.  

---

## Features  
- **User Input**: Input personal details like age, gender, height, weight, and activity level.  
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
   cd ML_Summative/backend
   ```  
2. Install the required dependencies:  
   ```bash
   pip install -r requirements.txt
   ```  
3. Start the FastAPI server:  
   ```bash
   uvicorn main:app --reload
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
  [https://vimeo.com/1032884521/a2700e91a2?share=copy)  

- **Deployed API**  
  The API is deployed and publicly available on Render:  
  [Water Intake Estimator - Deployed API](https://ml-summative.onrender.com)  
  Swagger UI for testing:  
  [http://127.0.0.1:8000/docs#/default/predict_water_intake_get_predict_water_intake_get)  

- **Dataset**  
  The dataset used for training the water intake prediction model is available here:  
  [https://www.kaggle.com/datasets/valakhorasani/gym-members-exercise-dataset)  

---

## Usage  

1. Launch the app on your mobile device.  
2. Enter your personal details (age, gender, height, weight, and activity level).  
3. Click on "Calculate" to get your recommended daily water intake goal.  
4. Save or reset the value as per your preference.  

---

## Acknowledgments  

- This app leverages machine learning to predict daily water intake based on personalized data.  
- Special thanks to the **Flutter** and **FastAPI** communities for their powerful tools and support.  
- The model was trained using a dataset that includes multiple factors influencing hydration needs.  

