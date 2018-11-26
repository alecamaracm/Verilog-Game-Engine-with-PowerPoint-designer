/*module SDRAM(clk,in,out,open,write,read,dt,addr,dq,clkd,clke,we,cas,ras,cs,ba);

input clk,write,read,open;
input [7:0]in;
output [7:0]out;
reg [7:0]out;




inout [15:0]dt;
output [12:0]addr;
output [1:0]dq;
output clkd,clke,we,cas,ras,cs;
output [1:0]ba;

reg [12:0]addr;
reg cs,we,cas,ras;
reg [1:0]ba;
reg [1:0]dq;


assign clkd=clk;
assign clke=1'b1;


reg WOE;
assign dt = WOE ? {in,in} : 16'hZZZZ;
reg RE;
always @(posedge clk) if(ROE==1'b1) out=dt[7:0];


reg [5:0]idleCount;


always @(posedge clk)
begin
	
	case(state)
	
	sidle:
	begin
		if(idleCount>=6'd10)
		begin
			
		
		end
		else
		begin
		
		
		end
	end
	
	endcase
	
	

end



endmodule*/

