/////////////////////////////////////////////////////////////////////////////////////
//																											  //
//			UART data transmision driver. (DMA)  												  //
//---------------------------------------------------------------------------------//
//			Don't ever bother asking for help. (We are VERYY mean) (Just kidding)     //
//			You can mail us if you have any questions (cabrera@miamioh.edu) 			  //
//			or ask as in a lab				 														  //			
//																											  //
/////////////////////////////////////////////////////////////////////////////////////


module UART(CLOCK,RX,dt,dtavail,bad);
	
	output [7:0]dt;
	reg [7:0]dt;
	
	output dtavail;
	reg dtavail;
	
	input CLOCK;	
	input RX;
	
	output bad;
	reg bad;
		
	reg [19:0]downClocker;
	
		reg start;
		reg parityCount;
	reg [7:0]data;

	reg parity;
	reg stop;
		
	reg [3:0]position;
	
	always @ (posedge CLOCK)
	begin	
	
		if(downClocker==20'd99)
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
				/*4'd9:
				begin
					parity=RX;
				end	*/			
				4'd9:
				begin
					stop=1;
				end
				endcase		
				
				position=position+1;	
				
				if(stop==1)
				begin			
					
					parityCount=data[0]+data[1]+data[2]+data[3]+data[4]+data[5]+data[6]+data[7];
					
					if(parityCount==parity)
					begin					
						bad=1'b1;
					end
					else
					begin
						bad=1'b0;
					end
					
					dt=data;
					
					dtavail=!dtavail;
					
					start=0;
					stop=0;
					parity=0;
					position=0;
					
					
				end	
			end
			downClocker=20'b0;
		end
		else
		begin
			downClocker=downClocker+20'b1;
		end
		
	
	
	end
endmodule
