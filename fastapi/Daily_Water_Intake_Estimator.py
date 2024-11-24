# Import necessary libraries
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import pandas as pd
from sklearn.preprocessing import LabelEncoder
import joblib

# Initialize FastAPI
app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins (use more specific origins in production)
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Recreate LabelEncoder and fit it on all categories (must match training data)
label_encoder_gender = LabelEncoder()
label_encoder_workout_type = LabelEncoder()

# These should have been fitted on the entire dataset during training
label_encoder_gender.fit(['male', 'female'])
label_encoder_workout_type.fit(['sedentary', 'light', 'moderate', 'heavy'])

# Load the trained Random Forest model (if saved previously)
try:
    model_pipeline = joblib.load('random_forest_model.joblib')  # Load your trained RandomForest model
    print("Model loaded successfully!")
except FileNotFoundError:
    print("Error: Model file not found. Please ensure the model is saved correctly.")

# Pydantic model for the request body
class WaterIntakeRequest(BaseModel):
    age: int
    gender: str
    height: float
    weight: float
    workout_type: str

# Root GET endpoint
@app.get("/")
async def read_root():
    return {"message": "Welcome to the Water Intake Estimator"}

# GET endpoint for water intake prediction with query parameters
@app.get("/predict-water-intake")
async def predict_water_intake_get(age: int, gender: str, height: float, weight: float, workout_type: str):
    try:
        # Validate and process input for GET request (query parameters)
        gender = gender.strip().lower()
        if gender not in ['male', 'female']:
            raise HTTPException(status_code=400, detail="Invalid gender. Please provide 'male' or 'female'.")
        encoded_gender = label_encoder_gender.transform([gender])[0]

        work_type = workout_type.strip().lower()
        if work_type not in ['sedentary', 'light', 'moderate', 'heavy']:
            raise HTTPException(status_code=400, detail="Invalid workout type. Please provide 'sedentary', 'light', 'moderate', or 'heavy'.")
        encoded_work_type = label_encoder_workout_type.transform([work_type])[0]

        # Prepare user input for prediction
        input_data = {
            'Age': [age],
            'Height (m)': [height],
            'Weight (kg)': [weight],
            'Gender': [encoded_gender],  # Use encoded value for gender
            'Workout_Type': [encoded_work_type]  # Use encoded value for workout type
        }

        # Convert to DataFrame
        input_df = pd.DataFrame(input_data)

        # Predict the target value (daily water intake)
        prediction = model_pipeline.predict(input_df)  # Use the Random Forest model to make predictions

        # Return the prediction with the word "liters"
        return {"predicted_daily_water_intake": str(round(prediction[0], 2)) + " liters"}  # Return as JSON response
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# To run the app: `uvicorn Daily_Water_Intake_Estimator:app --reload`
