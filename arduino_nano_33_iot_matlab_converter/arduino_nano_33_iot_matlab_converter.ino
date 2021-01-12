/* 
 * Arduino to MATLAB
 */
int i=0;

/* 
 * MATLAB to Arduino 
 */
int ledPin=13;
int matlabData;


void setup() 
{
  pinMode(ledPin,OUTPUT); /* MATLAB to Arduino  */
  Serial.begin(9600);
}
void loop() 
{
   /* Arduino to MATLAB */
   Serial.println(i);
   i++;

  /* MATLAB to Arduino  */
   if(Serial.available()>0) // if there is data to read
   {
    matlabData=Serial.read(); // read data
    if(matlabData==1)
      digitalWrite(ledPin,HIGH); // turn light on
    else if(matlabData==2)
      digitalWrite(ledPin,LOW); // turn light off
  }
}
