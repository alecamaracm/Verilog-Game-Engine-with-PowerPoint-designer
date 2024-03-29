module RealGame(hsync,vsync,VGAclock,VGAr,VGAg,VGAb,VGAsync,VGAblanck,CLOCK,sw,leds,key,ps2ck,ps2dt,ps2ck2,ps2dt2);


output [7:0]VGAr;
output [7:0]VGAg;
output [7:0]VGAb;
output VGAsync,VGAblanck;


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

wire animationClOCK;

output VGAclock;
output hsync,vsync;

wire mouse1;
wire mouse2;

assign leds[0]=mouse1;
assign leds[1]=mouse2;
assign leds[17]=colgeniuses;

wire bouncerVISIBLE;
assign bouncerVISIBLE=!mouse1;

 
VGADriver driver(CLOCK,hsync,vsync,VGAclock,VGAblanck,VGAsync,xPixel,yPixel,animationClOCK);


PP2VerilogDrawingController drawings(CLOCK,reset,animationClOCK,wasd,arrows,xPixel,yPixel,VGAr,VGAg,VGAb,mouseX,mouseY,colgeniuses,bouncerVISIBLE);

ps2Keyboard keyboard(CLOCK,ps2ck2,ps2dt2,wasd,arrows,leds[4],leds[5]);//
ps2Mouse mouse(CLOCK,ps2ck,ps2dt,mouse1,mouse2,!key[0],mouseX,mouseY);//;


	
endmodule