/////////////////////////////////////////////////////////////////////////////////////
//																											  //
//			Mouse driver. 																				  //
//			M1 and M2 and the left and right mouse clicks.									  //
//			mouseX and mouseY and the x and y coordinates.									  //
//			Please assign all the inputs and outputs before asking for HELP.          //
//			You can have a look at the pin assignments in our example project.        //
//			If you want to display the mouse in our VGA driver, you should use the    //					
//			PowerPoint2Verilog complier to design your UI. (Add the tag CURSOR to the //
//			picture you want to use as a mouse                                        //
//---------------------------------------------------------------------------------//
//			Don't ever bother asking for help. (We are VERYY mean) (Just kidding)     //
//			You can mail us if you have any questions (cabrera@miamioh.edu) 			  //
//			or ask as in a lab				 														  //			
//																											  //
/////////////////////////////////////////////////////////////////////////////////////


module ps2Mouse(CLOCK,ps2ck,ps2dt,M1,M2,reset,mouseX,mouseY);

	input ps2ck,ps2dt;
	

	output M1;
	output M2;
	reg M1,M2;
	
	input CLOCK;	
	input reset;
	
	output [10:0]mouseX;
	output [10:0]mouseY;
	reg [10:0]mouseX;
	reg [10:0]mouseY;
	
	reg [3:0]position;	
	
	reg [1:0]byteCount;

	
	wire	[7:0]ps2_data;
	reg	[7:0]last_ps2_data;
	wire	ps2_newData;
	
	mouse_Inner_controller innerMouse (   //Don't touch anything in this declaration. It deals with the data adquisition and basic commands to the mouse.
	.CLOCK_50				(CLOCK),
	.reset				(reset),
	.PS2_CLK			(ps2ck),
 	.PS2_DAT			(ps2dt),
	.received_data		(ps2_data),
	.received_data_en	(ps2_newData)
	);	
	
	reg [7:0]Xspeed;
	reg [7:0]Yspeed;
	wire [7:0]invertedX;
	wire [7:0]invertedY;
	
	reg Xdir;
	reg Ydir;
	
	twoComp compX(Xspeed,invertedX);	
	twoComp compY(Yspeed,invertedY);
	
	localparam mousePrecision=2; //A multiplier for the mouse sensitivity.
	
	reg [55:0]nonActivity; //On a timeout, the data bytes reset.
	
	always @(posedge CLOCK)
	begin
	
			nonActivity=nonActivity+1;
			if(nonActivity>56'd150000)
			begin
				byteCount=2'b0;
				nonActivity=56'd0;
			end
			
			if(ps2_data!=last_ps2_data)
			begin			
				nonActivity=56'd0;
				
				case (byteCount)
					4'd0: //First data byte
					begin												
						M1=ps2_data[0];
						M2=ps2_data[1];
						
						byteCount=byteCount+1;						
						
						Xdir=ps2_data[4];
						Ydir=ps2_data[5];
					end
					4'd1: //Second data byte (X-speed)
					begin														
						byteCount=byteCount+1;
						Xspeed=ps2_data;						
						
						if(Xdir==0 && Xspeed[7]==0)
						begin
							if((10'd640-(Xspeed*mousePrecision)<mouseX))  //Its is going to be on the whiteboard
							begin
								mouseX=10'd640;
							end
							else
							begin
								mouseX=mouseX+(Xspeed*mousePrecision);
							end								
						end
						else						
						begin
							if(invertedX<8'b00111111)
							begin								
								if((invertedX*mousePrecision)>mouseX)  //Its is going to be negative
								begin
									mouseX=0;
								end
								else
								begin
									mouseX=mouseX-(invertedX*mousePrecision);													
								end							
							end	
						end
					end
					4'd2:  //Thrid data byte (Y-speed)
					begin						
						byteCount=byteCount+1;
						Yspeed=ps2_data;						
						if(Ydir==0 && Yspeed[7]==0)
						begin
							if((Yspeed*mousePrecision)>mouseY)  //Its is going to be negative
							begin
								mouseY=0;
							end
							else
							begin
								mouseY=mouseY-(Yspeed*mousePrecision);													
							end	
						
						
														
						end
						else						
						begin
							if(invertedY<8'b00111111)
							begin								
								if((10'd480-(invertedY*mousePrecision)<mouseY))  //Its is going to be on the PC
								begin
									mouseY=10'd480;
								end
								else
								begin
									mouseY=mouseY+(invertedY*mousePrecision);
								end								
							end	
						end
					end
						
					
				endcase
				
				last_ps2_data=ps2_data;
				
				
				

		
			end
			

		
	end
	
	
endmodule

module twoComp(in,out);

input [7:0]in;
wire [7:0]semiOUT;
output [7:0]out;

assign semiOUT=~in;

bit8Adder(semiOUT,8'd1,out);

endmodule


module fullAdder(i1,i2,cin,o,cout);

input i1;
input i2;
input cin;

wire o;
output o;
output cout;

assign cout= (i1&&i2)||(i1&&cin)||(i2&&cin);
assign o=i1^i2^cin;



endmodule



module bit8Adder(in1,in2,out);

input [7:0]in1;
input [7:0]in2;

output [7:0]out;

wire c12,c23,c34,c45,c56,c67,c78;
wire useless;
//assign out=5'b11111;
fullAdder bit1(in1[0],in2[0],1'b0,out[0],c12);
fullAdder bit2(in1[1],in2[1],c12,out[1],c23);
fullAdder bit3(in1[2],in2[2],c23,out[2],c34);
fullAdder bit4(in1[3],in2[3],c34,out[3],c45);
fullAdder bit5(in1[4],in2[4],c45,out[4],c56);
fullAdder bit6(in1[5],in2[5],c56,out[5],c67);
fullAdder bit7(in1[6],in2[6],c67,out[6],c78);
fullAdder bit8(in1[7],in2[7],c78,out[7],useless);

endmodule