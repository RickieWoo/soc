`timescale 1ns / 1ps
//File Name: CRTcontroller2018spring.v
//Author: Jianjian Song
//Date: June 2018
//Test: on Zybo board successfully
//Purpose: generate VGA timing signals hsync and vsync
// and synchronized(x,y) coordinates.
//inputs: resolution (x,y) and system clock in MHz
////active videos are Xresolution and Yresolution
//x ranges from 600 to 800 pixels. y ranges from 400 to 600 pixels
//synch pulse, back porch and front porch are defined within this module
// hsync <= ~(xposos > 664 && xposos <= 760);  // active for 95 clocks
// vsync <= ~(yposos == 490 || yposos == 491);   // active for lines 490 and 491

module CRTcontroller2018spring(Xresolution, Yresolution, SystemClockFreq, CRTClockFreq, hsync, vsync, xpos, ypos, reset, clock);
parameter ResolutionSize=10, SystemClockSize=10;
input [ResolutionSize-1:0] Xresolution, Yresolution;
input [SystemClockSize-1:0] SystemClockFreq, CRTClockFreq;
input reset, clock;
output hsync, vsync;
output [ResolutionSize-1:0] xpos, ypos;	//x and y position coordinates
//vsync is generated after active video and front porch from =>490 to >=491 
parameter vSynchPulse=10'd2, vFrontPorch=10'd10, vBackPorch=10'd29; //vsynch=520
//hsync is generated after active video and front porch from >664 to >=760 
parameter hSynchPulse=10'd95, hFrontPorch=10'd25, hBackPorch=10'd40; //hsynch=800

wire LineEnd, PixelClock;

//module hsyncModule2018spirng(PixelClock, SynchPulse, BackPorch, ActiveVideo, FrontPorch, hsync, LineEnd, xposition, reset, clock);
hsyncModule2018spring hsyncModule(PixelClock, hSynchPulse, hBackPorch,  Xresolution, hFrontPorch, hsync, LineEnd, xpos, reset, clock);

//module vsyncModule2018spring_template(LineEnd, SynchPulse, FrontPorch, ActiveVideo, BackPorch, vsync, yposition, reset, clock);
vsyncModule2018spring_template vsyncModule(LineEnd, vSynchPulse, vFrontPorch, Yresolution, vBackPorch, vsync, ypos, reset, clock);

//module CCRTClock2018spring_template(SystemClockFreq, CRTClockFreq, PixelClock, Reset, Clock);
CRTClock2018spring_template CRTclockUnit(SystemClockFreq, CRTClockFreq, PixelClock, reset, clock);
endmodule
