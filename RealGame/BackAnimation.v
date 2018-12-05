module backAnimations(animationClOCK,BACK1X,BACK1Y,BACK2X,BACK2Y,score,BACK1SKIPX,BACK2SKIPX);

input animationClOCK;
output [9:0]BACK1X;
output [9:0]BACK1Y;
output [9:0]BACK2X;
output [9:0]BACK2Y;
output [9:0]BACK1SKIPX;
output [9:0]BACK2SKIPX;
input [9:0]score;

localparam [9:0]minScrollSpeed=100;
localparam [9:0]scrollPerScore=30;

reg [19:0]realx;

always @(posedge animationClOCK)
begin
	if(realx<(minScrollSpeed+(scrollPerScore*score)))
	begin
		realx=640*100;
	end
	else
	begin
		realx=realx-(minScrollSpeed+(scrollPerScore*score));
	end

end

assign BACK1X=realx/100;
assign BACK1Y=0;
assign BACK2X=0;
assign BACK2Y=0;
assign BACK1SKIPX=0;
assign BACK2SKIPX=(640-(realx/100));



endmodule