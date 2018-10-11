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

	//Writing backgound color
	VGAr = 8'b11111111;
	VGAg = 8'b11111111; 
	VGAb = 8'b11111111; 

	//Drawing Solid shape "Left bar"
	if(xPixel>0 && xPixel<53 && yPixel>0 && yPixel<480)
	begin
		VGAr = 8'b01000100;
		VGAg = 8'b01110010;
		VGAb = 8'b11000100;
	end

	//Drawing Solid shape "Bottom properties"
	if(xPixel>53 && xPixel<639 && yPixel>413 && yPixel<479)
	begin
		VGAr = 8'b10101111;
		VGAg = 8'b10101011;
		VGAb = 8'b10101011;
		if(xPixel<54 || xPixel>638 || yPixel<414 || yPixel>478)    //Drawing border
		begin
			VGAr = 8'b00101111;
			VGAg = 8'b01010010;
			VGAb = 8'b10001111;
		end
	end

	//Drawing Solid shape "Random Orange box"
	if(xPixel>439 && xPixel<604 && yPixel>41 && yPixel<307)
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
	if(xPixel>130 && xPixel<550 && yPixel>227 && yPixel<295)
	begin
		VGAr = 8'b01010100;
		VGAg = 8'b10000010;
		VGAb = 8'b00110101;
	end

	//Drawing Solid shape "High transparency"
	//   --> Allowed advanced transparent render
	if(xPixel>369 && xPixel<470 && yPixel>130 && yPixel<198)
	begin
		VGAr = (8'b00011001 + ((30 * VGAr) / 100);
		VGAg = (8'b00100111 + ((30 * VGAg) / 100);
		VGAb = (8'b00010000 + ((30 * VGAb) / 100);
	end

	//Drawing Solid shape "Low transparency"
	//   --> Allowed advanced transparent render
	if(xPixel>369 && xPixel<470 && yPixel>25 && yPixel<93)
	begin
		VGAr = (8'b00111110 + ((74 * VGAr) / 100);
		VGAg = (8'b01100001 + ((74 * VGAg) / 100);
		VGAb = (8'b00100111 + ((74 * VGAb) / 100);
	end

end

endmodule
