/*
   Servo class that I'm using to control my drumstick using a servo.
   Highly referenced the tutorial for arduino multitasking that we went over in class.
   This tutorial can be found here: https://learn.adafruit.com/multi-tasking-the-arduino-part-1?view=all

*/

class Drumstick {

    Servo servo; // initialization of servo
    int downStroke; // whether servo (drumstick) is in downstroke or upstroke
    int updateInterval; // how frequently we want to change drumstick positions
    unsigned long lastUpdate; // last update of the servo

  public:

    // initializes servo with downstroke at 0
    Drumstick(int interval) {
      downStroke = 0;
      updateInterval = interval;
    }

    // Attaches servo to pin
    void Attach(int pin) {
      servo.attach(pin);
    }

    void Update(int servoState) {

      // writes update to servo every updateInterval (bpm/2)
      if (servoState == HIGH) {
        if ((millis() - lastUpdate) > updateInterval) {
          lastUpdate = millis();

          // downStroke is when the servo will attempt to hit the drum/cymbal
          if (downStroke == 0) {
            servo.write(45);
            downStroke = 1;

            // on the upstroke, the servo will bring the drumstick back up
          } else if (downStroke == 1) {
            servo.write(1);
            downStroke = 0;
          }
        }
      }
    }
};
