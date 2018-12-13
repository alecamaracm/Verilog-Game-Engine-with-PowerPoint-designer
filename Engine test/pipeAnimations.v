module pipeAnimations(animationCLOCK,PIPEDOWN1X,PIPEDOWN1Y,pointY,PIPEUP1X,PIPEUP1Y,PIPEDOWN1VISIBLE,PIPEUP1SKIPY,PIPEUP1VISIBLE,score,mouse1,mouse2,leds,endOfMapPipe);

input animationCLOCK;
output [9:0]PIPEDOWN1X;
output [9:0]PIPEDOWN1Y;
input [9:0]pointY;
output [9:0]PIPEUP1X;
output [9:0]PIPEUP1Y;
output PIPEDOWN1VISIBLE;
output [9:0]PIPEUP1SKIPY;
output PIPEUP1VISIBLE;

output endOfMapPipe;
reg endOfMapPipe;

output [3:0]leds;
input mouse1,mouse2;

input [9:0]score;
reg [9:0]score1;
reg [9:0]score2;
reg [9:0]score3;

localparam [9:0]scoreToPipeSpeed=25;
localparam [9:0]pipeSpeedMultiplier=1;
localparam [9:0]doublePipeMinScore=10;
localparam [9:0]basePipeSpace=175;
localparam [9:0]minPipeSpace=150;
localparam [9:0]spaceReductionPerScore=20;
localparam [9:0]pipeUpImageSize=402;
localparam [9:0]minSpeed=280;

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

	if(endOfMapPipe==1) endOfMapPipe=0;

	if(pipe1En==1)
	begin
		if(real1posX<((((score1+1)*scoreToPipeSpeed)+minSpeed)*pipeSpeedMultiplier)) //Pipe 1 has reached the end. Disable it.
		begin
			pipe1En=0;
			real1posX=0;
			endOfMapPipe=1;
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

assign PIPEDOWN1Y=real1posY+(pipeSpace1/2);

assign PIPEUP1Y=0;
assign PIPEUP1SKIPY=pipeUpImageSize-(real1posY-(pipeSpace1/2));

assign PIPEDOWN1VISIBLE= (score1>=doublePipeMinScore) ? (pipe1En) :(pipe1En && real1posY<240);
assign PIPEUP1VISIBLE= (score1>=doublePipeMinScore) ? (pipe1En) :(pipe1En && real1posY>=240);


endmodule