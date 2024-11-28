#include <Wire.h>
#include <Adafruit_VL53L0X.h>
#include <Servo.h>

// Constants
const int servoPin = 13;          // GPIO pin for the servo
const int targetDistance = 150;  // Desired distance (mm)
const int maxDistance = 250;     // Maximum measurable distance (mm)
const int minDistance = 50;      // Minimum measurable distance (mm)

// PID constants (initial values, tweak later)
float kp = 0.2;  // Proportional gain
float ki = 0.01;//.05; // Integral gain
float kd = 0.8;  // Derivative gain //Not sure if it was 1.8 instead

// 1st recom 0.2  0.01 0.8
// mine      0.18
// 2nd recom           0.88
// mine                0.78

// Variables for PID
float previousError = 0;
float integral = 0;

// Distance sensor
Adafruit_VL53L0X lox = Adafruit_VL53L0X();

// Servo motor
Servo sliderServo;

void setup() {
  // Initialize serial communication
  Serial.begin(115200);

  // Initialize the VL53L0X sensor
  if (!lox.begin()) {
    Serial.println("Failed to initialize VL53L0X sensor!");
    while (1) { delay(10); }
  }

  // Attach the servo motor
  sliderServo.attach(servoPin);

  // Set initial servo position
  sliderServo.write(90); // Center position
}

void loop() {
  VL53L0X_RangingMeasurementData_t measure;

  // Read distance from the sensor
  lox.rangingTest(&measure, false);

  if (measure.RangeStatus != 4) { // Valid measurement
    float currentDistance = measure.RangeMilliMeter;

    // Calculate error
    float error = targetDistance - currentDistance;

    // Calculate integral
    integral += error;

    // Calculate derivative
    float derivative = error - previousError;

    // PID output
    float pidOutput = (kp * error) + (ki * integral) + (kd * derivative);

    // Update previous error
    previousError = error;

    // Map PID output to servo angle (limits between 0 and 180 degrees)
    int servoPosition = constrain(map(pidOutput, -100, 100, 0, 180), 0, 180);

    // Move the servo
    sliderServo.write(servoPosition);

    // Log for debugging
    Serial.print("Distance: ");
    Serial.print(currentDistance);
    Serial.print(" mm, Error: ");
    Serial.print(error);
    Serial.print(", PID Output: ");
    Serial.println(pidOutput);
  } else {
    // If out of range, stop the servo (optional)
    sliderServo.write(90); // Neutral position
  }

  delay(33); // Small delay for stability
}
