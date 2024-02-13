`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2024 07:50:00 PM
// Design Name: 
// Module Name: test_bench
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


module test_bench;
    reg         CLK100MHZ;      // nexys clk signal
    reg  [12:0]  TMP_SWTCH;     //Temperature value from Switches
    reg         SELECT;         //To select temperature from sensor or switches SELECT=1,data from switches
    wire R;                     //for TRI-COLOR LED
    wire G;                     //for TRI-COLOR LED
    wire B;                     //for TRI-COLOR LED
  

 top uut(.CLK100MHZ(CLK100MHZ),
    .TMP_SWTCH(TMP_SWTCH),
    .SELECT(SELECT),
    .R(R),
    .G(G),
    .B(B)
   );


always #0.1 CLK100MHZ = ~CLK100MHZ;

initial begin

CLK100MHZ = 0;

//reading from temperature sensor
//SELECT = 0;

//reading from switch
#100;
SELECT =1;
TMP_SWTCH = 13'b0000110110000; //red low temperature=27(432)
SELECT =1;
#100;
TMP_SWTCH = 13'b0000011000000; //green low temperature=12(192)

#100;
TMP_SWTCH = 13'b0000001010000; //blue low temperature=5(80)

#100;
TMP_SWTCH = 13'b0001000110000; //red medium temperature=35(560)

#100;
TMP_SWTCH = 13'b0001100000000; //red high temperature=48(768)

#100;
TMP_SWTCH = 13'b0000110000000; //green high temperature=24(384)


#100;
TMP_SWTCH = 13'b1111001110000; //blue high temperature=-25 (7792)


#100;

end
endmodule
