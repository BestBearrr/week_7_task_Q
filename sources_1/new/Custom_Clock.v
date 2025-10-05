`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 12:20:59
// Design Name: 
// Module Name: Custom_Clock
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


module Custom_Clock(
    input clk,
    input [31:0] max,
    output reg new_clk = 0
    );
    
    reg [31:0] count = 0;
    
    always @ (posedge clk) begin
        count <= (count == max) ? 0 : count + 1;
        new_clk <= (count == 0 ) ? ~new_clk : new_clk;
    end
endmodule
