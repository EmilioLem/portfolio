// Motor Pins
//right
const int motor2Pin1 = 13; //forward
const int motor2Pin2 = 15;
//left
const int motor1Pin2 = 14; //forward
const int motor1Pin1 = 12;

const int speed = 700;  // Lower speed PWM (Range: 0-1023 for ESP8266)

const int trigPin = 0; // GPIO 0 for the trigger pin
const int echoPin = 4; // GPIO 4 for the echo pin
const unsigned long maxDistanceMM = 1000;
const unsigned long timeout = 2 * maxDistanceMM / 0.343; // in microseconds

const int encoderLeftPin = 16;  // GPIO 16 for left encoder
const int encoderRightPin = 5;  // GPIO 5 for right encoder


void setup() {
  Serial.begin(115200);

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  // Set motor pins as outputs
  pinMode(motor1Pin1, OUTPUT); //Derecha
  pinMode(motor1Pin2, OUTPUT);
  pinMode(motor2Pin1, OUTPUT);
  pinMode(motor2Pin2, OUTPUT);

  stopMotors();

  // Set encoder pins as inputs
  pinMode(encoderLeftPin, INPUT_PULLUP);
  pinMode(encoderRightPin, INPUT_PULLUP);

}

char currentState = 'a'; // Initial state
unsigned long stateStartTime = 0; // To track the state duration
const unsigned long searchDuration = 5000; // 5 seconds

void loop() {
  switch (currentState) {
    case 'a': {
      // State 'a': Look for opponent for 5 seconds
      if (millis() - stateStartTime > searchDuration) {
        // Timeout: No opponent detected, go to state 'c'
        currentState = 'c';
        stateStartTime = millis();
      } else {
        int distance = getDistanceMM();
        if (distance >= 5 && distance <= 1000) {
          // Opponent detected: Switch to attack mode (state 'b')
          currentState = 'b';
          stateStartTime = millis();
        } else {
          // Keep searching
          rightForward(200); // Adjust speed as needed
        }
      }
      break;
    }
    case 'b': {
      // State 'b': Attack the opponent
      moveForward(speed); // Assume this is your custom function for max speed
      delay(1000); // Attack duration (1 second here)
      stopMotors(); // Stop after the attack
      currentState = 'a'; // Return to searching
      stateStartTime = millis();
      break;
    }
    case 'c': {
      // State 'c': Move forward 20 steps to search
      for (int i = 0; i < 20; ++i) {
        moveLeftSteps(1);
        moveRightSteps(1);
        // Check for opponent during each step
        int distance = getDistanceMM();
        if (distance >= 5 && distance <= 1000) {
          // Opponent detected: Switch to attack mode (state 'b')
          currentState = 'b';
          stateStartTime = millis();
          return; // Exit loop immediately to start attacking
        }
      }
      currentState = 'd'; // Transition to turn routine
      stateStartTime = millis();
      break;
    }
    case 'd': {
      // State 'd': Turn to search in a new direction
      for (int i = 0; i < 8; ++i) {
        moveLeftSteps(1); // Left motor forward for turning right
        // Check for opponent during each step
        int distance = getDistanceMM();
        if (distance >= 5 && distance <= 1000) {
          // Opponent detected: Switch to attack mode (state 'b')
          currentState = 'b';
          stateStartTime = millis();
          return; // Exit loop immediately to start attacking
        }
      }
      currentState = 'c'; // Return to moving forward
      stateStartTime = millis();
      break;
    }
    default: {
      // Safety fallback
      stopMotors();
      currentState = 'a'; // Reset to initial state
      stateStartTime = millis();
      break;
    }
  }

  //moveForward(40);
}

/*void loop() {
  
  rightForward(speed);
  delay(700);
  rightReward(speed); 
  delay(700);
  stopMotors();

  delay(3000);

  //Serial.println(getDistanceMM());
  //delay(30);

  moveLeftSteps(1);
  moveRightSteps(1);

  delay(20);  // Wait before moving again

}*/

int getDistanceMM(){
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  long duration = pulseIn(echoPin, HIGH, timeout);
  if (duration == 0) {
    return 0;
  } else {
    return duration * 0.343 / 2;
  }
}



void leftForward(int speed){
  analogWrite(motor1Pin1, speed);
  digitalWrite(motor1Pin2, LOW);
}

void leftReward(int speed){
  digitalWrite(motor1Pin1, LOW);
  analogWrite(motor1Pin2, speed);
}
void rightForward(int speed){
  analogWrite(motor2Pin1, speed);
  digitalWrite(motor2Pin2, LOW);
}

void rightReward(int speed){
  digitalWrite(motor2Pin1, LOW);
  analogWrite(motor2Pin2, speed);
}
////////////////////



// Motor control functions
void moveForward(int speed) {
  int nuevaVel = speed;
  analogWrite(motor1Pin1, nuevaVel);
  digitalWrite(motor1Pin2, LOW);

  analogWrite(motor2Pin1, speed);
  digitalWrite(motor2Pin2, LOW);
}

void moveBackward(int speed) {
  int nuevaVel = speed;
  digitalWrite(motor1Pin1, LOW);
  analogWrite(motor1Pin2, nuevaVel);

  digitalWrite(motor2Pin1, LOW);
  analogWrite(motor2Pin2, speed);
}

void turnLeft(int speed) {
  analogWrite(motor1Pin1, speed/2); // Left motor slow, right motor fast
  digitalWrite(motor1Pin2, LOW);
  digitalWrite(motor2Pin1, LOW);
  analogWrite(motor2Pin2, speed/2);
}

void turnRight(int speed) {
  digitalWrite(motor1Pin1, LOW);
  analogWrite(motor1Pin2, speed/2);    // Right motor slow, left motor fast
  analogWrite(motor2Pin1, speed/2);
  digitalWrite(motor2Pin2, LOW);
}

void stopMotors() {
  digitalWrite(motor1Pin1, LOW);
  digitalWrite(motor1Pin2, LOW);
  digitalWrite(motor2Pin1, LOW);
  digitalWrite(motor2Pin2, LOW);
}

void moveLeftSteps(int steps) {
  int currentSteps = 0;              // Initialize step counter
  int lastState = digitalRead(encoderLeftPin); // Read initial state of the encoder

  leftForward(speed);                // Start the left motor
  while (currentSteps < steps) {     // Loop until the required steps are reached
    int currentState = digitalRead(encoderLeftPin); // Read current encoder state
    if (currentState != lastState) { // Detect state change (step)
      currentSteps++;                // Increment step counter
      lastState = currentState;      // Update last state
    }
  }
  stopMotors();                      // Stop the motor after steps are completed
}

// Move right wheel by a specific number of steps
void moveRightSteps(int steps) {
  int currentSteps = 0;              // Initialize step counter
  int lastState = digitalRead(encoderRightPin); // Read initial state of the encoder

  rightForward(speed);               // Start the right motor
  while (currentSteps < steps) {     // Loop until the required steps are reached
    int currentState = digitalRead(encoderRightPin); // Read current encoder state
    if (currentState != lastState) { // Detect state change (step)
      currentSteps++;                // Increment step counter
      lastState = currentState;      // Update last state
    }
  }
  stopMotors();                      // Stop the motor after steps are completed
}
