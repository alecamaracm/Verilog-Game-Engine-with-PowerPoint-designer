module animations1(CLOCK,xPixel,yPixel,wasd,arrows,Basic_transparencyX,Basic_transparencyY,wasdBlockX,wasdBlockY,ArrowsBlockX,ArrowsBlockY);
	
input CLOCK;

input [3:0]wasd;
input [3:0]arrows;
input [10:0]xPixel;
input [10:0]yPixel;

output [9:0]Basic_transparencyX;
output [9:0]Basic_transparencyY;
reg [9:0]Basic_transparencyX;
reg [9:0]Basic_transparencyY;

output [9:0]wasdBlockX;
output [9:0]wasdBlockY;
reg [9:0]wasdBlockX;
reg [9:0]wasdBlockY;

output [9:0]ArrowsBlockX;
output [9:0]ArrowsBlockY;
reg [9:0]ArrowsBlockX;
reg [9:0]ArrowsBlockY;

parameter testWidth=388;
parameter testHeight=68;

parameter wasdWidth=155;
parameter wasdHeight=82;

parameter arrowsWidth=155;
parameter arrowsHeight=82;

parameter testSpeed=10'd1;
parameter wasdSpeed=10'd5;
parameter arrowsSpeed=10'd5;


reg testXDir;
reg testYDir;

	always @ (negedge CLOCK)
	begin
		
		if(testXDir==1)
		begin
			if(Basic_transparencyX>=640-testWidth) 
			begin
				testXDir=0;
			end
			else
			begin
				Basic_transparencyX<=Basic_transparencyX+testSpeed;
			end		
		end
		else
		begin
			if(Basic_transparencyX<=0) 
			begin
				testXDir=1;
			end
			else
			begin
				Basic_transparencyX<=Basic_transparencyX-testSpeed;
			end
		end
		
		
		
		
		if(testYDir==1)
		begin
			if(Basic_transparencyY>=480-testHeight) 
			begin
				testYDir=0;
			end
			else
			begin
				Basic_transparencyY<=Basic_transparencyY+10'd1;
			end		
		end
		else
		begin
			if(Basic_transparencyY<=0) 
			begin
				testYDir=1;
			end
			else
			begin
				Basic_transparencyY<=Basic_transparencyY-10'd1;
			end
		end
		
		if(wasd[0]==1 && wasdBlockY>0) wasdBlockY=wasdBlockY-wasdSpeed;		
		if(wasd[1]==1 && wasdBlockX>0) wasdBlockX=wasdBlockX-wasdSpeed;		
		if(wasd[2]==1 && wasdBlockY<480-wasdHeight) wasdBlockY=wasdBlockY+wasdSpeed;		
		if(wasd[3]==1 && wasdBlockX<640-wasdWidth) wasdBlockX=wasdBlockX+wasdSpeed;

		if(arrows[0]==1 && ArrowsBlockY>0) ArrowsBlockY=ArrowsBlockY-arrowsSpeed;		
		if(arrows[1]==1 && ArrowsBlockX>0) ArrowsBlockX=ArrowsBlockX-arrowsSpeed;		
		if(arrows[2]==1 && ArrowsBlockY<480-arrowsHeight) ArrowsBlockY=ArrowsBlockY+arrowsSpeed;		
		if(arrows[3]==1 && ArrowsBlockX<640-arrowsWidth) ArrowsBlockX=ArrowsBlockX+arrowsSpeed;
		 
	end

endmodule