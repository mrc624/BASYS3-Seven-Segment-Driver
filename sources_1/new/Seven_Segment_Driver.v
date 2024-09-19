

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2024 01:54:47 PM
// Design Name: 
// Module Name: Seven_Segment_Driver
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

module Display_8Bit(
    input [7:0] num,
    input clk,
    output [6:0] seg,
    output [3:0] an
    );
    
    parameter OFF = 5'b10000;
    
    parameter ONE = 1'b1;
    parameter TWO = 2'b10;
    parameter TEN = 4'b1010;
    parameter NINETY_NINE = 7'b110_0011;
    parameter HUNDRED_NINETY_NINE = 8'b1100_0111;
    
    reg [5:0] num2;
    reg [5:0] num1;
    reg [5:0] num0;
    
    always @ (num) begin
        //handling the hundreds place
        if (num > HUNDRED_NINETY_NINE ) begin
            num2 = TWO;
        end else if (num > NINETY_NINE) begin
            num2 = ONE;
        end else begin
            num2 = OFF;
        end
        
        //handling tens place
        if (num < TEN) begin
            num1 = OFF;
        end else begin
            num1 = (num / 10) % 10;
        end
        
        //handling ones place
        if (num == 0) begin
            num0 = OFF;
        end else begin
            num0 = num % 10;        
        end
    end
    
    Display(OFF, num2, num1, num0, clk, seg, an);

endmodule 

module Display(
    input [5:0] num3,
    input [5:0] num2,
    input [5:0] num1,
    input [5:0] num0,
    input clk,
    output wire [6:0] seg,
    output wire [3:0] an
    );
    wire [6:0] seg0;
    segment U0 (num0, seg0);
    wire [6:0] seg1;
    segment U1 (num1, seg1);
    wire [6:0] seg2;
    segment U2 (num2, seg2);
    wire [6:0] seg3;
    segment U3 (num3, seg3);
    
    wire seg_clk;
    segment_clock U4 (clk, seg_clk);
    handle_an_gate U5 (seg_clk, an);
    segment_mux U6 (an, seg0, seg1, seg2, seg3, seg);
endmodule

module segment_mux(
    input [3:0] an,
    input [6:0] seg0,
    input [6:0] seg1,
    input [6:0] seg2,
    input [6:0] seg3,
    output reg [6:0] seg_out
    );
    
    parameter DISP_ZERO =  4'b1110;
    parameter DISP_ONE =   4'b1101;
    parameter DISP_TWO =   4'b1011;
    parameter DISP_THREE = 4'b0111;
    
    always @ (*) begin
        if(an == DISP_ZERO) begin //num0
            seg_out = seg0;
        end else if(an == DISP_ONE) begin //num1
            seg_out = seg1;
        end else if(an == DISP_TWO) begin //num2
            seg_out = seg2;
        end else if(an == DISP_THREE) begin //num3
            seg_out = seg3;
        end 
    end
    
endmodule

module segment(
    input [5:0] num,
    output reg [6:0] seg
    );
    
    parameter ZERO = 7'b0000001;
    parameter ONE = 7'b1001111;
    parameter TWO = 7'b0010010;
    parameter THREE = 7'b0000110;
    parameter FOUR = 7'b1001100;
    parameter FIVE = 7'b0100100;
    parameter SIX = 7'b0100000;
    parameter SEVEN = 7'b0001111;
    parameter EIGHT = 7'b0000000;
    parameter NINE = 7'b0000100;
    parameter TEN = 7'b0001000;
    parameter ELEVEN = 7'b1100000;
    parameter TWELVE = 7'b0110001;
    parameter THIRTEEN = 7'b1000010;
    parameter FOURTEEN = 7'b0110000;
    parameter FIFTEEN = 7'b0111000;
    parameter OFF = 7'b1111111;
    parameter DASH = 7'b1111110;
    
    always @ (num) begin
        case (num)
            0:  seg=ZERO;
            1:  seg=ONE;
            2:  seg=TWO;
            3:  seg=THREE;
            4:  seg=FOUR;
            5:  seg=FIVE;
            6:  seg=SIX;
            7:  seg=SEVEN;
            8:  seg=EIGHT;
            9:  seg=NINE;
            10: seg=TEN;
            11: seg=ELEVEN;
            12: seg=TWELVE;
            13: seg=THIRTEEN;
            14: seg=FOURTEEN;
            15: seg=FIFTEEN;
            16: seg=OFF;
            17: seg=DASH;
        endcase
    end
    
endmodule

module handle_an_gate(
    input clk,
    output reg [3:0] gate
    );
    reg [3:0] gate_num;
    always @ (negedge clk)
    begin
        gate_num = gate_num + 1;
        
        if(gate_num == 4) begin
            gate_num = 0;
            gate[0] = 1;
            gate[1] = 1;
            gate[2] = 1;
            gate[3] = 1;
        end  
          
        if(gate_num == 0) begin
            gate[0] = 0;
            gate[1] = 1;
            gate[2] = 1;
            gate[3] = 1;
        end
        
        if(gate_num == 1) begin
            gate[0] = 1;
            gate[1] = 0;
            gate[2] = 1;
            gate[3] = 1;
        end  
        
        if(gate_num == 2) begin
            gate[0] = 1;
            gate[1] = 1;
            gate[2] = 0;
            gate[3] = 1;
        end  
        
        if(gate_num == 3) begin
            gate[0] = 1;
            gate[1] = 1;
            gate[2] = 1;
            gate[3] = 0;
        end   
        
    end
endmodule

module segment_clock(
    input clk_in,
    output reg clk_out
    );

reg [20:0] period_count = 0;
always @ (posedge clk_in)
    if (period_count!= 100000)
    begin
        period_count<= period_count + 1;
        clk_out <= 0; //clk_out gets 0.
    end
    else
    begin
        period_count <= 0;
        clk_out <= 1;
    end

endmodule