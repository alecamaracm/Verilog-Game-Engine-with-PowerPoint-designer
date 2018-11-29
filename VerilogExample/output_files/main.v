module buzzing(CLOCK,GPIO,TR,ECH,leds);

input CLOCK;
output GPIO;
reg GPIO;

reg [9:0]leds;
output [9:0]leds;

input ECH;
output TR;
reg TR;

reg [39:0]freq;
reg [29:0]counter;
reg [29:0]counter2;
reg [39:0]timex;
reg doneThis;

always @(posedge CLOCK)
begin
	
	//if(counter>(125000/2))
	if(counter>(freq/2))
	begin
		GPIO=!GPIO;
		counter=0;
	end
	else
	begin
		counter=counter+1;
	end

	
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
			leds=(timex/375);
			
		end		
	end
	leds[2]=ECH;
counter2=counter2+1;
end



endmodule