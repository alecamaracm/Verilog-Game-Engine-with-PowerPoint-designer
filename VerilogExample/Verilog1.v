module animations1(CLOCK,wasd,arrows,Basic_transparencyX,Basic_transparencyY);
	
input CLOCK;

input [3:0]wasd;
input [3:0]arrows;

output [9:0]Basic_transparencyX;
output [9:0]Basic_transparencyY;
reg [9:0]Basic_transparencyX;
reg [9:0]Basic_transparencyY;


parameter testWidth=388;
parameter testHeight=68;


parameter testSpeed=10'd1;



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
	

		 
	end

endmodule