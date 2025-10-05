`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input CLOCK,
    input SW4,
    output [7:0] JA
    );
    
    wire clk_6p25mhz, clk_25mhz, clk_10hz;
    reg [15:0] oled_data = 16'h07E0;
    
    wire dummy_fb, dummy_sp, dummy_spx;
    wire [12:0] pixel_index;
    
    flexible_clock u1 (.clk_in (CLOCK), .max (1), .new_clk (clk_25mhz));
    flexible_clock u2 (.clk_in (CLOCK), .max (7), .new_clk (clk_6p25mhz));    
    flexible_clock u3 (.clk_in (CLOCK), .max (4_999_999), .new_clk (clk_10hz));
    
    Oled_Display (
        .clk (clk_6p25mhz),
        .reset(0),
        .pixel_data(oled_data),
        .cs (JA[0]),
        .sdin (JA[1]),
        .sclk (JA[3]),
        .d_cn (JA[4]),
        .resn (JA[5]),
        .vccen (JA[6]),
        .pmoden (JA[7]),
        .frame_begin (dummy_fb), .sending_pixels (dummy_sp), .sample_pixel (dummy_spx),
        .pixel_index (pixel_index)
        );
        
        wire [6:0] x;
        wire [5:0] y;
        assign x = pixel_index % 96;
        assign y = pixel_index / 96;
        
        reg [6:0] x_var_left = 10;
        reg [6:0] x_var_right = 20;
        
        always @ (posedge clk_25mhz)
        begin
            // oled_data <= (SW4) ? 16'hF800 : 16'h07E0; // red : green
            if (x >= x_var_left && x <= x_var_right && y >= 10 && y <= 60) begin
                oled_data <= 16'hF800;
            end else begin
                oled_data <= 16'h07E0;
            end
        end
        
        always @ (posedge clk_10hz)
        begin
            x_var_left <= x_var_left + 1;
            x_var_right <= x_var_right + 1;
        end

endmodule