# Fight Car README

## Overview
This project implements a state-based "Fight Car" that uses an ultrasonic sensor to detect opponents and engage in combat. The car operates through **searching**, **attacking**, and **maneuvering** states, ensuring dynamic and interactive behavior.

---

## Components and Pins

### Sensors
- **Ultrasonic Sensor (HC-SR04)**:
  - Trigger: GPIO 0
  - Echo: GPIO 4
  - Range: 5–1000 mm
- **Encoders**:
  - Left: GPIO 16
  - Right: GPIO 5

### Motors
- **Left Motor**:
  - Forward: GPIO 14
  - Backward: GPIO 12
- **Right Motor**:
  - Forward: GPIO 13
  - Backward: GPIO 15

---

## Setup

1. **Wire Components**:
   - Ultrasonic sensor to GPIO 0 (trigger) and GPIO 4 (echo).
   - Motor driver to motor pins (see above).
   - Encoders to GPIO 16 (left) and GPIO 5 (right).
2. **Install Arduino IDE**:
   - Add ESP8266 board support via Boards Manager.
3. **Upload Code**:
   - Ensure the correct ESP8266 board is selected.
   - Adjust `speed` and `maxDistanceMM` variables as needed.

---

## Behavior

### States
1. **Searching ('a')**:
   - Rotates or moves forward.
   - Detects opponents within 5–1000 mm.
   - Transitions to attack ('b') or maneuver ('c').
2. **Attacking ('b')**:
   - Charges forward for 1 second.
   - Returns to search ('a').
3. **Maneuvering ('c')**:
   - Moves forward for 20 small steps, checking for opponents.
   - Transitions to turning ('d') if no opponent is found.
4. **Turning ('d')**:
   - Rotates incrementally to change direction.
   - Returns to maneuver ('c').

---

## Functions

### Movement
- `moveForward(speed)`: Moves forward at a given speed.
- `moveBackward(speed)`: Moves backward.
- `turnLeft(speed)`: Turns left.
- `turnRight(speed)`: Turns right.
- `stopMotors()`: Stops all motors.
- `moveLeftSteps(steps)`, `moveRightSteps(steps)`: Moves wheels using encoder feedback.

### Sensing
- `getDistanceMM()`: Returns distance to an obstacle in mm using the ultrasonic sensor.

---

## Customization

- **Speed**: Change the `speed` variable (default: 700 PWM).
- **Detection Range**: Modify `maxDistanceMM` (default: 1000 mm).
- **Timeouts**: Adjust state durations (e.g., `searchDuration`).

---
