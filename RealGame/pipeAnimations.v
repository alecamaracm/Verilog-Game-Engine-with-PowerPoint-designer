module pipeAnimations(animationCLOCK,PIPEDOWN1X,PIPEDOWN1Y,PIPEDOWN2X,PIPEDOWN2Y,PIPEDOWN3X,PIPEDOWN3Y,pointY,PIPEUP1X,PIPEUP1Y,PIPEUP2X,PIPEUP2Y,PIPEUP3X,PIPEUP3Y,
	PIPEDOWN1VISIBLE,PIPEDOWN2VISIBLE,PIPEDOWN3VISIBLE,PIPEUP1SKIPY,PIPEUP1VISIBLE,PIPEUP2SKIPY,PIPEUP2VISIBLE,PIPEUP3SKIPY,PIPEUP3VISIBLE,score
	mouse1,mouse2);

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

input mouse1,mouse2;

input score;

localparam [9:0]scoreToPipeSpeed=1;
localparam [9:0]pipeSpeedMultiplier=10;

localparam [9:0]doublePipeMinScore=10;

localparam [9:0]basePipeSpace=350;
localparam [9:0]minPipeSpace=100;
localparam [9:0]spaceReductionPerScore=50;

localparam [9:0]pipeUpImageSize=402;

reg pipe1En,pipe2En,pipe3En;

wire [9:0]pipeSpace;

wire [9:0]currentTempSpace;
assign currentTempSpace = basePipeSpace-((doublePipeMinScore-score)*spaceReductionPerScore);
assign pipeSpace=(score < doublePipeMinScore) ? 0 : ((minPipeSpace>currentTempSpace)?minPipeSpace:currentTempSpace);

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
		if(real1posX<((score/scoreToPipeSpeed)*pipeSpeedMultiplier)) //Pipe 1 has reached the end. Disable it.
		begin
			pipe1En=0;
			real1posX=0;
		end
		else
		begin
			real1posX=real1posX-((score/scoreToPipeSpeed)*pipeSpeedMultiplier);
		end
	end
	
end


assign PIPEDOWN1X=real1posX/100;
assign PIPEUP1X=real1posX/100;
assign PIPEDOWN2X=real2posX/100;
assign PIPEUP2X=real2posX/100;
assign PIPEDOWN3X=real3posX/100;
assign PIPEUP3X=real3posX/100;

assign PIPEDOWN1Y=real1posY+(pipeSpace/2);
assign PIPEDOWN2Y=real2posY+(pipeSpace/2);
assign PIPEDOWN3Y=real3posY+(pipeSpace/2);

assign PIPEUP1Y=0;
assign PIPEUP2Y=0;
assign PIPEUP3Y=0;
assign PIPEUP1SKIPY=pipeUpImageSize-(real1posY-(pipeSpace/2));
assign PIPEUP2SKIPY=pipeUpImageSize-(real2posY-(pipeSpace/2));
assign PIPEUP3SKIPY=pipeUpImageSize-(real3posY-(pipeSpace/2));

assign PIPEDOWN1VISIBLE= (score>=doublePipeMinScore) ? (pipe1En) :(pipe1En && real1posX>240);
assign PIPEDOWN2VISIBLE= (score>=doublePipeMinScore) ? (pipe2En) :(pipe2En && real2posX>240);
assign PIPEDOWN3VISIBLE= (score>=doublePipeMinScore) ? (pipe3En) :(pipe3En && real3posX>240);
assign PIPEUP1VISIBLE= (score>=doublePipeMinScore) ? (pipe1En) :(pipe1En && real1posX<=240);
assign PIPEUP2VISIBLE= (score>=doublePipeMinScore) ? (pipe2En) :(pipe2En && real2posX<=240);
assign PIPEUP3VISIBLE= (score>=doublePipeMinScore) ? (pipe3En) :(pipe3En && real3posX<=240);

endmodule