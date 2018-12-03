module RealGame(hsync,vsync,VGAclock,VGAr,VGAg,VGAb,VGAsync,VGAblanck,CLOCK,sw,leds,key,ps2ck,ps2dt,ps2ck2,ps2dt2,RX,TX,GPIO0,GPIO2,GPIO3);


output [7:0]VGAr;
output [7:0]VGAg;
output [7:0]VGAb;
output VGAsync,VGAblanck;

input RX;
output GPIO0;
output GPIO2;
input GPIO3;
output [17:0]leds;
input [17:0]sw;	
input [3:0]key;
inout ps2ck,ps2dt,ps2ck2,ps2dt2;
input CLOCK;

wire [9:0]xPixel;
wire [8:0]yPixel;

wire [10:0]mouseX;
wire [10:0]mouseY;

wire [3:0]wasd;
wire [3:0]arrows;


output TX;

assign TX=RX;

wire animationClOCK;

output VGAclock;
output hsync,vsync;

wire [7:0]rrr;
wire u1;

UART2 uart(CLOCK,RX,key[1],rrr,u1,8'd0,1'b0);

VGADriver driver(CLOCK,hsync,vsync,VGAclock,VGAblanck,VGAsync,xPixel,yPixel,animationClOCK);


PP2VerilogDrawingController drawings(CLOCK,key[2],animationClOCK,wasd,arrows,xPixel,yPixel,VGAr,VGAg,VGAb,mouseX,mouseY); //This file is generated automatically by the compiler. Please DO NOT modify it.

ps2Keyboard keyboard(CLOCK,ps2ck2,ps2dt2,wasd,arrows,leds[4],leds[5]);//
ps2Mouse mouse(CLOCK,ps2ck,ps2dt,leds[0],leds[1],!key[0],mouseX,mouseY);//;

buzzing buz(CLOCK,GPIO0,GPIO2,GPIO3,leds[17:8]);

endmodule