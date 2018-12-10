module buzzing(CLOCK,GPIO,freq);

input CLOCK;
output GPIO;
reg GPIO;

input [39:0]freq;
reg [29:0]counter;


always @(posedge CLOCK)
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

endmodule