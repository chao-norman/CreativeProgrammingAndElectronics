/*
  I wanted to make the yellow light be an analog light which dims and brightens to simulate daylight, and 
  the blue light flash at random intervals in order to simulate lightning.

  I used the "Fading" example as a reference to dealing with analog output.
*/

// Set pin numbers for inputs
const int photoresistorPin = A0;
const int buttonPin = A2;

// Set pin numbers for outputs
const int blueLightPin = 13;
const int yellowLightPin = 9; // on ~9 pin because it can do analogWrite

// state variable for tracking photoreceptor
int photoreceptorPinged = 0;

// setup routine that runs when you press reset
void setup() {

  // initialize serial communication at 9600 bits per second
  Serial.begin(9600);

  // initialize buttonPin as button INPUT for blue light (lightning)
  pinMode(buttonPin, INPUT);

  // initialize blueLightPin as OUTPUT for blue light (lightning)
  pinMode(blueLightPin, OUTPUT);

}

// loop routine that runs repeatedly forever
void loop() {

  // read INPUT on photoresistorPin
  int sensorValue = analogRead(photoresistorPin);

  // read INPUT on buttonPin
  int buttonState = digitalRead(buttonPin);

  // if button was pressed, flash blue light randomly (lightning)
  if (buttonState == HIGH) {
    for (int i = int(random(1, 3)); i < 5; i++) {
      digitalWrite(blueLightPin, HIGH);
      delay(random(50, 500));
      digitalWrite(blueLightPin, LOW);
      delay(random(50, 500));
    }
    // otherwise, keep blue light off
  } else {
    digitalWrite(blueLightPin, LOW);
  }

  // if photoreceptor is NOT blocked, fade yellow light on (transition from night to day)
  if (sensorValue >= 300) {

    // if photoreceptor was pinged already
    if (photoreceptorPinged = 1) {

      // change state variable to false since we are ready for another ping
      photoreceptorPinged = 0;

      // fade in from min to max brightness in increments of 5 points
      for (int brightness = 0; brightness <= 255; brightness += 5) {
        // set brightness of yellowLightPin
        analogWrite(yellowLightPin, brightness);
        // delay in between writes for visibility of dimming effect
        delay(30);
      }
    }

    // if photoreceptor is blocked, fade yellow light off (transition from day to night)
  } else if (sensorValue < 300) {

    // if the photoreceptor was pinged and it's still being covered
    if (photoreceptorPinged == 0) {

      // change state variale to true since we dealt with the ping already
      photoreceptorPinged = 1;

      // fade out from max to min brightness in increments of 5 points
      for (int brightness = 255; brightness >= 0; brightness -= 5) {
        // set brightness of yellowLightPin
        analogWrite(yellowLightPin, brightness);
        // delay in between writes for visibility of dimming effect
        delay(30);
      }
    }
  }
}
