void setup() {
  // put your setup code here, to run once:
  pinMode(8,INPUT);
  Serial.begin(500000);
}

void loop() {
  // put your main code here, to run repeatedly:
 // Serial.print("X: ");
 //Serial.print(analogRead(A0));
  //Serial.print("  |Y: ");
 // Serial.print(analogRead(A1));
 // Serial.print("  |BTT: ");
 // Serial.println(digitalRead(8));
 
  
  Serial.write(255-(byte)(map(analogRead(A0),0,1024,50,205)));
 //Serial.println((analogRead(A0)/4));
  //Serial.write((byte)10);
  // delay(3);
   Serial.write((byte)(map(analogRead(A1),0,1024,50,205)));
  // Serial.println((analogRead(A1)/4));
 // Serial.write((byte)160);
   // delay(3);
  Serial.write((byte)0);
  //Serial.write((byte)0);
    delay(10);

}
