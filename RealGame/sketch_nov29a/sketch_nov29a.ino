#include <Adafruit_NeoPixel.h>

Adafruit_NeoPixel strip = Adafruit_NeoPixel(12, 8, NEO_GRB + NEO_KHZ800);
int count=0;

void setup() {
  strip.begin();
  Serial.begin (500000);


}
short lastVal;
void loop() {

  

short val=(lastVal+(short)analogRead(A4))/2;
Serial.write((byte)val);
waitt(5000);
Serial.write((byte)(val>>8));
waitt(25000);




lastVal=val;

}

bool oldState=false;
bool oldDone=false;

void waitt(int ms)
{
  for(long i=0; i<ms;i+=1000)
  {
    delay(1);

    bool newState=analogRead(A2)>250;
    bool newDone=analogRead(A3)>250;

    if(newState==1 && newState!=oldState)
    {
     
      count++;
      upd();

    }
          oldState=newState;

    if(newDone==1 && oldDone!=newDone)
    {
      count=0;
       upd();
    }

          oldDone=newDone;

    
    
    i+=100;
  }
}

void upd()
{
        for(uint16_t i=0; i<strip.numPixels(); i++) {
          strip.setPixelColor(i, strip.Color(0,0,0) );
      }        
   
       for(uint16_t i=0; i<strip.numPixels(); i++) {
          if(0+i>=count) break;
          strip.setPixelColor(i, strip.Color(55,0,0) );
      }    
       for(uint16_t i=0; i<strip.numPixels(); i++) {
          if(12+i>=count) break;
          strip.setPixelColor(i, strip.Color(0,55,0) );
      }    
       for(uint16_t i=0; i<strip.numPixels(); i++) {
          if(24+i>=count) break;
          strip.setPixelColor(i, strip.Color(0,0,55) );
      }  

       for(uint16_t i=0; i<strip.numPixels(); i++) {
          if(36>=count) break;
          strip.setPixelColor(i, strip.Color(100,100,100) );
      }        
      strip.show();

}


