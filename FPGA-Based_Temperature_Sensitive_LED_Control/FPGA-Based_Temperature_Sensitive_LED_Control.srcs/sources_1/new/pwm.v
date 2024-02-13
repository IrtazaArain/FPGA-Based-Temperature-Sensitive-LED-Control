`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2024 07:35:00 PM
// Design Name: 
// Module Name: pwm
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


module pwm(
    input clk_100MHz,
    output reg [7:0] pwm_count
    );
    reg [7:0] pwm_count=0;
    always @(posedge clk_100MHz )
    begin
    if (pwm_count < 100) pwm_count<=pwm_count+1; //count until 100
    else pwm_count <=0; //reset counter
    end
endmodule
