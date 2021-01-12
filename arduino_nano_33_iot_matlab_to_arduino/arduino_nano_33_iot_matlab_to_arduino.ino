/* This is code that allows the Arduino to read data sent from MATLAB.

*/

byte x;
int j = 0;
void setup() {
 Serial.begin(115200);
 delay(500);
 
}
void loop() 
{
  if(Serial.available()>0)
  {
   x = Serial.read();
   
   j++;
   
  }
  if(j>0)
  {
   if((char(x)=='7'))
   {
    Serial.println("hi");
   }
   else
   {
    Serial.println("NON");
   }
  }
}
