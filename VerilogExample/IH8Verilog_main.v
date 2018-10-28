module PP2VerilogDrawingController(xPixel,yPixel,VGAr,VGAg,VGAb,mouseX,mouseY);

input [9:0]xPixel;
input[8:0]yPixel;
input [10:0]mouseX;
input [10:0]mouseY;
output [7:0]VGAr;
output [7:0]VGAg;
output [7:0]VGAb;
reg [7:0]VGAr;
reg [7:0]VGAg;
reg [7:0]VGAb;

always @(*)
begin

	//Writing backgound color
	VGAr = 8'b00011001;
	VGAg = 8'b00101101; 
	VGAb = 8'b00001010; 

	//Drawing Solid shape "Bottom properties"
	if(xPixel>53 && xPixel<639 && yPixel>385 && yPixel<479)
	begin
		VGAr = 8'b10101111;
		VGAg = 8'b10101011;
		VGAb = 8'b10101011;
		if(xPixel<54 || xPixel>638 || yPixel<386 || yPixel>478)    //Drawing border
		begin
			VGAr = 8'b00101111;
			VGAg = 8'b01010010;
			VGAb = 8'b10001111;
		end
	end

	//Drawing Solid shape "Random Orange box"
	if(xPixel>439 && xPixel<604 && yPixel>41 && yPixel<384)
	begin
		VGAr = 8'b11000101;
		VGAg = 8'b01011010;
		VGAb = 8'b00010001;
	end

	//Drawing Solid shape "Solid purple with transparent border"
	//   --> Allowed 50% transparent render
	if(xPixel>69 && xPixel<348 && yPixel>59 && yPixel<187)
	begin
		VGAr = 8'b01110000;
		VGAg = 8'b00110000;
		VGAb = 8'b10100000;
		if(xPixel<71 || xPixel>346 || yPixel<61 || yPixel>185)    //Drawing border
		begin
			VGAr = (8'b11111111 + VGAr) / 2;
			VGAg = (8'b11011001 + VGAg) / 2;
			VGAb = (8'b01100110 + VGAb) / 2;
		end
	end

	//Drawing Solid shape "Basic transparency"
	//   --> Allowed 50% transparent render
	if(xPixel>24 && xPixel<412 && yPixel>231 && yPixel<299)
	begin
		VGAr = 8'b01010100;
		VGAg = 8'b10000010;
		VGAb = 8'b00110101;
	end

	//Drawing Solid shape "High transparency"
	//   --> Allowed 50% transparent render
	if(xPixel>369 && xPixel<470 && yPixel>130 && yPixel<198)
	begin
		VGAr = (8'b01000000 + VGAr) / 2;
		VGAg = (8'b01000000 + VGAg) / 2;
		VGAb = (8'b01000000 + VGAb) / 2;
	end

	//Drawing Solid shape "Low transparency"
	//   --> Allowed 50% transparent render
	if(xPixel>369 && xPixel<470 && yPixel>25 && yPixel<93)
	begin
		VGAr = (8'b01010100 + VGAr) / 2;
		VGAg = (8'b10000010 + VGAg) / 2;
		VGAb = (8'b00110101 + VGAb) / 2;
	end

	//Drawing Solid shape "Left bar"
	if(xPixel>0 && xPixel<278 && yPixel>0 && yPixel<206)
	begin
		VGAr = 8'b01000100;
		VGAg = 8'b01110010;
		VGAb = 8'b11000100;
	end

	//Drawing the mouse
	if(xPixel>mouseX && xPixel<(mouseX+20) && yPixel>mouseY && yPixel<(mouseY+20))
	begin
		VGAr = 8'b11111111;
		VGAg = 8'b11111111;
		VGAb = 8'b11111111;
	end

end

endmodule
