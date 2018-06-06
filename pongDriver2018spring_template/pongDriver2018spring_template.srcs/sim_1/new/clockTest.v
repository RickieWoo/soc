`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/06 11:22:45
// Design Name: 
// Module Name: clockTest
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clockTest;
reg reset,clock;
reg [7:0] SystemClockFreq,CRTClockFreq;	// Inputs
wire PixelClock;


	initial begin
// Initialize Inputs
        reset = 1; clock=0; #5;
		reset = 0; SystemClockFreq = 25;	CRTClockFreq = 5;  #50;
		reset = 1; #5;
		$stop;
	end
	
	always begin
	   #1 clock = ~clock;
    end
    
    CRTClock2018spring_template CRCClockInstance(SystemClockFreq,CRTClockFreq,PixelClock,reset,clock);
endmodule
