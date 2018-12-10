module distance(CLOCK,GPIO,TR,ECH,cm);

input CLOCK;
output GPIO;
reg GPIO;


reg [9:0]cm;
output [9:0]cm;

input ECH;
output TR;
reg TR;

reg [29:0]counter2;
reg [39:0]timex;
reg doneThis;

localparam maxCM=100;

always @(posedge CLOCK)
begin
	
	if(counter2<50)
	begin
		TR=1;
		doneThis=0;
		timex=0;
	end
	else if(counter2>(5000000))
	begin		
		counter2=0;
	end
	else
	begin
		TR=0;
		if(ECH==0)
		begin
			timex=timex+1;
		end
		if(ECH==1 && doneThis==0)
		begin
			doneThis=1;
			if((timex/58.82)<maxCM)
			begin
				cm=(timex/58.82);	
			end
		
		end		
	end	
	counter2=counter2+1;
	
end



endmodule