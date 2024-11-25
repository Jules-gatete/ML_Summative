from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, root_validator
from typing import Literal
import pandas as pd
import joblib
from sklearn.preprocessing import LabelEncoder

# Initialize FastAPI app
app = FastAPI()

# Recreate LabelEncoder and fit it on all categories
label_encoder_gender = LabelEncoder()
label_encoder_workout_type = LabelEncoder()

# Fitting on the categories used during model training
label_encoder_gender.fit(["male", "female"])
label_encoder_workout_type.fit(["sedentary", "light", "moderate", "heavy"])

# Load the trained Random Forest model
try:
    model_pipeline = joblib.load("random_forest_model.joblib")  
except FileNotFoundError:
    raise Exception("Model file not found. Please ensure it is saved correctly.")

# Input schema using Pydantic
class UserInput(BaseModel):
    age: int
    gender: Literal["male", "female"]
    height: float  # Height in meters
    weight: float  # Weight in kg
    workout_type: Literal["sedentary", "light", "moderate", "heavy"]

    @root_validator(pre=True)
    def normalize_fields(cls, values):
        """
        Normalize gender and workout_type to lowercase for consistency.
        """
        if "gender" in values:
            values["gender"] = values["gender"].lower()
        if "workout_type" in values:
            values["workout_type"] = values["workout_type"].lower()
        return values

@app.get("/")
def read_root():
    """
    Root endpoint to confirm the API is running.
    """
    return {"message": "Welcome to the Water Intake Prediction API"}

@app.post("/predict/")
def predict_water_intake(user_input: UserInput):
    """
    Predict daily water intake based on user inputs.
    """
    # Validate inputs
    if not (0 <= user_input.age <= 120):
        raise HTTPException(status_code=400, detail="Enter a valid age in years.")
    if not (0.5 <= user_input.height <= 2.5):
        raise HTTPException(status_code=400, detail="Enter a valid height in meters.")
    if not (10 <= user_input.weight <= 300):
        raise HTTPException(status_code=400, detail="Enter a valid weight in kilograms.")

    # Encode categorical inputs
    try:
        encoded_gender = label_encoder_gender.transform([user_input.gender])[0]
        encoded_workout_type = label_encoder_workout_type.transform([user_input.workout_type])[0]
    except ValueError as e:
        raise HTTPException(status_code=400, detail=f"Invalid input for categorical variables: {str(e)}")

    # Prepare input DataFrame for prediction
    input_data = pd.DataFrame({
        "Age": [user_input.age],
        "Height (m)": [user_input.height],
        "Weight (kg)": [user_input.weight],
        "Gender": [encoded_gender],
        "Workout_Type": [encoded_workout_type]
    })

    # Predict using the model
    try:
        prediction = model_pipeline.predict(input_data)
        return {"predicted_water_intake": round(prediction[0], 2)}  
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction error: {str(e)}")
