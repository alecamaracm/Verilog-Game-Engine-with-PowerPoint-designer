module OTGMouse(CLOCK,leds,ps2ck,ps2dt,ps2ck2,ps2dt2,butt);

	
	output [15:0]leds;	

	
	inout ps2ck,ps2dt,ps2ck2,ps2dt2;
	input butt;
	input CLOCK;
	
	//ps2Keyboard keyboard(CLOCK,ps2ck2,ps2dt2,leds[3:0],leds[4],leds[5],leds[9],butt,leds[10],leds[15]);
	ps2Mouse mouse(CLOCK,ps2ck,ps2dt,leds[4],leds[5],leds[3:0],leds[15:6],butt);
	
	
endmodule

