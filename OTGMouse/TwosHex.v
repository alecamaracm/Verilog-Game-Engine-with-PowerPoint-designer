module seg7 (inputBits,out,negativeOut);

input [4:0]inputBits;
output negativeOut;
reg dumb;


output [6:0]out;

assign negativeOut=!inputBits[4];

twoComp comp(inputBits,inverted);

reg W,X,Y,Z;
wire [4:0]inverted;

 
assign out[0]=!(Z&&!W&&X||W&&!Y&&!Z||!X&&!Z||W&&!X&&!Y||X&&Y||!W&&Y);
assign out[1]=!(!Y&&!Z&&!W|| W&&!X&&!Y || !W&&Y&&Z || !W&&!X || (!Z && !X) || (!Y&&Z&&W));
assign out[2]=!(!W&&!X&&!Y || !W&&X ||W&&!X ||W&&!Y&&Z || Y&&Z&&!W);
assign out[3]=!(W&&!Y&&!Z||!X&&!Y&&!Z||!Y&&Z&&X||Y&&Z&&!X||Y&&!W&&!X || Y&&!Z&&X);
assign out[4]=!(!X&&!Y&&!Z || W&&X&&!Y||Y&&W||Y&&!Z);
assign out[5]=!(!Y&&!Z||!W&&X&&!Y||W&&!X||Y&&W||X&&Y&&!Z);
assign out[6]=!(!Y&&!W&&X||W&&!X||Z&&W||!X&&Y&&Z||Y&&!Z); 

always @(*)
begin
	if(inputBits[4]==1'b1)
	begin
		{dumb,W,X,Y,Z}=inverted;
	end
	else
	begin
		{dumb,W,X,Y,Z}=inputBits;	
	end
end
	  
endmodule


module twoComp(in,out);

input [4:0]in;
wire [4:0]semiOUT;
output [4:0]out;

assign semiOUT=~in;

bit4Adder(semiOUT,5'b00001,out);

endmodule




module fullAdder(i1,i2,cin,o,cout);

input i1;
input i2;
input cin;

wire o;
output o;
output cout;

assign cout= (i1&&i2)||(i1&&cin)||(i2&&cin);
assign o=i1^i2^cin;



endmodule



module bit4Adder(in1,in2,out);

input [4:0]in1;
input [4:0]in2;

output [4:0]out;

wire c12,c23,c34,c45;
wire useless;
//assign out=5'b11111;
fullAdder bit1(in1[0],in2[0],1'b0,out[0],c12);
fullAdder bit2(in1[1],in2[1],c12,out[1],c23);
fullAdder bit3(in1[2],in2[2],c23,out[2],c34);
fullAdder bit4(in1[3],in2[3],c34,out[3],c45);
fullAdder bit5(in1[4],in2[4],c45,out[4],useless);

endmodule