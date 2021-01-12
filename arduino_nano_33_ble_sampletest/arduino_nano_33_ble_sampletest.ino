byte ByteArr[20];
int i = 0;
int ii = 0;
int AccelValue = 0;
int LastAccelValue = 0;
int dValue = 0;

void setup()
{
  //Put your setup code here, to run once:
    
  //Opens serial port, sets data rate.
  Serial.begin(9600);
  //Serial.begin(115200); 
    
  //A5 => High impedance
  pinMode(A5, INPUT);
  digitalWrite(A5, LOW);
  //A5 => (+)
  //pinMode(A5, OUTPUT);
  //digitalWrite(A5, HIGH);
    
  //A1 => GND   
  pinMode(A1, OUTPUT);
  digitalWrite(A1, LOW);
    
  //A0 => High impedance
  //pinMode(A0, INPUT);
  //digitalWrite(A0, LOW);
    
  //Configures the reference voltage used for analog input (i.e. the value used as the top of the input range).
 // analogReference(EXTERNAL); //EXTERNAL: the voltage applied to the AREF pin (0 to 5V only) is used as the reference.

  //D4 => (+)
  pinMode(4, OUTPUT); 
  digitalWrite(4, HIGH);
    
  //D5 => GND
  pinMode(5, OUTPUT); 
  digitalWrite(5, LOW);

  delay(500); //Pauses the program for the amount of time (in miliseconds) specified as parameter.
}

void loop() 
{
  //Put your main code here, to run repeatedly:

  AccelValue = analogRead(A3); //Reads the value from the specified analog pin. This means that it will map input voltages between 0V and reference voltage into integer values between 0 and 1023.
  
  if (i < 3)
  {
    ByteArr[ii] = char(-128);
    i++;
    ii++;
    ByteArr[ii] = highByte(AccelValue);
    i++;
    ii++;    
    ByteArr[ii] = lowByte(AccelValue);
  }
  else
  {
    dValue = AccelValue - LastAccelValue;
    if (abs(dValue) > 127)
    {
      ByteArr[ii] = char(-128);
      i++;
      ii++;
      WriteFunction();
      
      ByteArr[ii] = highByte(AccelValue);
      i++;
      ii++;
      WriteFunction();
      
      ByteArr[ii] = lowByte(AccelValue);
    }
    else
    {
      ByteArr[ii] = char(dValue);
    }
  }
  LastAccelValue = AccelValue;
    
  i++;
  ii++;
  WriteFunction();

  //delay(3); //~319 Hz.
  delayMicroseconds(1000); //~880 Hz. MAX for Serial.begin(9600). delayMicroseconds(1000) = delay(1)
  //delayMicroseconds(400); //Serial.begin(115200), ~1867 Hz. MAX  
}

void WriteFunction()
{
  if (ii == 20) 
  {
    Serial.write(ByteArr, ii);
    ii = 0;
  }
  
  if (i >= 200)
  {
    i = 0;
  }
}
