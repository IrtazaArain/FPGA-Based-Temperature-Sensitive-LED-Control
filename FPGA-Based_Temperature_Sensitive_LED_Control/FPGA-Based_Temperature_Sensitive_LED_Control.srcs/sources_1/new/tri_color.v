`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/10/2024 07:30:00 PM
// Design Name: 
// Module Name: tri_color
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


module tri_color(
    input clk_100MHz,           // Nexys A7 clock
    input [15:0] temp_data,  // 8 bits of temperature data
    output reg R, //for Tricolor LED
    output reg G, //for Tricolor LED
    output reg B //for Tricolor LED
    
    );
    
    //8 bit pwm counter
    wire [7:0] pwm_count;
    //3 bit RGB_Color
    reg [2:0] RGB_Color;
    //reg [12:0] temperature;
    reg signed [12:0] temperature;
    
    // Instantiate PWM module
    pwm p1(clk_100MHz,pwm_count);
    
    always @(posedge clk_100MHz)
    begin 

    if (temp_data[15]==1) //For negative temperature
        begin
            temperature<=(((temp_data[15:3])-8192)/16);
        end
    
    else                //For positive temperature
        begin
            temperature<=(temp_data[15:3])/16;
        end

    //For Color Coding and variation in Intensity
    if(-13'sd30<=temperature && temperature<=13'sd10) //For range of temperature [-30,10] Cold temperature with Blue color
        begin
            RGB_Color <= 3'b001; // blue
            if(-13'sd1<temperature && temperature<=13'sd10) //Low intensity for temperature(-1,10]
                begin
                    if (pwm_count<10)  //10% duty cycle
                        begin
                            R<= RGB_Color[2];
                            G<= RGB_Color[1];
                            B<= RGB_Color[0];
                        end
                    else
                        begin
                            R<=0;
                            G<=0;
                            B<=0;
                        end
                end
            else if (-13'sd20<temperature && temperature<=-13'sd1) //Medium intensity for temperature(-20,-1]
                begin
                    if (pwm_count< 50) //50% duty cycle
                        begin
                            R<= RGB_Color[2];
                            G<= RGB_Color[1];
                            B<= RGB_Color[0];
                        end
                    else
                        begin
                            R<=0;
                            G<=0;
                            B<=0;
                        end  
                end
            else if(-13'sd30<=temperature && temperature<=-13'sd20) //High intensity for temperature [-30,-20]
                begin
                    if (pwm_count<90)  //90% duty cycle
                        begin
                            R<= RGB_Color[2];
                            G<= RGB_Color[1];
                            B<= RGB_Color[0];
                        end
                    else
                        begin
                            R<=0;
                            G<=0;
                            B<=0;
                        end
            end 
                else
                     begin
                     end
                end
    else if(10<temperature && temperature<=26) //For range of temperature (10,26] Normal temperature with Green color
        begin
            RGB_Color <= 3'b010; // Green
            if(10<temperature && temperature<=15) //Low intensity for temperature (10,15]
                begin
                    if (pwm_count<10) //10% duty cycle
                        begin
                            R<= RGB_Color[2];
                            G<= RGB_Color[1];
                            B<= RGB_Color[0];
                        end
                    else 
                        begin
                            R<=0;
                            G<=0;
                            B<=0;
                        end
                end
            else if (15<temperature && temperature<=20) //Medium intensity for temperature (15,20]
                begin
                    if (pwm_count<50) //50% duty cycle
                        begin
                            R<= RGB_Color[2];
                            G<= RGB_Color[1];
                            B<= RGB_Color[0];
                        end
                    else
                        begin
                            R<=0;
                            G<=0;
                            B<=0;
                        end
                end
            else if(20<temperature && temperature<=26)//High intensity for temperature (20,26]
                begin
                    if (pwm_count<90) //90% duty cycle
                        begin
                            R<= RGB_Color[2];
                            G<= RGB_Color[1];
                            B<= RGB_Color[0];
                        end
                    else 
                        begin
                            R<=0;
                            G<=0;
                            B<=0;
                        end          
                end
            else
                begin
                end
        end
    else if(26<temperature && temperature<=55) //For range of temperature (26,55] Hot temperature with Red color
        begin
            RGB_Color <= 3'b100; // Red
            if(26<temperature && temperature<=28) //Low intensity for temperature (26,28]
                begin
                    if (pwm_count<10) //10% duty cycle
                        begin
                            R<= RGB_Color[2];
                            G<= RGB_Color[1];
                            B<= RGB_Color[0];
                        end
                    else
                        begin
                            R<=0;
                            G<=0;
                            B<=0;
                        end
                end
            else if (28<temperature && temperature<=46) //Medium intensity for temperature (28,46]
                begin
                    if (pwm_count<50) //50% duty cycle
                        begin
                            R<= RGB_Color[2];
                            G<= RGB_Color[1];
                            B<= RGB_Color[0];
                        end
                    else
                        begin
                            R<=0;
                            G<=0;
                            B<=0;
                        end   
                end
            else if (46<temperature && temperature<=55) //High intensity for temperature (46,55]
                begin
                if (pwm_count<90)//90% duty cycle
                    begin
                        R<= RGB_Color[2];
                        G<= RGB_Color[1];
                        B<= RGB_Color[0];
                    end
                else
                    begin
                        R<=0;
                        G<=0;
                        B<=0;
                    end       
                end
            else
                begin
                end
        end           
    else
        begin
            R<=0;
            G<=0;
            B<=0;
       end      
end
endmodule