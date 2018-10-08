module main(real100clock,testOut1,hsync,vsync,VGAclock,VGAr,VGAsync,VGAblanck,t1,t2,t3);

output [7:0]VGAr;
output VGAsync,VGAblanck;

assign VGAr=0;
output VGAclock;
input real100clock;
output testOut1;
output hsync,vsync;

input t1,t2,t3;


assign VGAsync=1'b0;
//assign VGAblanck=1'b1;
//assign VGAsync=t1;
//assign VGAblanck=t2;
//assign VGAclock=t3;


VGADriver driver(real100clock,testOut1,hsync,vsync,VGAclock,VGAblanck);


endmodule