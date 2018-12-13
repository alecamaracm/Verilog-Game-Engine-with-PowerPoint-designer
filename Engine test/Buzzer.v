module buzzing(CLOCK,GPIO,freq,enabled);

input CLOCK;
output GPIO;
reg GPIO;

input enabled;

input [39:0]freq;
reg [29:0]counter;


always @(posedge CLOCK)
begin
	
	if(enabled==1)
	begin
		if(counter>50000000/((freq/2)))
		begin
			GPIO=!GPIO;
			counter=0;
		end
		else
		begin
			counter=counter+1;
		end
	end
	else
	begin
		GPIO=0;
	end
	
	
	
end

endmodule