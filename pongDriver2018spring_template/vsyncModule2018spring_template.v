`timescale 1ns / 1ps
//File: vsyncModule2018spring_template.v
//Author: Jianjian Song
//Date: June 2018
//synch pulse is generated at the end of the line: Active Video-BackPorch-SynchPulse-FrontPorch
//this is a template to be completed by students

module vsyncModule2018spring_template(LineEnd, SynchPulse, FrontPorch, ActiveVideo, BackPorch, vsync, yposition, reset, clock);
parameter BeginX = 10'd0;
parameter BeginY = 10'd0;
parameter yresolution=10;
input [yresolution-1:0] SynchPulse, FrontPorch, ActiveVideo, BackPorch;
input reset, clock, LineEnd;
output vsync;
output [yresolution-1:0] yposition;
wire [yresolution-1:0] ycount;
//hsynch starts next line
ClockedNegativeOneShot RestartUnit(LineEnd, NextLineOneShot, reset, clock);

assign LineEnd=ycount==EndCount;	//reset counter
wire [yresolution-1:0] EndCount= SynchPulse + FrontPorch + ActiveVideo + BackPorch;
//synch pulse appears at the end of the line and after front porch to mimic the pong video_timer
//hsync <= ~(xpos > 664 && xpos <= 760);  // active for 95 clocks
assign hsync = ~(xcount >= (ActiveVideo+FrontPorch) && xcount <= (ActiveVideo+FrontPorch+SynchPulse));

always@(xcount, SynchPulse, BackPorch, ActiveVideo, FrontPorch) 
	xposition<=xcount;	//the game circuit does not work if xposition does not run from 0 to 800. JJS
    //module UniversalCounter10bitsV5(P,BeginCount, EndCount, Q,S1,S0,TerminalCount, Reset, CLOCK);
UniversalCounter10bits YPositionCounter(BeginX, BeginY, EndCount, ycount, LineEnd,LineEnd||PixelClockOneShot,   , reset, clock) ;

endmodule
