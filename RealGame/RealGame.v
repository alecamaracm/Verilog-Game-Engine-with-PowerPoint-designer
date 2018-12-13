module RealGame(hsync,vsync,VGAclock,VGAr,VGAg,VGAb,VGAsync,VGAblanck,CLOCK,sw,leds,key,ps2ck,ps2dt,ps2ck2,ps2dt2,RX,TX,GPIO0,GPIO1,GPIO2,GPIO3,GPIO12,GPIO13,GPIO22,GPIO23,GPIO25,GPIO26,GPIO27,GPIO30,GPIO31,GPIO32,GPIO33,GPIO35);


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

assign leds[17]=GPIO35;

input GPIO22; //ECHO
output GPIO23; //TRIGGER
output GPIO25; //BUZZER
output GPIO26; //M1
output GPIO27; //M2
output GPIO30; //BTT light
input GPIO31; //BTT data
output GPIO32,GPIO33; //OUT data
reg GPIO32,GPIO33; //OUT data
input GPIO35;

//assign GPIO32=!key[3];
//assign GPIO33=!key[2];

assign GPIO26=!(windRem>0 && windDir==1);
assign GPIO27=!(windRem>0 && windDir==0);
assign GPIO30=!(!PIPEDOWN1VISIBLE && !PIPEUP1VISIBLE);
//assign GPIO25=0;

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
wire [9:0]pointY;
wire [9:0]pointX;
wire [9:0]PIPEUP1X;
wire [9:0]PIPEUP1Y;
wire PIPEDOWN1VISIBLE;
wire [9:0]PIPEUP1SKIPY;
wire PIPEUP1VISIBLE;
wire [9:0]cloud1X;
wire [9:0]cloud1Y;
wire [9:0]cloud2X;
wire [9:0]cloud2Y;
wire [9:0]BACK2SKIPX;
wire [9:0]BACK1SKIPX;
reg [9:0]birdX;
wire [9:0]birdY;
reg [9:0]birdYt;
reg [9:0]cloud1sp;
reg [9:0]cloud2sp;

assign pointX=550;
assign cloud1X=180;
assign cloud1Y=70;
assign cloud2X=290;
assign cloud2Y=90;

wire [9:0]fakeX;
wire [9:0]fakeY;

assign fakeX=birdX;
assign fakeY=birdY;

wire colpower;
assign leds[6]=colpower;

assign birdY=(started)?500-birdYt:200;

wire endOfMapPipe;

wire [19:0]distanceOut;

reg started=0;

wire mouse1;
wire mouse2;

reg [9:0]score;

wire birdRun;
assign birdRun=windRem>0;


reg [9:0]birdsp;

wire coltuberias;

reg go1VISIBLE,go2VISIBLE;
wire h1VISIBLE,h2VISIBLE,h3VISIBLE;
reg [9:0]LOSEBOXX;
wire [9:0]LOSEBOXY;
assign h1VISIBLE=lives>=1;
assign h2VISIBLE=lives>=2;
assign h3VISIBLE=lives>=3;
assign LOSEBOXY=80;




reg [5:0]lives;

initial begin
	lives=2;
	LOSEBOXX=700;
	go1VISIBLE=0;
	go2VISIBLE=0;
	birdX=100;
end

 
VGADriver driver(CLOCK,hsync,vsync,VGAclock,VGAblanck,VGAsync,xPixel,yPixel,animationClOCK);


PP2VerilogDrawingController drawings(CLOCK,reset,animationClOCK,wasd,arrows,xPixel,yPixel,VGAr,VGAg,VGAb,mouseX,mouseY,fakeX,fakeY,LOSEBOXX,LOSEBOXY,BACK2X,BACK2Y,BACK1X,BACK1Y,PIPEDOWN1X,PIPEDOWN1Y,pointX,pointY,PIPEUP1X,PIPEUP1Y,birdX,birdY,colpower,coltuberias,PIPEDOWN1VISIBLE,PIPEUP1SKIPY,PIPEUP1VISIBLE,cloud1sp,h1VISIBLE,h2VISIBLE,h3VISIBLE,cloud2sp,birdsp,go1VISIBLE,go2VISIBLE,BACK2SKIPX,BACK1SKIPX);

ps2Keyboard keyboard(CLOCK,ps2ck2,ps2dt2,wasd,arrows,leds[4],leds[5]);//
ps2Mouse mouse(CLOCK,ps2ck,ps2dt,mouse1,mouse2,!key[0],mouseX,mouseY);//;

