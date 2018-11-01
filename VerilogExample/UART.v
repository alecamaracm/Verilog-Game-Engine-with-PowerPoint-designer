/////////////////////////////////////////////////////////////////////////////////////
//																											  //
//			UART data transmision driver. (DMA)  												  //
//---------------------------------------------------------------------------------//
//			Don't ever bother asking for help. (We are VERYY mean) (Just kidding)     //
//			You can mail us if you have any questions (cabrera@miamioh.edu) 			  //
//			or ask as in a lab				 														  //			
//																											  //
/////////////////////////////////////////////////////////////////////////////////////


module UART_DMA(CLOCK,RX,leds);
	
	output [7:0]leds;
	reg [7:0]leds;
	
	input CLOCK;	
	input RX;
		
	reg [9:0]downClocker;
	
		reg start;
	reg [7:0]data;
	reg parity;
	reg stop;
		
	reg [3:0]position;
	
	always @ (posedge CLOCK)
	begin	
	
		if(downClocker==99)
		begin
			if(!RX || position>0)
			begin
				case (position)
				4'd0:
				begin	
					start=1;
				end
				4'd1:
				begin
					data[0]=RX;
				end
				4'd2:
				begin
					data[1]=RX;
				end
				4'd3:
				begin
					data[2]=RX;
				end
				4'd4:
				begin
					data[3]=RX;
				end
				4'd5:
				begin
					data[4]=RX;
				end
				4'd6:
				begin
					data[5]=RX;
				end
				4'd7:
				begin
					data[6]=RX;
				end
				4'd8:
				begin
					data[7]=RX;
				end
				//4'd9:
				//begin
				//	parity=RX;
				//end				
				4'd9:  //Parity
				begin
					stop=1;
				end
				endcase		
				
				position=position+1;	
				
				if(stop==1)
				begin				
					start=0;
					stop=0;
					parity=0;
					position=0;
					leds=data;
				end	
			end
			downClocker=10'b0;
		end
		else
		begin
			downClocker=downClocker+10'b1;
		end
		
	
	
	end
endmodule
