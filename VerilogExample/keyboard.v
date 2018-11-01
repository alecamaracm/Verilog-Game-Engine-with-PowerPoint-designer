/////////////////////////////////////////////////////////////////////////////////////
//																											  //
//			Base keyboard driver. It works.														  //
//			WASD, space bar and enter are already implmented.								  //
//			If you want to implement more keys, please look at the ps2 key codes.	  //
//			(Picture in the root of the repository)											  //
//																											  //
//			You can have a look at the pin assignments in our example project.        //
//			                                            										  //        
//---------------------------------------------------------------------------------//
//			Don't ever bother asking for help. (We are VERYY mean) (Just kidding)     //
//			You can mail us if you have any questions (cabrera@miamioh.edu) 			  //
//			or ask as in a lab				 														  //			
//																											  //
/////////////////////////////////////////////////////////////////////////////////////



module ps2Keyboard(CLOCK,ps2ck,ps2dt,wasd,space,enter);

	inout ps2ck,ps2dt;
	reg ps2ck,ps2dt;
	
	
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
				begin //releasex will be 1 when the key has been released.
					releasex=1'b1;
					releaseCK=1'b0;				
				end
				8'h1D: wasd[0]<=!releasex;
				8'h1B: wasd[2]<=!releasex;	
				8'h1C: wasd[1]<=!releasex;
				8'h23: wasd[3]<=!releasex;
				8'h5A: enter<=!releasex;
				8'h29: space<=!releasex;   //Just copy this line for any keys you might want to add

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
	
	endmodule

