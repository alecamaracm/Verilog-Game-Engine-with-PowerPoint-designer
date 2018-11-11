module main(real100clock,hsync,vsync,VGAclock,VGAr,VGAg,VGAb,VGAsync,VGAblanck,CLOCK,leds,ps2ck,ps2dt,ps2ck2,ps2dt2,butt,RX);

output [7:0]VGAr;
output [7:0]VGAg;
output [7:0]VGAb;
output VGAsync,VGAblanck;

input RX;

output [15:0]leds;	
inout ps2ck,ps2dt,ps2ck2,ps2dt2;
input butt;
input CLOCK;

wire [9:0]xPixel;
wire [8:0]yPixel;

wire [10:0]mouseX;
wire [10:0]mouseY;

wire [9:0]Basic_transparencyY;
wire [9:0]Basic_transparencyX;

wire [9:0]WasdBlockX;
wire [9:0]WasdBlockY;

wire [3:0]wasd;
wire [3:0]arrows;

wire [9:0]ArrowsBlockX;
wire [9:0]ArrowsBlockY;

wire animationClOCK;

output VGAclock;
input real100clock;
output hsync,vsync;


VGADriver driver(CLOCK,hsync,vsync,VGAclock,VGAblanck,VGAsync,xPixel,yPixel,animationClOCK);

//UART_DMA uart(CLOCK,RX,leds[15:7]);

PP2VerilogDrawingController drawings(animationClOCK,wasd,arrows,xPixel,yPixel,VGAr,VGAg,VGAb,mouseX,mouseY,Basic_transparencyX,Basic_transparencyY); //This file is generated automatically by the compiler. Please DO NOT modify it.

ps2Keyboard keyboard(CLOCK,ps2ck2,ps2dt2,wasd,arrows,leds[4],leds[5]);
ps2Mouse mouse(CLOCK,ps2ck,ps2dt,leds[0],leds[1],!butt,mouseX,mouseY);

animations1  anim1(animationClOCK,wasd,arrows,Basic_transparencyX,Basic_transparencyY);

endmodule