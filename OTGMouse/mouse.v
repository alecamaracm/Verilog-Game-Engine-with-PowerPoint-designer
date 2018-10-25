module ps2Mouse(CLOCK,ps2ck,ps2dt,M1,M2,dirs,countt,reset);

	input ps2ck,ps2dt;
	
	output [3:0]dirs;
	output M1;
	output M2;
	reg [3:0]dirs,M1,M2;
	
	input CLOCK;	
input reset;
	
	reg [3:0]position;	
	
	reg [1:0]byteCount;
	
	reg[9:0]countt;
	output[9:0]countt;
	
	wire	[7:0]ps2_data;
	reg	[7:0]last_ps2_data;
	wire	ps2_newData;
	
	assign M1=ps2_newData;
	//reg	[7:0]ps2_data;
	//reg	ps2_newData;
	
	mouse_Inner_controller innerMouse (
	.CLOCK_50				(CLOCK),
	.reset				(reset),
	.PS2_CLK			(ps2ck),
 	.PS2_DAT			(ps2dt),
	.received_data		(ps2_data),
	.received_data_en	(ps2_newData)
	);	
	
	always @(posedge CLOCK)
	begin
			if(ps2_data!=last_ps2_data)
			begin			
				case (byteCount)
					2'd0:
					begin		
										
						//M1=ps2_data[2];
						//M2=ps2_data[3];
					end
					2'd1:
					begin
					
					end
					2'd2:
					begin	
					
						byteCount=2'd0;
					end				
					default: byteCount=2'd0;
				endcase
				
				last_ps2_data=ps2_data;
				
				byteCount=byteCount+1;
				
				//M1=!M1;
		
			end
			

		
	end
	
	
endmodule

