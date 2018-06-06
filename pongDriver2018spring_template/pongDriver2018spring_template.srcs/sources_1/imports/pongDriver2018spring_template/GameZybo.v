`timescale 1ns / 1ps
// -----------------------------------------------
// updates the ball and paddle positions, and
// determines the output video image
// -----------------------------------------------

//Revised to work on Zybo board
//Jianjian Song
//Date: March 2017
//added Reset to the circuit
module gameZybo(input clk25, input Reset,
				input [9:0] xpos,
				input [9:0] ypos,
				input rota,
				input rotb,
				output [4:0] red,
				output [5:0] green,
				output [4:0] blue);
		
// paddle movement		
reg [8:0] paddlePosition;
reg [2:0] quadAr, quadBr;
always @(posedge clk25) quadAr <= {quadAr[1:0], rota};
always @(posedge clk25) quadBr <= {quadBr[1:0], rotb};

always @(posedge clk25)
if(quadAr[2] ^ quadAr[1] ^ quadBr[2] ^ quadBr[1])
begin
	if(quadAr[2] ^ quadBr[1]) begin
		if(paddlePosition < 508)        // make sure the value doesn't overflow
			paddlePosition <= paddlePosition + 3'd4;
	end
	else begin
		if(paddlePosition > 3)        // make sure the value doesn't underflow
			paddlePosition <= paddlePosition - 3'd4;
	end
end
		
// ball movement	
reg [9:0] ballX;
reg [8:0] ballY;
reg ballXdir, ballYdir;
reg bounceX, bounceY;
	
wire endOfFrame = (xpos == 0 && ypos == 480);
	
always @(posedge clk25) begin
	if (endOfFrame) begin // update ball position at end of each frame
		if (ballX == 0 && ballY == 0) begin // cheesy reset handling, assumes initial value of 0
			ballX <= 480;
			ballY <= 300;
		end
		else begin
			if (ballXdir ^ bounceX) 
				ballX <= ballX + 5'd2;
			else 
				ballX <= ballX - 5'd2;	

			if (ballYdir ^ bounceY) 
				ballY <= ballY + 5'd2;
			else
				ballY <= ballY - 5'd2;	
		end
	end	
end		
		
// pixel color	
reg [10:0] missTimer;	
wire visible = (xpos < 640 && ypos < 480);
wire top = (visible && ypos <= 5);
wire bottom = (visible && ypos >= 476);
wire left = (visible && xpos <= 5);
wire right = (visible && xpos >= 636);
wire border = (visible && (left || right || top));
wire paddle = (xpos >= paddlePosition+4 && xpos <= paddlePosition+124 && ypos >= 440 && ypos <= 447);
wire ball = (xpos >= ballX && xpos <= ballX+7 && ypos >= ballY && ypos <= ballY+7);
wire background = (visible && !(border || paddle || ball));
wire checkerboard = (xpos[5] ^ ypos[5]);
wire missed = visible && missTimer != 0;

//assign red   = { missed || border || paddle, 2'b00};	//3 bits red
assign red   = { missed&&(!paddle||!ball) || border || paddle, missed&&(!paddle||!ball) || border || paddle, 3'b000};	//5 bits red
assign green = { !missed && (border || paddle || ball),  !missed && (border || paddle || ball), 4'b0000};	//6 bits green
assign blue  = { !missed && (border || ball), background && checkerboard,background && checkerboard, 2'b00}; //5 bits blue
		
// ball collision	
always @(posedge clk25) begin
	if (!endOfFrame) begin
		if (ball && (left || right))
			bounceX <= 1;
		if (ball && (top || bottom || (paddle && ballYdir)))
			bounceY <= 1;
		//display missed screen for 63 frames
		if (ball && bottom)
			missTimer <= 63;
	end
	else begin
		if (ballX == 0 && ballY == 0) begin // cheesy reset handling, assumes initial value of 0
			ballXdir <= 1;
			ballYdir <= 1;
			bounceX <= 0;
			bounceY <= 0;
		end 
		else begin
			if (bounceX)
				ballXdir <= ~ballXdir;
			if (bounceY)
				ballYdir <= ~ballYdir;			
			bounceX <= 0;
			bounceY <= 0;
			if (missTimer != 0)
				missTimer <= missTimer - 1'b1;
		end
	end
end
		
endmodule
