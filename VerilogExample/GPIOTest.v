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

reg doneThis;

reg [29:0]echoStart;
reg inEcho;

always @(posedge CLOCK)
begin
	
	//if(counter>(125000/2))
	if(counter>(25000000/freq))
	begin
		GPIO=!GPIO;
		counter=0;
	end
	else
	begin
		counter=counter+1;
	end

	
	if(counter2<500)
	begin
		inEcho=0;
		TR=1;
		doneThis=0;
	end
	else if(counter2>(5000000))
	begin		
		counter2=0;
	end
	else
	begin
		TR=0;
		if(ECH==1 && inEcho==0 && doneThis==0)
		begin
			inEcho=1;
			echoStart=counter2;
		end
		
		if(ECH==0 && inEcho==1)
		begin
			if(counter2-echoStart<150000)
			begin
				//freq=(freq+((counter2-echoStart-7500)/155));
				freq=(freq+((counter2-echoStart-7500)/155))/2;
			end
			
			leds=freq/15;
			
			inEcho=0;
			doneThis=1;
		end
	end
	
	counter2=counter2+1;
end



endmodule