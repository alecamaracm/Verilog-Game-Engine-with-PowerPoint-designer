module ps2Keyboard(CLOCK,ps2ck,ps2dt,wasd,space,enter,test,butt,test2,test3);

	inout ps2ck,ps2dt;
	reg ps2ck,ps2dt;
	
	reg test,test2,test3;
	input butt;
	output test,test2,test3;
	
	output [3:0]wasd,space,enter;
	reg [3:0]wasd,space,enter;
	
	input CLOCK;
	
	reg start;
	reg [7:0]data;
	reg parity;
	reg stop;
	
	reg releasex;
	reg releaseCK;
	
	reg [3:0]position;
	reg [5:0]skipCycles;	
	

	
	always @(posedge ps2ck)
	begin
			
	
			case (position)
				4'd0:
				begin
					test3=!test3;
					start=1;
				end
				4'd1:
				begin
					data[0]=ps2dt;
				end
				4'd2:
				begin
					data[1]=ps2dt;
				end
				4'd3:
				begin
					data[2]=ps2dt;
				end
				4'd4:
				begin
					data[3]=ps2dt;
				end
				4'd5:
				begin
					data[4]=ps2dt;
				end
				4'd6:
				begin
					data[5]=ps2dt;
				end
				4'd7:
				begin
					data[6]=ps2dt;
				end
				4'd8:
				begin
					data[7]=ps2dt;
				end
				4'd9:
				begin
					parity=ps2dt;
				end				
				4'd10:  //Parity
				begin
					stop=ps2dt;
				end
			endcase

		
		position=position+1;
		
		if(stop==1)
		begin
		
			start=0;
			stop=0;
			parity=0;
			position=0;
			case (data)
				8'hF0: 
				begin
					releasex=1'b1;
					releaseCK=1'b0;				
				end
				8'h1D: wasd[0]<=!releasex;
				8'h1B: wasd[2]<=!releasex;	
				8'h1C: wasd[1]<=!releasex;
				8'h23: wasd[3]<=!releasex;
				8'h5A: enter<=!releasex;
				8'h29: space<=!releasex;
			   8'hFA: test3=1'b1;

			endcase
			
			
			if(releaseCK==1'b1)
			begin
				releasex=0;
				releaseCK=0;
			end
			else
			begin
				if(releasex==1'b1)
				begin
					releaseCK=1'b1;
				end
			end
		end
		
	end
	
	

	
	
	reg [32:0]clockDownscaler;
	reg [7:0]dataToSend;
	reg sendEnabled;
	reg [5:0]sendCount;
	
	reg goingUp;
	reg doneWaiting;
	reg [4:0]waitingTime;
	
	
	always @(posedge CLOCK)
	begin
		
		if(clockDownscaler>=32'd4000)
		begin
			clockDownscaler=0;
			
			if(sendEnabled==1'b1)
			begin				
				if(waitingTime<=3)
				begin
					ps2ck=1'b0;
				end	
				waitingTime=waitingTime+1;
			end
			
			if(sendEnabled==1'b1 && waitingTime>3)
			begin
				if(goingUp==1'b0)			
				begin				
					case (sendCount)
						6'd0: ps2dt=1'b0; //START BIT
						6'd1: ps2dt=dataToSend[7]; //START BIT //PLEASE REVERSE BIT ORDER WHEN REAL TESTING
						6'd2: ps2dt=dataToSend[6]; //START BIT
						6'd3: ps2dt=dataToSend[5]; //START BIT
						6'd4: ps2dt=dataToSend[4]; //START BIT
						6'd5: ps2dt=dataToSend[3]; //START BIT
						6'd6: ps2dt=dataToSend[2]; //START BIT
						6'd7: ps2dt=dataToSend[1]; //START BIT
						6'd8: ps2dt=dataToSend[0]; //START BIT
						6'd9: ps2dt=1'b1;
						6'd10: ps2dt=1'b1; //STOP BIT
						6'd11:
						begin
							sendEnabled=1'b0;
							sendCount=6'b0;
						end						
					endcase
				
					if(sendEnabled==1'b1) 
					begin
						sendCount=sendCount+1;
					end
				end
				goingUp=!goingUp;
				
				if(sendEnabled==1'b1) 
				begin
					ps2ck=!ps2ck;
				end			
			end
			else
			begin		
				if(waitingTime>3)
				begin
					ps2dt=1'bZ;
					ps2ck=1'bZ;				
				end
			end
		end
		
		clockDownscaler=clockDownscaler+1;
		test2=ps2dt;
		test=ps2ck;
		
		if(butt==1'b0)
				begin
					sendEnabled=1'b1;
					dataToSend=8'hFF;		
					waitingTime=0;
					goingUp=0;
			
				end	
	end
	
	endmodule

