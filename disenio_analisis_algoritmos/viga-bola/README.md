# PID Servo Control with VL53L0X Sensor

## Overview
This project uses a **VL53L0X ToF sensor** and a servo motor to maintain a target distance from an object using a **PID control loop**. The system adjusts the servo angle dynamically to minimize the error between the target and measured distances.

---

## Hardware

### Components
- **VL53L0X Sensor**: Measures distance (50–250 mm range).
- **Servo Motor**: Adjusts based on PID output.
- **Microcontroller**: Runs the PID algorithm and controls the servo.

### Connections
- **Servo Pin**: GPIO 13
- **VL53L0X Sensor**: I2C (SDA/SCL)

---

## How It Works

### PID Control
The PID (Proportional-Integral-Derivative) controller minimizes the error between the **target distance** and the measured distance using three terms:

1. **Proportional (P)**:
   - Reacts to the current error \( \text{error} = \text{targetDistance} - \text{currentDistance} \).
   - Scaled by `kp`, it provides immediate response but may overshoot.

2. **Integral (I)**:
   - Sums past errors, accumulating over time to correct for consistent, small deviations.
   - Scaled by `ki`, it ensures long-term accuracy but may cause slow oscillations if too large.

3. **Derivative (D)**:
   - Reacts to the rate of change of the error, predicting future trends.
   - Scaled by `kd`, it reduces overshoot and smooths responses.

### PID Formula
The PID output is calculated as:
\[
\text{PID Output} = (kp \times \text{error}) + (ki \times \text{integral}) + (kd \times \text{derivative})
\]

The output is mapped to servo positions (0° to 180°), ensuring the system maintains the desired distance.

---

## Key Parameters
- **Target Distance**: 150 mm
- **PID Constants** (tunable):
  - `kp = 0.2`, `ki = 0.01`, `kd = 0.8`
- **Servo Position Range**: 0° to 180°

---

## Usage

1. **Power On**: The servo centers initially (90°).
2. **Behavior**:
   - The system reads the distance from the VL53L0X sensor.
   - The PID controller adjusts the servo to minimize the distance error.
3. **Tuning**:
   - Adjust `kp`, `ki`, and `kd` for desired responsiveness and stability.

---

## Notes
- Use small `ki` to avoid oscillations.
- For debugging, observe PID outputs and sensor readings via the serial monitor.

---
