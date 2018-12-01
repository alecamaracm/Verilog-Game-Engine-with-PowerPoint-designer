module main(hsync,vsync,VGAclock,VGAr,VGAg,VGAb,VGAsync,VGAblanck,CLOCK,sw,leds,key,ps2ck,ps2dt,ps2ck2,ps2dt2,RX,TX,GPIO0,GPIO1,GPIO2,GPIO3);

output [7:0]VGAr;
output [7:0]VGAg;
output [7:0]VGAb;
output VGAsync,VGAblanck;

input RX;
output GPIO0;
output GPIO2;
input GPIO3;
input GPIO1;
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

wire [9:0]peterX;
wire [9:0]peterY;


output TX;

assign TX=RX;

wire animationClOCK;

output VGAclock;
output hsync,vsync;

wire [7:0]UARTdata;
wire UARTavail;
wire u1;


VGADriver driver(CLOCK,hsync,vsync,VGAclock,VGAblanck,VGAsync,xPixel,yPixel,animationClOCK);


PP2VerilogDrawingController drawings(CLOCK,key[2],animationClOCK,wasd,arrows,xPixel,yPixel,VGAr,VGAg,VGAb,mouseX,mouseY,peterX,peterY); //This file is generated automatically by the compiler. Please DO NOT modify it.

ps2Keyboard keyboard(CLOCK,ps2ck2,ps2dt2,wasd,arrows,leds[4],leds[5]);//
ps2Mouse mouse(CLOCK,ps2ck,ps2dt,leds[0],leds[1],!key[0],mouseX,mouseY);//

wire [9:0]uLot;

buzzing buz(CLOCK,GPIO0,GPIO2,GPIO3,uLot);

enjoy joy(CLOCK,peterX,peterY,GPIO1,key[1],leds[17:10]);

endmodule





module enjoy(CLOCK,peterX,peterY,RX,reset,leds);

	output [9:0]peterX;
	reg [9:0]peterX;
	output [9:0]peterY;
	input CLOCK;
	reg [9:0]peterY;
	input RX;
		input reset;
		
		output [7:0]leds;
		reg [7:0]leds;
	
	
	reg [4:0]count;
	wire dataAvail,u3;
	wire [7:0]data;
	
	wire [7:0]dataSend;
	
	reg lastdataAvail;
	wire RXerror,RXvalid;
	
	wire TX;
	//UARTtest uart(CLOCK,reset,RX,TX,dataAvail,data,RXerror,RXvalid,8'd0,1'd0,8'd0,u3);	
	//UART2 uart(CLOCK,RX,reset,data,dataAvail,8'd0,1'b0);
	
	
	UART2 uart(CLOCK,RX,reset,data,dataAvail,dataSend,1'b0);
	
	reg [59:0]timeout;
	
	//assign leds=data;
	always @(posedge CLOCK)
	begin
		
		if(timeout>=60'd100000)
		begin
			timeout=60'd0;
			count=0;
		end
		else
		begin
			timeout=timeout+60'd1;
		end
		
		if(dataAvail!=lastdataAvail)
		begin
			timeout=60'd0;
			
			
			case (count)
		
			5'd0:
			begin
				
				
				if(((data*480)/256)-78<0)
				begin
					peterY=0;
				
				end
				else
				begin
					peterY=((data*480)/256)-78;
				end
				
				//peterY=data;
				//leds=data;
				
				//peterY=peterY+100;
				count=1;
			end
			5'd1:
			begin
			
				if(((data*640)/256)-78<0)
				begin
					peterX=0;
				
				end
				else
				begin
					peterX=((data*640)/256)-78;
				end
				
				count=2;
			end
			5'd2:
			begin
			
				count=0;
			end			
			
			endcase
			
			leds=data;
		
			lastdataAvail=dataAvail;
		
		end	
		
		
		
	end			
	
	

endmodule