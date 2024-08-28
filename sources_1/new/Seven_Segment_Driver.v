

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

module Display_Decimal(
    input clk,
    input [3:0] num,
    output [6:0] seg_out,
    output [3:0] an_out
    );
    
    wire seg_clk;
    reg [6:0] seg;
    segment_clock U0 (clk, seg_clk);
    always @ (posedge seg_clk)
    begin  
        case (num)
            0:  seg=7'b0000001;
            1:  seg=7'b1001111;
            2:  seg=7'b0010010;
            3:  seg=7'b0000110;
            4:  seg=7'b1001100;
            5:  seg=7'b0100100;
            6:  seg=7'b0100000;
            7:  seg=7'b0001111;
            8:  seg=7'b0000000;
            9:  seg=7'b0000100;
            10: seg=7'b0001000;
            11: seg=7'b1100000;
            12: seg=7'b0110001;
            13: seg=7'b1000010;
            14: seg=7'b0110000;
            15: seg=7'b0111000;
        endcase
       
    end
    
    assign seg_out = seg;
    
    //assign an_out[0] = an_in[0];
    //assign an_out[1] = an_in[1];
    //assign an_out[2] = an_in[2];
    //assign an_out[3] = an_in[3];
    
endmodule

module Display_Hex(
    input clk,
    input [4:0] num0,
    input [4:0] num1,
    input [4:0] num2,
    input [4:0] num3,
    output [6:0] seg_out,
    output [3:0] an_out
    );
    
    wire seg_clk;
    wire [3:0] an;
    reg [6:0] seg;
    segment_clock U0 (clk, seg_clk);
    handle_an_gate U1 (seg_clk, an);
    always @ (posedge seg_clk)
    begin  
        if(an == 4'b1000) begin //num0
            case (num0)
                0:  seg=7'b0000001;
                1:  seg=7'b1001111;
                2:  seg=7'b0010010;
                3:  seg=7'b0000110;
                4:  seg=7'b1001100;
                5:  seg=7'b0100100;
                6:  seg=7'b0100000;
                7:  seg=7'b0001111;
                8:  seg=7'b0000000;
                9:  seg=7'b0000100;
                10: seg=7'b0001000;
                11: seg=7'b1100000;
                12: seg=7'b0110001;
                13: seg=7'b1000010;
                14: seg=7'b0110000;
                15: seg=7'b0111000;
                16: seg=7'b1111111;
                17: seg=7'b1111111;
            endcase
        end else if(an == 4'b0100) begin //num1
                case (num1)
                0:  seg=7'b0000001;
                1:  seg=7'b1001111;
                2:  seg=7'b0010010;
                3:  seg=7'b0000110;
                4:  seg=7'b1001100;
                5:  seg=7'b0100100;
                6:  seg=7'b0100000;
                7:  seg=7'b0001111;
                8:  seg=7'b0000000;
                9:  seg=7'b0000100;
                10: seg=7'b0001000;
                11: seg=7'b1100000;
                12: seg=7'b0110001;
                13: seg=7'b1000010;
                14: seg=7'b0110000;
                15: seg=7'b0111000;
                16: seg=7'b1111111;
                17: seg=7'b1111111;
            endcase
        end else if(an == 4'b0010) begin //num2
                case (num2)
                0:  seg=7'b0000001;
                1:  seg=7'b1001111;
                2:  seg=7'b0010010;
                3:  seg=7'b0000110;
                4:  seg=7'b1001100;
                5:  seg=7'b0100100;
                6:  seg=7'b0100000;
                7:  seg=7'b0001111;
                8:  seg=7'b0000000;
                9:  seg=7'b0000100;
                10: seg=7'b0001000;
                11: seg=7'b1100000;
                12: seg=7'b0110001;
                13: seg=7'b1000010;
                14: seg=7'b0110000;
                15: seg=7'b0111000;
                16: seg=7'b1111111;
                17: seg=7'b1111111;
            endcase
        end else if(an == 4'b0001) begin //num3
                case (num3)
                0:  seg=7'b0000001;
                1:  seg=7'b1001111;
                2:  seg=7'b0010010;
                3:  seg=7'b0000110;
                4:  seg=7'b1001100;
                5:  seg=7'b0100100;
                6:  seg=7'b0100000;
                7:  seg=7'b0001111;
                8:  seg=7'b0000000;
                9:  seg=7'b0000100;
                10: seg=7'b0001000;
                11: seg=7'b1100000;
                12: seg=7'b0110001;
                13: seg=7'b1000010;
                14: seg=7'b0110000;
                15: seg=7'b0111000;
                16: seg=7'b1111111;
                17: seg=7'b1111111;
            endcase
        end 
    end
    
    assign seg_out = seg;
    
    assign an_out = ~an;
    
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
            gate[0] = 0;
            gate[1] = 0;
            gate[2] = 0;
            gate[3] = 0;
        end  
          
        if(gate_num == 0) begin
            gate[0] = 1;
            gate[1] = 0;
            gate[2] = 0;
            gate[3] = 0;
        end
        
        if(gate_num == 1) begin
            gate[0] = 0;
            gate[1] = 1;
            gate[2] = 0;
            gate[3] = 0;
        end  
        
        if(gate_num == 2) begin
            gate[0] = 0;
            gate[1] = 0;
            gate[2] = 1;
            gate[3] = 0;
        end  
        
        if(gate_num == 3) begin
            gate[0] = 0;
            gate[1] = 0;
            gate[2] = 0;
            gate[3] = 1;
        end   
        
    end
endmodule

module segment_clock(
    input clk_in,
    output reg clk_out
    );

reg [20:0] period_count = 0;
always @ (posedge clk_in)
    if (period_count!= 1000000)
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