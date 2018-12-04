module UART2(CLOCK,RX,reset,dataReceived,dataAvail,dataToSend,sendData);

input CLOCK;
input RX;

input reset;


reg [3:0]RXstate;

parameter RXidle=4'b0000;
parameter RXstart=4'b0001;
parameter RXget=4'b0010;
parameter RXwait=4'b0011;

reg [9:0]RXcount;
reg [5:0]RXdataBit;

reg [7:0]data;

output [7:0]dataReceived;
reg [7:0]dataReceived;

reg dataAvail;
output dataAvail;

input [7:0]dataToSend;
input sendData;

reg [19:0]watchgod;

always @ (posedge CLOCK)
begin
	if(reset==1'b0 || watchgod>=20'd2500)
	begin
		RXstate=RXidle;
		RXcount=10'd0;
		RXdataBit=6'd0;
		data=8'd0;		
	end
	else
	begin
		watchgod=watchgod+20'd1;	
	end

	case (RXstate)
	
		RXidle:
		begin
			if(RX==1'b0)
			begin
				RXstate=RXstart;
				RXcount=10'd0; 
				watchgod=20'd0;
			end
		end
		RXstart:
		begin
			if(RXcount>=10'd149)
			begin
				RXstate=RXget;
				RXcount=10'd100; //The next bit must be read now			
				RXdataBit=6'd0;
			end
			else
			begin
				RXcount=RXcount+10'd1;
			end
		end
		RXget:
		begin
			if(RXcount>=10'd99)
			begin
				data[RXdataBit]=RX;
				RXdataBit=RXdataBit+6'd1;
				RXcount=10'd0;
				if(RXdataBit>=6'd8)
				begin
					RXstate=RXwait;				

					dataReceived=data;
					dataAvail=!dataAvail;
				end
			end
			else
			begin
				RXcount=RXcount+10'd1;				
			end	
		end
		RXwait:
		begin
			if(RXcount>=10'd250)
			begin
				RXstate=RXidle;
				RXcount=10'd0;
				RXdataBit=6'd0;
				data=8'd0;
				
			end
			else
			begin
				RXcount=RXcount+10'd1;				
			end			
		end
	
	
	endcase


end


endmodule