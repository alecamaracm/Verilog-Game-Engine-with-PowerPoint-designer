module PP2VerilogDrawingController(xPixel,yPixel,VGAr,VGAg,VGAb);

input [9:0]xPixel;
input[8:0]yPixel;
output [7:0]VGAr;
output [7:0]VGAg;
output [7:0]VGAb;
reg [7:0]VGAr;
reg [7:0]VGAg;
reg [7:0]VGAb;

always @(*)
begin
	VGAr=8'b00000000;
	VGAg=8'b00000000; 
	VGAb=8'b00000000; 
	//Drawing Solid shape Rectángulo 3
	if(xPixel>0 && xPixel<405 && yPixel>437 && yPixel<479) VGAr=8'b10100101;
	if(xPixel>0 && xPixel<405 && yPixel>437 && yPixel<479) VGAg=8'b10100101; 
	if(xPixel>0 && xPixel<405 && yPixel>437 && yPixel<479) VGAb=8'b10100101; 
	//Drawing Solid shape Rectángulo 3
	if(xPixel>73 && xPixel<123 && yPixel>201 && yPixel<439) VGAr=8'b01010100;
	if(xPixel>73 && xPixel<123 && yPixel>201 && yPixel<439) VGAg=8'b10000010; 
	if(xPixel>73 && xPixel<123 && yPixel>201 && yPixel<439) VGAb=8'b00110101; 
	//Drawing Solid shape Rectángulo 3
	if(xPixel>437 && xPixel<602 && yPixel>153 && yPixel<439) VGAr=8'b11000101;
	if(xPixel>437 && xPixel<602 && yPixel>153 && yPixel<439) VGAg=8'b01011010; 
	if(xPixel>437 && xPixel<602 && yPixel>153 && yPixel<439) VGAb=8'b00010001; 
	//Drawing Solid shape Rectángulo 3
	if(xPixel>30 && xPixel<387 && yPixel>25 && yPixel<263) VGAr=8'b10011101;
	if(xPixel>30 && xPixel<387 && yPixel>25 && yPixel<263) VGAg=8'b11000011; 
	if(xPixel>30 && xPixel<387 && yPixel>25 && yPixel<263) VGAb=8'b11100110; 
	//Drawing Solid shape Rectángulo 3
	if(xPixel>312 && xPixel<526 && yPixel>73 && yPixel<203) VGAr=8'b01110000;
	if(xPixel>312 && xPixel<526 && yPixel>73 && yPixel<203) VGAg=8'b00110000; 
	if(xPixel>312 && xPixel<526 && yPixel>73 && yPixel<203) VGAb=8'b10100000; 
end

endmodule
