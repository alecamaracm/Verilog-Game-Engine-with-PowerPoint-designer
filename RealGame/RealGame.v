module RealGame(hsync,vsync,VGAclock,VGAr,VGAg,VGAb,VGAsync,VGAblanck,CLOCK,sw,leds,key,ps2ck,ps2dt,ps2ck2,ps2dt2,RX,TX,GPIO0,GPIO1,GPIO2,GPIO3,GPIO12,GPIO13);


output [7:0]VGAr;
output [7:0]VGAg;
output [7:0]VGAb;
output VGAsync,VGAblanck;

input RX;
output GPIO0;
input GPIO1;
output GPIO2;
input GPIO3;
input GPIO13;
output GPIO12;
output [17:0]leds;
input [17:0]sw;	
input [3:0]key;
inout ps2ck,ps2dt,ps2ck2,ps2dt2;
input CLOCK;

wire [9:0]xPixel;
wire [8:0]yPixel;

wire [10:0]mouseX;
wire [10:0]mouseY;

wire [3:0]wasd;
wire [3:0]arrows;


output TX;

assign TX=RX;

wire animationClOCK;

output VGAclock;
output hsync,vsync;

wire [7:0]rrr;
wire u1;

wire [9:0]BACK2X;
wire [9:0]BACK2Y;
wire [9:0]BACK1X;
wire [9:0]BACK1Y;
wire [9:0]PIPEDOWN1X;
wire [9:0]PIPEDOWN1Y;
wire [9:0]PIPEDOWN2X;
wire [9:0]PIPEDOWN2Y;
wire [9:0]PIPEDOWN3X;
wire [9:0]PIPEDOWN3Y;
wire [9:0]pointY;
wire [9:0]pointX;
wire [9:0]PIPEUP1X;
wire [9:0]PIPEUP1Y;
wire [9:0]PIPEUP2X;
wire [9:0]PIPEUP2Y;
wire [9:0]PIPEUP3X;
wire [9:0]PIPEUP3Y;
wire PIPEDOWN1VISIBLE;
wire PIPEDOWN2VISIBLE;
wire PIPEDOWN3VISIBLE;
wire [9:0]PIPEUP1SKIPY;
wire PIPEUP1VISIBLE;
wire [9:0]PIPEUP2SKIPY;
wire PIPEUP2VISIBLE;
wire [9:0]PIPEUP3SKIPY;
wire PIPEUP3VISIBLE;
wire [9:0]cloud1X;
wire [9:0]cloud1Y;
wire [9:0]cloud2X;
wire [9:0]cloud2Y;
wire [9:0]cloud3X;
wire [9:0]cloud3Y;
wire [9:0]BACK2SKIPX;
wire [9:0]BACK1SKIPX;
wire [9:0]birdX;
wire [9:0]birdY;
reg [9:0]birdYt;
reg [9:0]cloud1sp;

assign pointX=550;
assign cloud1X=180;
assign cloud1Y=70;
assign cloud2X=290;
assign cloud2Y=90;
assign cloud3X=435;
assign cloud3Y=60;

assign birdX=100;
assign birdY=500-birdYt;

wire endOfMapPipe;

wire [19:0]distanceOut;


wire mouse1;
wire mouse2;

reg [9:0]score;

wire birdRun;
assign birdRun=!key[2];
assign leds[6]=coltuberias;

reg [9:0]birdsp;

wire coltuberias;


UART2 uart(CLOCK,RX,key[1],rrr,u1,8'd0,1'b0);
 
VGADriver driver(CLOCK,hsync,vsync,VGAclock,VGAblanck,VGAsync,xPixel,yPixel,animationClOCK);


PP2VerilogDrawingController drawings(CLOCK,reset,animationCLOCK,wasd,arrows,xPixel,yPixel,VGAr,VGAg,VGAb,mouseX,mouseY,BACK2X,BACK2Y,BACK1X,BACK1Y,PIPEDOWN1X,PIPEDOWN1Y,PIPEDOWN2X,PIPEDOWN2Y,PIPEDOWN3X,PIPEDOWN3Y,pointX,pointY,PIPEUP1X,PIPEUP1Y,PIPEUP2X,PIPEUP2Y,PIPEUP3X,PIPEUP3Y,birdX,birdY,coltuberias,PIPEDOWN1VISIBLE,PIPEDOWN2VISIBLE,PIPEDOWN3VISIBLE,PIPEUP1SKIPY,PIPEUP1VISIBLE,PIPEUP2SKIPY,PIPEUP2VISIBLE,PIPEUP3SKIPY,PIPEUP3VISIBLE,cloud1sp,birdsp,BACK2SKIPX,BACK1SKIPX,);

ps2Keyboard keyboard(CLOCK,ps2ck2,ps2dt2,wasd,arrows,leds[4],leds[5]);//
ps2Mouse mouse(CLOCK,ps2ck,ps2dt,mouse1,mouse2,!key[0],mouseX,mouseY);//;

placerUpDown placer(CLOCK,pointY,GPIO1,key[3]);

backAnimations backAnim(animationClOCK,BACK1X,BACK1Y,BACK2X,BACK2Y,score,BACK1SKIPX,BACK2SKIPX);

pipeAnimations anim(animationClOCK,PIPEDOWN1X,PIPEDOWN1Y,PIPEDOWN2X,PIPEDOWN2Y,PIPEDOWN3X,PIPEDOWN3Y,pointY,PIPEUP1X,PIPEUP1Y,PIPEUP2X,PIPEUP2Y,PIPEUP3X,PIPEUP3Y,PIPEDOWN1VISIBLE,PIPEDOWN2VISIBLE,PIPEDOWN3VISIBLE,PIPEUP1SKIPY,PIPEUP1VISIBLE,PIPEUP2SKIPY,PIPEUP2VISIBLE,PIPEUP3SKIPY,PIPEUP3VISIBLE,score,mouse1,mouse2,leds[12:9],endOfMapPipe);

always @(posedge endOfMapPipe)
begin		
	cloud1sp=cloud1sp+1;
	if(cloud1sp>2)cloud1sp=0;
	
	if(key[0]==0)
	begin
		score=0;	
	end
	else
	begin
		score=score+1;
	end
end

reg [9:0]birdCount;

always @(posedge animationClOCK)
begin

	if(birdCount>2)
	begin
		birdCount=0;
		birdsp=birdsp+1;
	
		if(birdRun==0)
		begin
			if(birdsp>11) birdsp=3;	
		end
		else
		begin
			if(birdsp>2) birdsp=0;	
		end
	end
	else
	begin
		birdCount=birdCount+1;
	end
end

reg [19:0]finalGoal;

always @(posedge animationClOCK)
begin

	if(distanceOut<80)
	begin
		finalGoal=80;
	end
	else if(distanceOut>480)
	begin
		finalGoal=480;
	end
	else
	begin
		finalGoal=distanceOut;
	end
	
	
	if(finalGoal>birdYt)
	begin
		birdYt=birdYt+13;
		if(finalGoal<birdYt) birdYt=finalGoal;
	end
	else
	begin
		birdYt=birdYt-13;
		if(finalGoal>birdYt) birdYt=finalGoal;
	end
	
	

	
end

buzzing buzz(CLOCK,GPIO0,score*50);

distance dd(CLOCK,GPIO12,GPIO13,distanceOut);
	
endmodule