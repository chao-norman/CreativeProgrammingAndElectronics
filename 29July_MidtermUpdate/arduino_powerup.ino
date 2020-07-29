/*
   This is an accessory program for my midterm game Bunny Ball. It requires
   an ardunio to run. This program will read input from a green button on the
   arduino and when pressed, it will activate a power up in Bunny Ball. There
   are also green LEDs which indicate when the power up is ready.

   I used the physicalPixel example as reference!

*/

// Set pins to control LEDs
const int redLightPin = 9;
const int yellowLightPin = 11;
const int greenLightPin = 13;

// Set pin to get button input
const int buttonPin = A0;

void setup() {
  Serial.begin(9600);

  // initialize button pin as input
  pinMode(buttonPin, INPUT);

  // initialize LED pins as output
  pinMode(redLightPin, OUTPUT);
  pinMode(yellowLightPin, OUTPUT);
  pinMode(greenLightPin, OUTPUT);
}

void loop() {

  int buttonState = digitalRead(buttonPin);

  if (buttonState == HIGH) {
    Serial.println("1");
  } else {
    Serial.println("0");
  }

  // Wait for incoming serial data from processing program
  if (Serial.available() > 0) {

    // read oldest byte in serial buffer
    int incomingByte = Serial.read();

    // if byte is a 'Y', turn on yellow LED:
    if (incomingByte == 'Y') {
      digitalWrite(yellowLightPin, HIGH); // yellow high
      digitalWrite(redLightPin, LOW);
      digitalWrite(greenLightPin, LOW);
    } else if (incomingByte == 'R') {
      digitalWrite(yellowLightPin, LOW);
      digitalWrite(redLightPin, HIGH); // red high
      digitalWrite(greenLightPin, LOW);
    } else if (incomingByte == 'G') {
      digitalWrite(yellowLightPin, LOW);
      digitalWrite(redLightPin, LOW);
      digitalWrite(greenLightPin, HIGH); // green high
    }
  }

  // wait a bit for the analog-to-digital converter to stabilize after last reading
  delay(2);
}
