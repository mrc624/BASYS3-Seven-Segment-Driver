

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
    
    parameter ZERO = 1'b0;
    parameter NINE = 4'b1001;
    parameter NINETEEN = 4'b10011;
    parameter TWENTY_NINE = 5'b11101;
    parameter THIRTY_NINE = 6'b100111;
    parameter FOURTY_NINE = 6'b110001;
    parameter FIFTY_NINE = 6'b111011;
    parameter  SIXTY_NINE = 6'b1000101;
    parameter SEVENTY_NINE = 6'b1001111;
    parameter EIGHTY_NINE = 6'b1011001;
    parameter NINETY_NINE = 7'b110_0011;
    parameter HUNDRED_NINETY_NINE = 8'b1100_0111;
    parameter ONE = 1'b1;
    parameter TWO = 2'b10;
    
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
        if (num < NINE) begin
            num1 = OFF;
        end else begin
            /*num1 = num - num2;
            if (num1 > NINETY_NINE) begin
                num1 = ZERO;
            end else if (num1 > EIGHTY_NINE) begin
                num1 = NINE;
            */
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
    output reg [6:0] seg,
    output [3:0] an
    );
    //parameter TURN_OFF_SEGMENT = 5'b10000;
    //parameter DASH_SEGMENT = 5'b10001;
    
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
    
    wire seg_clk;
    segment_clock U0 (clk, seg_clk);
    handle_an_gate U1 (seg_clk, an);
    always @ (posedge seg_clk)
    begin  
        if(an == 4'b0111) begin //num0
            case (num0)
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
        end else if(an == 4'b1110) begin //num1
                case (num1)
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
        end else if(an == 4'b1101) begin //num2
                case (num2)
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
        end else if(an == 4'b1011) begin //num3
                case (num3)
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