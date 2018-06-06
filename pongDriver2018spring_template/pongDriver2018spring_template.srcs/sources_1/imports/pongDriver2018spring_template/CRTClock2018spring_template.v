`timescale 1ns / 1ps
//Generate 25MHz VGA clock from a SystemClock
//Jianjian Song
//Spring 2017
//
module CRTClock2018spring_template(SystemClockFreq, CRTClockFreq, PixelClock, Reset, Clock);

parameter SystemClockSize=10;
input [SystemClockSize-1:0] SystemClockFreq;
input [SystemClockSize-1:0] CRTClockFreq;
output reg	PixelClock;
input Reset, Clock;

reg 	[SystemClockSize-1:0]  Counter;

endmodule

