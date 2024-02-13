`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2024 07:20:00 PM
// Design Name: 
// Module Name: seg_Dsplay
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


module seg_Dsplay(
    input clk_100MHz,                      // Nexys A7 clock
    input [15:0] temp_data,                // Temp data from i2c master
    output reg [6:0] SEG,                  // 7 Segments of Displays
    output reg [7:0] AN,                   //Anodes
    output reg dp                          //Decimal point

    );
    
    reg [3:0] first;  // first seven segment
    reg [3:0] second; //second seven segment
    reg [3:0] third; //third seven segment
    reg [3:0] fourth; // fourth seven segment
    reg [3:0] fifth; //fifth seven segment
    reg [3:0] sixth; //sixth seven segment
    reg [3:0] seventh; //seventh seven segment
    
    reg [4:0] seg;      
    reg [17:0] Counter=0;
    reg [12:0] temperature;
    
    
always@(posedge clk_100MHz)  
begin
    Counter<=Counter+1;
end
    
always @ (*)
begin
    case(seg)
    0 : SEG = 7'b1000000; //0
    1 : SEG = 7'b1111001; //1
    2 : SEG = 7'b0100100; //2
    3 : SEG = 7'b0110000; //3
    4 : SEG = 7'b0011001; //4
    5 : SEG = 7'b0010010; //5
    6 : SEG = 7'b0000010; //6
    7 : SEG = 7'b1111000; //7
    8 : SEG = 7'b0000000; //8
    9 : SEG = 7'b0011000; //9
    10: SEG = 7'b0001000; //A
    11: SEG = 7'b0000011; //B
    12: SEG = 7'b1000110; //C
    13: SEG = 7'b0100001; //D
    14: SEG = 7'b0000110; //E
    15: SEG = 7'b0111111; //-
    16: SEG = 7'b0001110; //F
    default: SEG =7'b1000000;//0
    endcase
    //conerting from 9 digit binary to decimal value 
    // Starting at 8 degrees.

//Working on the decimal point values.
    temperature<=temp_data[15:3];
    if (temp_data[15]==1) //For negative temperature
        begin
	       temperature<=(~((temp_data[15:3])))+1;
	       seventh = 5'b01111;
	       sixth = (temperature[12:4] / 10);           // Tens value of temp data
           fifth = (temperature[12:4] % 10); 
    end
    
    else //For positive temperature
        begin
            seventh = 5'b00000;
            sixth = temperature[12:4] / 10;           // Tens value of temp data
            fifth = temperature[12:4] % 10; 
        end

case (temperature[3:0])

4'b0000: begin first  <= 5'b00000;
               second <= 5'b00000;
               third  <= 5'b00000;
               fourth <= 5'b00000;end
4'b0001: begin first  <= 5'b00101;
               second <= 5'b00010;
               third  <= 5'b00110;
               fourth <= 5'b00000;end
4'b0010: begin first  <= 5'b00000;
               second <= 5'b00101;
               third  <= 5'b00010;
               fourth <= 5'b00001;end
4'b0011: begin first  <= 5'b00101;
               second <= 5'b00111;
               third  <= 5'b01000;
               fourth <= 5'b00001;end
4'b0100: begin first  <= 5'b00000;
               second <= 5'b00000;
               third  <= 5'b00101;
               fourth <= 5'b00010;end
4'b0101: begin first  <= 5'b00101;
               second <= 5'b00010;
               third  <= 5'b00001;
               fourth <= 5'b00011;end
4'b0110: begin first  <= 5'b00000;
               second <= 5'b00101;
               third  <= 5'b00111;
               fourth <= 5'b00011;end
4'b0111: begin first  <= 5'b00101;
               second <= 5'b00111;
               third  <= 5'b00011;
               fourth <= 5'b00100;end
4'b1000: begin first  <= 5'b00000;
               second <= 5'b00000;
               third  <= 5'b00000;
               fourth <= 5'b00101;end               
4'b1001: begin first  <= 5'b00101;
               second <= 5'b00010;
               third  <= 5'b00110;
               fourth <= 5'b00101;end
4'b1010: begin first  <= 5'b00000;
               second <= 5'b00101;
               third  <= 5'b00010;
               fourth <= 5'b00110;end
4'b1011: begin first  <= 5'b00101;
               second <= 5'b00111;
               third  <= 5'b01000;
               fourth <= 5'b00110;end
4'b1100: begin first  <= 5'b00000;
               second <= 5'b00000;
               third  <= 5'b00101;
               fourth <= 5'b00111;end
4'b1101: begin first  <= 5'b00101;
               second <= 5'b00010;
               third  <= 5'b00001;
               fourth <= 5'b01000;end
4'b1110: begin first  <= 5'b00000;
               second <= 5'b00101;
               third  <= 5'b00111;
               fourth <= 5'b01000;end
4'b1111: begin first  <= 5'b00101;
               second <= 5'b00111;
               third  <= 5'b00011;
               fourth <= 5'b01001;end
default: begin first  <= 5'b00000;
               second <= 5'b00000;
               third  <= 5'b00000;
               fourth <= 5'b00000;end
   endcase


end 
    
always @ (*)
begin
 
    case (Counter[17:15])
    
    3'b000: begin
                seg <= first;
                AN <= 8'b11111110;
                dp <= 1'b1;
            end
    3'b001: begin
                seg <= second;
                AN <= 8'b11111101;
                dp <= 1'b1;
            end
    3'b010: begin
                seg <= third;
                AN <= 8'b11111011;
                dp <= 1'b1;
            end
    3'b011: begin
                seg <= fourth;
                AN <= 8'b11110111;
                dp <= 1'b1;
            end
    3'b100: begin
                seg <= fifth;
                AN <= 8'b11101111;
                dp <= 1'b0;
           end
    3'b101: begin
                seg <= sixth;
                AN <= 8'b11011111;
                dp <= 1'b1;
           end
    3'b110: begin
                seg <= seventh;
                AN <= 8'b10111111;
                dp <= 1'b1;
           end
    default: begin AN <=8'b11111111; dp <= 1'b1;end
   
    endcase
end

endmodule
