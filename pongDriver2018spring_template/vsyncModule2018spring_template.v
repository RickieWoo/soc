`timescale 1ns / 1ps
//File: vsyncModule2018spring_template.v
//Author: Jianjian Song
//Date: June 2018
//synch pulse is generated at the end of the line: Active Video-BackPorch-SynchPulse-FrontPorch
//this is a template to be completed by students

module vsyncModule2018spring_template(LineEnd, SynchPulse, FrontPorch, ActiveVideo, BackPorch, vsync, yposition, reset, clock);
parameter yresolution=10;
input [yresolution-1:0] SynchPulse, FrontPorch, ActiveVideo, BackPorch;
input reset, clock, LineEnd;
output vsync;
output [yresolution-1:0] yposition;
wire [yresolution-1:0] ycount;
//hsynch starts next line
ClockedNegativeOneShot RestartUnit(LineEnd, NextLineOneShot, reset, clock);

endmodule
