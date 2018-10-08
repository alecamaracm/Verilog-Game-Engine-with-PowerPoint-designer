module VGADriver(real100clock,out,hsync,vsync,VGAclock,VGAblanck);

input real100clock;
output VGAblanck;
output out;
output VGAclock;
reg out;

reg [10:0]xPos;
reg [10:0]yPos;

output hsync,vsync;


reg downClock;

reg [28:0] scaler;

localparam desiredHz=25000000;

//Timings https://timetoexplore.net/blog/video-timings-vga-720p-1080p
 localparam HS_STA = 16;              // horizontal sync start
 localparam HS_END = 16 + 96;         // horizontal sync end
 localparam HA_STA = 16 + 96 + 48;    // horizontal active pixel start
 localparam VS_STA = 480 + 11;        // vertical sync start
 localparam VS_END = 480 + 11 + 2;    // vertical sync end
 localparam VA_END = 480;             // vertical active pixel end
 localparam width   = 800;             // complete line (pixels)
 localparam height = 524;             // complete screen (lines)
 
 
assign hsync = !((xPos >= HS_STA) & (xPos < HS_END));
assign vsync = !((yPos >= VS_STA) & (yPos < VS_END));
assign VGAblanck = ((xPos>12'd160)) ? 1'b1 : 1'b0;
 
assign VGAclock=downClock; 

always @ (posedge real100clock)
begin
				downClock<=!downClock;
end




always @ (posedge downClock)
begin
	if(xPos==width)
	begin
		xPos<=0;
		yPos<=yPos+1;
	end
	else
	begin
		xPos<=xPos+1;
	end
	
	if(yPos==height)
	begin
		yPos<=0;
		xPos<=0;
	end
end



endmodule