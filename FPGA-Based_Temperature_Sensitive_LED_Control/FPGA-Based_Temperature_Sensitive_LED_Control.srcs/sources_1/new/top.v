`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2024 07:40:00 PM
// Design Name: 
// Module Name: top
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


module top(
    input         CLK100MHZ,        // nexys clk signal
    input         reset,            // btnC on nexys
    input [12:0]  TMP_SWTCH,        //Temperature value from Switches
    input         SELECT,           //To select temperature from sensor or switches SELECT=1,data from switches
    inout         TMP_SDA,          // i2c sda on temp sensor - bidirectional
    output        TMP_SCL,          // i2c scl on temp sensor
    output [6:0]  SEG,              // 7 segments of each display
    output [7:0]  AN,               // 8 anodes of 8 displays
    output dp,                      // Decimal point of only 5th segment is ON 
    output [15:0]  LED ,            // nexys leds = binary temp in deg C
    output R,                       //for TRI-COLOR LED
    output G,                       //for TRI-COLOR LED
    output B                       //for TRI-COLOR LED
   
    
    );
    
    wire sda_dir;                   // direction of SDA signal - to or from master
    wire w_200kHz;                  // 200kHz SCL
    reg [15:0] w_data;              // 8 bits of temperature data
    wire [15:0] temperature;        // 8 bits of temperature data from temperature sensor


    // Instantiate i2c master
    i2c_master master(
        .clk_200kHz(w_200kHz),
        .reset(reset),
        .temp_data(temperature),
        .SDA(TMP_SDA),
        .SDA_dir(sda_dir),
        .SCL(TMP_SCL)
    );
    
    always@(posedge CLK100MHZ)

        begin
            if (SELECT==1) w_data<=(TMP_SWTCH<<3);
            else w_data<=temperature;
        end

    // Instantiate 200kHz clock generator
    clkgen_200kHz cgen(
        .clk_100MHz(CLK100MHZ),
        .clk_200kHz(w_200kHz)
    );
    
    // Instantiate 7 segment control
    seg_Dsplay seg_instance(.clk_100MHz(CLK100MHZ),
        .temp_data(w_data),
        .SEG(SEG),
        .AN(AN),
        .dp(dp));
    // Set LED value to temp data
    assign LED = w_data;
    
    // Instantiate Tri-Color Led Color and Intensity Control
    tri_color tri_instance(
        .clk_100MHz(CLK100MHZ),    
        .temp_data(w_data),  
        .R(R), 
        .G(G), 
        .B(B)
  
    );

endmodule