placerUpDown placer(CLOCK,pointY,GPIO35,key[3]);

backAnimations backAnim(animationClOCK,BACK1X,BACK1Y,BACK2X,BACK2Y,score,BACK1SKIPX,BACK2SKIPX);

pipeAnimations anim(animationClOCK,PIPEDOWN1X,PIPEDOWN1Y,pointY,PIPEUP1X,PIPEUP1Y,PIPEDOWN1VISIBLE,PIPEUP1SKIPY,PIPEUP1VISIBLE,score,GPIO31 && !go1VISIBLE && !go2VISIBLE,mouse2,leds[12:9],endOfMapPipe);


always @(posedge endOfMapPipe)
begin		
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
reg justCollided;

reg [9:0]collTimeout;

always @(posedge animationClOCK)
begin

	if(endOfMapPipe==1)
	begin
		if(windRand>50 && windRand<100)
		begin
			cloud1sp=1;
			cloud2sp=1;	
		end

		if(windRand>100 && windRand<200)
		begin
			cloud1sp=2;
			cloud2sp=2;	
		end
		if(windRand>0 && windRand<50)
		begin
			cloud1sp=0;
			cloud2sp=0;	
		end	
	end
	
	if(GPIO31==1)started=1; //Start of the game
	
	if(colpower==1 && cloud1sp==2)
	begin
		cloud1sp=0;
		cloud2sp=0;
		lives=lives+1;
		if(lives>3)lives=3;
	end
	if(colpower==1 && cloud1sp==1)
	begin
		cloud1sp=0;
		cloud2sp=0;
		if(lives>0)
		begin
			lives=lives-1;
		end	
	end
	

	if((justCollided==0 && coltuberias==1 && collTimeout==0)||score>=37)
	begin		
		if(score>=37)
		begin
			go1VISIBLE=1;
			go2VISIBLE=0;
			LOSEBOXX=100;
		end
		else
		begin
			if(lives>0)
			begin
				lives=lives-1;
				collTimeout=60;
			end
			else
			begin
				go1VISIBLE=0;
				go2VISIBLE=1;
				LOSEBOXX=100;
			end
		end
		
		
	end
	
	if(collTimeout>0) collTimeout=collTimeout-1;
	
	justCollided=coltuberias;

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
		birdYt=birdYt+10;
		if(finalGoal<birdYt) birdYt=finalGoal;
	end
	else
	begin
		birdYt=birdYt-10;
		if(finalGoal>birdYt) birdYt=finalGoal;
	end
	
end

reg [9:0]buzzTime;
reg [9:0]lastScore;
reg [9:0]lastScore2;
reg [9:0]buzzFreq;

reg [14:0]windRem;
reg windDir;

always @(posedge animationClOCK)
begin

	

	if(buzzTime>0) buzzTime=buzzTime-1;
	
	if(buzzTime==0)
	begin
		
		if(lastScore!=score && (PIPEDOWN1VISIBLE || PIPEUP1VISIBLE))
		begin
			lastScore=score;
			buzzFreq=1000;
			buzzTime=7;
			
			if(score==0)
			begin
				GPIO32=1;
			end
			else
			begin
				GPIO32=0;
			end		
			
			GPIO33=0;
			
			if(windRand>100)
			begin
				windRem=(windRand/4)+15;
				windDir=(windRand+score)%2;
			end
		end
		
		if(lastScore2!=score)
		begin
			lastScore2=score;
			buzzFreq=6500;
			buzzTime=5;
		
			GPIO33=1;
		end
		
		if(coltuberias)
		begin
			buzzFreq=500;
			buzzTime=60;
		end
	end
	
	if(windRem>0) windRem=windRem-1;
	
	if(windRem>0)
	begin
		
		if(windDir==1)
		begin
			if(birdX<400) birdX=birdX+1;
		end
		else
		begin
			if(birdX>100) birdX=birdX-2;
		end
	
	end
	

	
end



reg [7:0]windRand;

always @(posedge CLOCK)
begin
	windRand=windRand+1;
	if(windRand>=250)windRand=0;
end

initial begin
	
	lastScore=1;	

end

buzzing buzz(CLOCK,GPIO25,buzzFreq,buzzTime>0 && sw[0]);

distance dd(CLOCK,GPIO23,GPIO22,distanceOut);
	
endmodule