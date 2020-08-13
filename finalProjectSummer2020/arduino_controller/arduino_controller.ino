/*
   Code to collect input and send output to arduino controller.

   Credits/References:
   - Rotary Encoder Tutorial: Dejan Nedelkovski
   https://howtomechatronics.com/tutorials/arduino/rotary-encoder-works-use-arduino/

*/

#include <LiquidCrystal.h>

// rotary encoder variables
int rotaryEncoderA = 4;
int rotaryEncoderB = 3;
int rotaryEncoderCounter = 0;
int aState;
int aLastState;

// radio button variables
int backButton = A1;
int forwardButton = A0;

LiquidCrystal lcd(13, 12, 11, 10, 9, 8);

int currSong = 0;

// Store artists and titles of all the songs
String songAuthor[7] = {"Y. Hirasaka     ", "Y. Hirasaka     ", "Y. Hirasaka     ",
                        "Phil&Sleepy     ", "Clap Cotton     ", "L'indecis       ", "goose&Anbu&Phil "
                       };
String songTitle[7] = {"bittersweet", "Relation        ", "Little by Little",
                       "Away/wTheFairies", "Vinho Verde     ", "Keep On         ", "Last Night      "
                      };

void setup() {

  Serial.begin(9600);

  lcd.begin(16, 2);
  lcd.clear();

  pinMode(rotaryEncoderA, INPUT);
  pinMode(rotaryEncoderB, INPUT);
  pinMode(backButton, INPUT);
  pinMode(forwardButton, INPUT);

  // read initial state of rotaryEncoderA
  aLastState = digitalRead(rotaryEncoderA);
}

void loop() {

  // rotary encoder sampling
  aState = digitalRead(rotaryEncoderA);
  if (aState != aLastState) {
    if (digitalRead(rotaryEncoderB) != aState) {
      rotaryEncoderCounter++;
    } else {
      rotaryEncoderCounter--;
    }
  }
  aLastState = aState;

  // radio button sampling
  int backButtonState = digitalRead(backButton);
  int forwardButtonState = digitalRead(forwardButton);

  // send data through Serial
  Serial.print(rotaryEncoderCounter);
  Serial.print(",");
  Serial.print(backButtonState);
  Serial.print(",");
  Serial.println(forwardButtonState);

  // wait for incoming serial data from processing program
  if (Serial.available() > 0) {
    currSong = Serial.read();
  }

  // lcd
  lcd.setCursor(0, 0);              //set the cursor to the 0,0 position (top left corner)
  lcd.print(songAuthor[currSong]);
  lcd.setCursor(0, 1);              //move the cursor to the first space of the bottom row
  lcd.print(songTitle[currSong]);

}
