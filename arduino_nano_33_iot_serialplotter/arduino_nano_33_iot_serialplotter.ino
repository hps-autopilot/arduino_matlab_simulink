void setup() {
  Serial.begin(9600);

}

void loop() {
  
  for (int d = 0; d < 360; d++){
    Serial.print(cos(DEG_TO_RAD * d));
    Serial.print(" ");
    Serial.println(sin(DEG_TO_RAD * d));
  }

}
