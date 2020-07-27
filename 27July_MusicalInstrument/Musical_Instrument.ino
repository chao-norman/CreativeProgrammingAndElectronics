#include <Servo.h>
#include "pitches.h"
#include "Drumstick.h"
#include "notes.h"

// input pins
const int slideSwitch = A0;
const int pot = A1;
const int redButton = A2;
const int yellowButton = A3;
const int blueButton = A4;
const int greenButton = A5;

// output pins
const int piezo = 8;
const int servo = 7;

// initializer servo drumstick
Drumstick drumstick(500);

// index for notes array (decide which part of music scale you're on)
int index = 0;

void setup() {

  // initialize serial input
  Serial.begin(9600);

  // initialize all buttons as inputs
  pinMode(redButton, INPUT);
  pinMode(yellowButton, INPUT);
  pinMode(blueButton, INPUT);
  pinMode(greenButton, INPUT);

  // attach servo on pin 7 to the servo drumstick
  drumstick.Attach(servo);

}

void loop() {

  // read potentiator value
  int potValue = analogRead(pot);
  int interval = map(potValue, 0, 1023, 100, 5000);

  // read state of each button value
  int redState = digitalRead(redButton);
  int yellowState = digitalRead(yellowButton);
  int blueState = digitalRead(blueButton);
  int greenState = digitalRead(greenButton);
  int slideSwitchState = digitalRead(slideSwitch);

  // update drumstick motion based on slide switch state
  drumstick.Update(slideSwitchState);

  // pick which part of scale to play from based on potentiometer
  // I only have 16 notes available across 4 buttons, but this can
  // be easily changed.
  if (interval <= 5000 / 4) {
    index = 0;
  } else if (interval <= 5000 / 4 * 2) {
    index = 1;
  } else if (interval <= 5000 / 4 * 3) {
    index = 2;
  } else if (interval <= 5000 / 4 * 4) {
    index = 3;
  }

  // play appropriate note from redButtonNotes array based on potentiometer value
  if (redState == HIGH) {
    //Serial.println("red");
    Serial.println(redButtonNotes[index]);
    tone(piezo, redButtonNotes[index], 80);
  }

  // play appropriate note from yellowButtonNotes array based on potentiometer value
  if (yellowState == HIGH) {
    //Serial.println("yell");
    Serial.println(yellowButtonNotes[index]);
    tone(piezo, yellowButtonNotes[index], 80);
  }

  // play appropriate note from blueButtonNotes array based on potentiometer value
  if (blueState == HIGH) {
    //Serial.println("blue");
    Serial.println(blueButtonNotes[index]);
    tone(piezo, blueButtonNotes[index], 80);
  }

  // play appropriate note from greenButtonNotes array based on potentiometer value
  if (greenState == HIGH) {
    //Serial.println("green");
    Serial.println(greenButtonNotes[index]);
    tone(piezo, greenButtonNotes[index], 80);
  }

}
