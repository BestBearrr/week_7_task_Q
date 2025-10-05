`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2025 16:53:07
// Design Name: 
// Module Name: Task_Q_Hongxun
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


module Task_Q_Hongxun(
    input clk, btnC, btnL, btnR, btnU, // btnU for reset OLED
    output [7:0] JC
    );
    
    wire clk_6p25mhz, clk_1khz;
    Custom_Clock u1 (.clk(clk), .max(7), .new_clk(clk_6p25mhz));
    Custom_Clock u2 (.clk(clk), .max(49999), .new_clk(clk_1khz));
    
    // OLED
    wire [12:0] pixel_index;
    wire frame_begin, sending_pixels, sample_pixel;
    wire [15:0] oled_data; // Output data
    
    wire [6:0] px; 
    wire [5:0] py;
    assign px = pixel_index % 96;
    assign py = pixel_index / 96;
    
    Oled_Display uDisplay(
          .clk(clk_6p25mhz), .reset(btnU), 
          .frame_begin(frame_begin), .sending_pixels(sending_pixels),
          .sample_pixel(sample_pixel), 
          .pixel_index(pixel_index), .pixel_data(oled_data), 
          .cs(JC[0]), .sdin(JC[1]), .sclk(JC[3]), .d_cn(JC[4]), .resn(JC[5]), .vccen(JC[6]), .pmoden(JC[7])
          );
    
    task_Q_controller u_task_Q_controller(
        .clk_1khz(clk_1khz), .clk_6p25mhz(clk_6p25mhz),
        .btnL(btnL), .btnC(btnC), .btnR(btnR),
        .px(px), .py(py), .oled_data(oled_data)
        );

endmodule
