module main(hsync,vsync,VGAclock,VGAr,VGAg,VGAb,VGAsync,VGAblanck,CLOCK,sw,leds,key,ps2ck,ps2dt,ps2ck2,ps2dt2,RX);//SDdt,SDaddr,SDdq,SDclk,SDclke,SDwe,SDcas,SDras,SDcs,SDba);

output [7:0]VGAr;
output [7:0]VGAg;
output [7:0]VGAb;
output VGAsync,VGAblanck;

input RX;

output [17:0]leds;
input [17:0]sw;	
input [3:0]key;
inout ps2ck,ps2dt,ps2ck2,ps2dt2;
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
output hsync,vsync;

/*inout [15:0]SDdt;
output [12:0]SDaddr;
output [1:0]SDdq;
output SDclk,SDclke,SDwe,SDcas,SDras,SDcs;
output [1:0]SDba;*/


VGADriver driver(CLOCK,hsync,vsync,VGAclock,VGAblanck,VGAsync,xPixel,yPixel,animationClOCK);


PP2VerilogDrawingController drawings(CLOCK,animationClOCK,wasd,arrows,xPixel,yPixel,VGAr,VGAg,VGAb,mouseX,mouseY); //This file is generated automatically by the compiler. Please DO NOT modify it.

ps2Keyboard keyboard(CLOCK,ps2ck2,ps2dt2,wasd,arrows,leds[4],leds[5]);
ps2Mouse mouse(CLOCK,ps2ck,ps2dt,leds[0],leds[1],!key[0],mouseX,mouseY);

//animations1  anim1(animationClOCK,wasd,arrows,Basic_transparencyX,Basic_transparencyY);

//DO NOT USE - SDRAM ram(CLOCK,sw[17:10],leds[17:10],key[1],key[3],key[2],SDdt,SDaddr,SDdq,SDclk,SDclke,SDwe,SDcas,SDras,SDcs,SDba);



endmodule