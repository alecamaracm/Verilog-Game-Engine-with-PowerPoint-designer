module distance(CLOCK,TR,ECH,cm);

input CLOCK;

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
	else if(counter2>500000)
	begin		
		TR=0;
		counter2=0;
		if(timex>0 && timex<192000)
		begin
			timex=timex/50; //Microseconds
			timex=timex/2;  //Two way;
			timex=timex/2;			
			cm=timex;			
		end
		
	end
	else
	begin
		TR=0;
		if(ECH==1)
		begin
			timex=timex+1;
		end			
	end	
	counter2=counter2+1;
	

end



endmodule