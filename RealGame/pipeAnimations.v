module pipeAnimations(animationCLOCK,PIPEDOWN1X,PIPEDOWN1Y,PIPEDOWN2X,PIPEDOWN2Y,PIPEDOWN3X,PIPEDOWN3Y,pointY,PIPEUP1X,PIPEUP1Y,PIPEUP2X,PIPEUP2Y,PIPEUP3X,PIPEUP3Y,
	PIPEDOWN1VISIBLE,PIPEDOWN2VISIBLE,PIPEDOWN3VISIBLE,PIPEUP1SKIPY,PIPEUP1VISIBLE,PIPEUP2SKIPY,PIPEUP2VISIBLE,PIPEUP3SKIPY,PIPEUP3VISIBLE,score,
	mouse1,mouse2,leds);

input animationCLOCK;
output [9:0]PIPEDOWN1X;
output [9:0]PIPEDOWN1Y;
output [9:0]PIPEDOWN2X;
output [9:0]PIPEDOWN2Y;
output [9:0]PIPEDOWN3X;
output [9:0]PIPEDOWN3Y;
input [9:0]pointY;
output [9:0]PIPEUP1X;
output [9:0]PIPEUP1Y;
output [9:0]PIPEUP2X;
output [9:0]PIPEUP2Y;
output [9:0]PIPEUP3X;
output [9:0]PIPEUP3Y;
output PIPEDOWN1VISIBLE;
output PIPEDOWN2VISIBLE;
output PIPEDOWN3VISIBLE;
output [9:0]PIPEUP1SKIPY;
output PIPEUP1VISIBLE;
output [9:0]PIPEUP2SKIPY;
output PIPEUP2VISIBLE;
output [9:0]PIPEUP3SKIPY;
output PIPEUP3VISIBLE;

output [3:0]leds;
input mouse1,mouse2;

input [9:0]score;
reg [9:0]score1;
reg [9:0]score2;
reg [9:0]score3;

localparam [9:0]scoreToPipeSpeed=50;
localparam [9:0]pipeSpeedMultiplier=1;
localparam [9:0]doublePipeMinScore=10;
localparam [9:0]basePipeSpace=200;
localparam [9:0]minPipeSpace=100;
localparam [9:0]spaceReductionPerScore=30;
localparam [9:0]pipeUpImageSize=402;
localparam [9:0]minSpeed=150;

reg pipe1En,pipe2En,pipe3En;

wire [9:0]pipeSpace1;
wire [9:0]currentTempSpace1;
wire useMin1;

assign useMin1=((score1-doublePipeMinScore)*spaceReductionPerScore>(basePipeSpace-minPipeSpace));
assign currentTempSpace1 = basePipeSpace-((score1-doublePipeMinScore)*spaceReductionPerScore);
assign pipeSpace1=(score1 < doublePipeMinScore) ? 0 : ((useMin1)?minPipeSpace:currentTempSpace1);

reg [19:0]real1posX;
reg [19:0]real2posX;
reg [19:0]real3posX;
reg [19:0]real1posY;
reg [19:0]real2posY;
reg [19:0]real3posY;

always @(posedge animationCLOCK)
begin

	if(pipe1En==1)
	begin
		if(real1posX<((((score1+1)*scoreToPipeSpeed)+minSpeed)*pipeSpeedMultiplier)) //Pipe 1 has reached the end. Disable it.
		begin
			pipe1En=0;
			real1posX=0;
		end
		else
		begin
			real1posX=real1posX-((((score1+1)*scoreToPipeSpeed)+minSpeed)*pipeSpeedMultiplier);
		end
	end
	else
	begin
		if(pipe1En==0)
		begin
			if(mouse1==1)
			begin
				pipe1En=1;
				real1posY=pointY;	
				real1posX=650*100;
				score1=score;
			end
		end
	end	
	
end


assign PIPEDOWN1X=real1posX/100;
assign PIPEUP1X=real1posX/100;
assign PIPEDOWN2X=real2posX/100;
assign PIPEUP2X=real2posX/100;
assign PIPEDOWN3X=real3posX/100;
assign PIPEUP3X=real3posX/100;

assign PIPEDOWN1Y=real1posY+(pipeSpace1/2);
assign PIPEDOWN2Y=real2posY+(pipeSpace1/2);
assign PIPEDOWN3Y=real3posY+(pipeSpace1/2);

assign PIPEUP1Y=0;
assign PIPEUP2Y=0;
assign PIPEUP3Y=0;
assign PIPEUP1SKIPY=pipeUpImageSize-(real1posY-(pipeSpace1/2));
assign PIPEUP2SKIPY=pipeUpImageSize-(real2posY-(pipeSpace1/2));
assign PIPEUP3SKIPY=pipeUpImageSize-(real3posY-(pipeSpace1/2));

assign PIPEDOWN1VISIBLE= (score1>=doublePipeMinScore) ? (pipe1En) :(pipe1En && real1posY>240);
assign PIPEDOWN2VISIBLE= (score1>=doublePipeMinScore) ? (pipe2En) :(pipe2En && real2posY>240);
assign PIPEDOWN3VISIBLE= (score1>=doublePipeMinScore) ? (pipe3En) :(pipe3En && real3posY>240);
assign PIPEUP1VISIBLE= (score1>=doublePipeMinScore) ? (pipe1En) :(pipe1En && real1posY<=240);
assign PIPEUP2VISIBLE= (score1>=doublePipeMinScore) ? (pipe2En) :(pipe2En && real2posY<=240);
assign PIPEUP3VISIBLE= (score1>=doublePipeMinScore) ? (pipe3En) :(pipe3En && real3posY<=240);

endmodule