`timescale 1ns / 1ps
///File: PongDriver2018sprig.v
//HUST
//Date: March 2017
//the video controller uses synch timings from the pong game
//the system clock should be 125MHz
//the VGA pixel clock is 25MHz
//this is a template for students to complete
//try to match the video_timer

module PongDriver2018spring(
    input Clock, Reset, rota, rotb,
    output [4:0] red,
    output [5:0] green,
    output [4:0] blue,
    output hsync, vsync
    );

wire [9:0] xpos;
wire [9:0] ypos;

parameter [9:0] NumberofPixels=10'd640, NumberofLines=10'd480;
parameter [9:0] SystemClock=10'd125, CRTClock=10'd25; //MHz 

//module CRTcontroller2015fall VGAdisplay(NumberofPixels, NumberofLines, SystemClock, CRTClock, 
    //hsync, vsync, xpos, ypos, Reset, Clock);
CRTcontroller2018spring VGAdisplay(NumberofPixels, NumberofLines, SystemClock, CRTClock, 
     hsync, vsync, xpos, ypos, Reset, Clock);
gameZybo gameUnit(Clock, Reset, xpos, ypos, rota, rotb, red, green, blue);
					
endmodule
