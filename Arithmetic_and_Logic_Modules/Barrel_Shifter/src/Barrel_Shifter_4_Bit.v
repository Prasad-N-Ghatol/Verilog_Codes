/*
--------------------------------------------------
Module :
--------------------------------------------------
Barrel_Shifter_4_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 4-Bit Barrel Shifter.

The shifting is performed on the Data_In, with the shifted result present on Shifted_Data_Out.
For the purpose of shifting the data through the Carry, Carry_In is also applied, whose shifted value
is present at output Carry_Out.

Shift_Bits_Length_In specifies the number of bits to be shifted.

A total of 8 operations are available for this design, and can be selected with the Shift_Operation_In.
The available operation, with their selection values are :
    3'h0 -> LOGICAL_SHIFT_LEFT
    3'h1 -> LOGICAL_SHIFT_RIGHT
    3'h2 -> ARITHMETIC_SHIFT_LEFT
    3'h3 -> ARITHMETIC_SHIFT_RIGHT
    3'h4 -> ROTATE_LEFT
    3'h5 -> ROTATE_RIGHT
    3'h6 -> ROTATE_LEFT_THROUGH_CARRY
    3'h7 -> ROTATE_RIGHT_THROUGH_CARRY


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Barrel_Shifter_4_Bit (
    input        Enable_In,             // Enable the output of the Barrel Shifter

    input  [2:0] Shift_Operation_In,    // Select the operation to be performed

    input  [1:0] Shift_Bits_Length_In,  // Specify the number of bits to be shifted
    input        Carry_In,              // For the purpose of Shift through Carry
    input  [3:0] Data_In,               // Data to be shifted

    output [3:0] Shifted_Data_Out,      // Shifted data out
    output       Carry_Out              // Shifted Carry out
);



// --------------------------------------------------
// Constants
// --------------------------------------------------
localparam [2:0]    LOGICAL_SHIFT_LEFT         = 3'h0,
                    LOGICAL_SHIFT_RIGHT        = 3'h1,
                    ARITHMETIC_SHIFT_LEFT      = 3'h2,
                    ARITHMETIC_SHIFT_RIGHT     = 3'h3,
                    ROTATE_LEFT                = 3'h4,
                    ROTATE_RIGHT               = 3'h5,
                    ROTATE_LEFT_THROUGH_CARRY  = 3'h6,
                    ROTATE_RIGHT_THROUGH_CARRY = 3'h7;



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg [4:0] Shift_Rotate_Bits_2 = 5'b0;
reg [4:0] Shift_Rotate_Bits_1 = 5'b0;



// --------------------------------------------------
// Assignment
// --------------------------------------------------
assign Shifted_Data_Out = Enable_In ? Shift_Rotate_Bits_1[3:0] : 4'bZ;
assign Carry_Out        = Enable_In ? Shift_Rotate_Bits_1[4]   : 1'bZ;



// --------------------------------------------------
// Barrel_Shifter_4_Bit Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Shift_Operation_In)
            LOGICAL_SHIFT_LEFT         : // 3'h0
                begin
                    Shift_Rotate_Bits_2[4] <= 1'b0;
                    Shift_Rotate_Bits_1[4] <= 1'b0;
                    
                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? 1'b0       : Data_In[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? 1'b0       : Data_In[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Data_In[0] : Data_In[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Data_In[1] : Data_In[3];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? 1'b0                   : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[3];
                end

            LOGICAL_SHIFT_RIGHT        : // 3'h1
                begin
                    Shift_Rotate_Bits_2[4] <= 1'b0;
                    Shift_Rotate_Bits_1[4] <= 1'b0;
                    
                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Data_In[2] : Data_In[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Data_In[3] : Data_In[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? 1'b0       : Data_In[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? 1'b0       : Data_In[3];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? 1'b0                   : Shift_Rotate_Bits_2[3];
                end

            ARITHMETIC_SHIFT_LEFT      : // 3'h2
                begin
                    Shift_Rotate_Bits_2[4] <= 1'b0;
                    Shift_Rotate_Bits_1[4] <= 1'b0;
                    
                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? 1'b0       : Data_In[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? 1'b0       : Data_In[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Data_In[0] : Data_In[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Data_In[1] : Data_In[3];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? 1'b0                   : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[3];
                end

            ARITHMETIC_SHIFT_RIGHT     : // 3'h3
                begin
                    Shift_Rotate_Bits_2[4] <= 1'b0;
                    Shift_Rotate_Bits_1[4] <= 1'b0;
                    
                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Data_In[2] : Data_In[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Data_In[3] : Data_In[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Data_In[3] : Data_In[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Data_In[3] : Data_In[3];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Data_In[3]             : Shift_Rotate_Bits_2[3];
                end

            ROTATE_LEFT                : // 3'h4
                begin
                    Shift_Rotate_Bits_2[4] <= 1'b0;
                    Shift_Rotate_Bits_1[4] <= 1'b0;
                    
                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Data_In[2] : Data_In[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Data_In[3] : Data_In[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Data_In[0] : Data_In[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Data_In[1] : Data_In[3];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[3];
                end

            ROTATE_RIGHT               : // 3'h5
                begin
                    Shift_Rotate_Bits_2[4] <= 1'b0;
                    Shift_Rotate_Bits_1[4] <= 1'b0;
                    
                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Data_In[2] : Data_In[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Data_In[3] : Data_In[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Data_In[0] : Data_In[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Data_In[1] : Data_In[3];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[3];
                end

            ROTATE_LEFT_THROUGH_CARRY  : // 3'h6
                begin
                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Data_In[3] : Data_In[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Carry_In   : Data_In[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Data_In[0] : Data_In[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Data_In[1] : Data_In[3];
                    Shift_Rotate_Bits_2[4] <= Shift_Bits_Length_In[1] ? Data_In[2] : Carry_In;

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[4];
                end

            ROTATE_RIGHT_THROUGH_CARRY : // 3'h7
                begin
                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0] <= Shift_Bits_Length_In[1] ? Data_In[2] : Data_In[0];
                    Shift_Rotate_Bits_2[1] <= Shift_Bits_Length_In[1] ? Data_In[3] : Data_In[1];
                    Shift_Rotate_Bits_2[2] <= Shift_Bits_Length_In[1] ? Carry_In   : Data_In[2];
                    Shift_Rotate_Bits_2[3] <= Shift_Bits_Length_In[1] ? Data_In[0] : Data_In[3];
                    Shift_Rotate_Bits_2[4] <= Shift_Bits_Length_In[1] ? Data_In[1] : Carry_In;

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2] : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3] : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4] : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0] : Shift_Rotate_Bits_2[4];
                end
    
            default: 
                begin
                    Shift_Rotate_Bits_2 <= 5'b0;
                    Shift_Rotate_Bits_1 <= 5'b0;
                end
        endcase
    end



endmodule
