module VGADriver(real100clock,hsync,vsync,VGAclock,VGAblanck,VGAsync,xPixel,yPixel);


input real100clock;
output VGAsync;
output VGAblanck;
output VGAclock;

reg [10:0]xPos;
reg [10:0]yPos;

output [9:0]xPixel;
assign xPixel=xPos-161;
output [8:0]yPixel;
assign yPixel=yPos;

output hsync,vsync;


reg downClock;

reg [28:0] scaler;

//Timings from https://timetoexplore.net/blog/video-timings-vga-720p-1080p
 localparam hSyncS = 16;              // hSync start
 localparam hSyncE = 16 + 96;         // hSync end
 localparam vSyncS = 480 + 11;        // vSync start
 localparam vSyncE = 480 + 11 + 2;    // vSync end
 localparam width   = 800;             
 localparam height = 524;             
 
 assign VGAsync=1'b0;
 
 
assign hsync = !((xPos >= hSyncS) & (xPos < hSyncE));
assign vsync = !((yPos >= vSyncS) & (yPos < vSyncE));
assign VGAblanck = ((xPos>12'd158)) ? 1'b1 : 1'b0;
 
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