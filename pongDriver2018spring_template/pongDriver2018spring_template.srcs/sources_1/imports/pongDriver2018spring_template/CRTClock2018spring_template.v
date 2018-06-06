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


 always @(posedge Clock)
      if(Reset==1)
            begin
                PixelClock <= 0;
                Counter <= 0;       
            end
      else
        if(Counter < (SystemClockFreq / (CRTClockFreq*2)-1))
            begin
                Counter <= Counter + 1'b1;
                PixelClock <= PixelClock;
            end
      else
        begin
            Counter <= 0;
            PixelClock <= ~PixelClock;
        end
            
endmodule

