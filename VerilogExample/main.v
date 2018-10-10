module main(real100clock,hsync,vsync,VGAclock,VGAr,VGAg,VGAb,VGAsync,VGAblanck);

output [7:0]VGAr;
output [7:0]VGAg;
output [7:0]VGAb;
output VGAsync,VGAblanck;



wire [9:0]xPixel;
wire [8:0]yPixel;




output VGAclock;
input real100clock;
output hsync,vsync;


VGADriver driver(real100clock,hsync,vsync,VGAclock,VGAblanck,VGAsync,xPixel,yPixel);

PP2VerilogDrawingController drawings(xPixel,yPixel,VGAr,VGAg,VGAb);


endmodule