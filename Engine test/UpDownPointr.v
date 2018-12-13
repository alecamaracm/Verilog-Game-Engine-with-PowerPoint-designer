


module placerUpDown(CLOCK,pointY,RX,reset);

	output [9:0]pointY;
	input CLOCK;
	reg [9:0]pointY;
	input RX;
		input reset;
		

	
	reg [4:0]count;
	wire dataAvail,u3;
	wire [7:0]data;
	
	wire [7:0]dataSend;
	
	reg lastdataAvail;
	wire RXerror,RXvalid;
	
	reg [7:0]firstData;
	reg [15:0]fullData;
	
	wire TX;
	
	reg [10:0]newValue;
	
	UART2 uart(CLOCK,RX,reset,data,dataAvail,dataSend,1'b0);
	
	reg [59:0]timeout;
	
	//assign leds=data;
	always @(posedge CLOCK)
	begin
		
		if(timeout>=60'd350000)
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
				
				firstData=data;
			
				count=1;
			end
			5'd1:
			begin
				
				fullData={data,firstData};
				newValue=(fullData[9:0]/4)+99;
				if(newValue>pointY)
				begin
					if(newValue-pointY>300) newValue=pointY;
				end
				else				
				begin
					if(pointY-newValue>300) newValue=pointY;
				end
				pointY=(pointY/2)+((newValue/2));
			
		
				count=0;
			end
							
			endcase
			
			
		
			lastdataAvail=dataAvail;
		
		end	
		
		
		
	end			
	
	

endmodule