#include <Arduino_LSM6DS3.h>
 
void setup() {
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }
  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU!");
    while (true); // halt program
  } 
  Serial.println("IMU initialized!");
}
 
void loop() {
  float aX, aY, aZ;
  float adelta = 0.05;
  float gX, gY, gZ;
  float gdelta = 400;
  const char * spacer = ", ";
 
  if (
    IMU.accelerationAvailable() 
    && IMU.gyroscopeAvailable()
  ) {      
    IMU.readAcceleration(aX, aY, aZ);
    if(aY <= adelta && aY >= -adelta)
          Serial.println("flat");
    else if(aY > adelta && aY < 1 - adelta)
          Serial.println("tilted to the left");
    else if(aY >= 1 - adelta)
          Serial.println("left");
    else if(aY < -adelta && aY > adelta - 1)
          Serial.println("tilted to the right");
    else
          Serial.println("right");
    IMU.readGyroscope(gX, gY, gZ);
    if(gY < -gdelta)
          Serial.println("Flicked down");
    else if(gY > gdelta)
          Serial.println("Flicked up");
    Serial.print(aX); Serial.print(spacer);
    Serial.print(aY); Serial.print(spacer);
    Serial.print(aZ); Serial.print(spacer);
    Serial.print(gX); Serial.print(spacer);
    Serial.print(gY); Serial.print(spacer);
    Serial.println(gZ);
    delay(1000);
  }
}
