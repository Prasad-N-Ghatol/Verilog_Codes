/*
--------------------------------------------------
Module :
--------------------------------------------------
Barrel_Shifter_16_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16-Bit Barrel Shifter.

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
module Barrel_Shifter_16_Bit (
    input         Enable_In,             // Enable the output of the Barrel Shifter
    
    input  [2:0]  Shift_Operation_In,    // Select the operation to be performed

    input  [3:0]  Shift_Bits_Length_In,  // Specify the number of bits to be shifted
    input         Carry_In,              // For the purpose of Shift through Carry
    input  [15:0] Data_In,               // Data to be shifted

    output [15:0] Shifted_Data_Out,      // Shifted data out
    output        Carry_Out              // Shifted Carry out
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
reg [16:0] Shift_Rotate_Bits_8;
reg [16:0] Shift_Rotate_Bits_4;
reg [16:0] Shift_Rotate_Bits_2;
reg [16:0] Shift_Rotate_Bits_1;



// --------------------------------------------------
// Assignment
// --------------------------------------------------
assign Shifted_Data_Out = Enable_In ? Shift_Rotate_Bits_1[15:0] : 16'bZ;
assign Carry_Out        = Enable_In ? Shift_Rotate_Bits_1[16]   : 1'bZ;



// --------------------------------------------------
// Barrel_Shifter_16_Bit Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Shift_Operation_In)
            LOGICAL_SHIFT_LEFT         : // 3'h0
                begin
                    Shift_Rotate_Bits_8[16] <= 1'b0;
                    Shift_Rotate_Bits_4[16] <= 1'b0;
                    Shift_Rotate_Bits_2[16] <= 1'b0;
                    Shift_Rotate_Bits_1[16] <= 1'b0;
                    
                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Data_In[0] : Data_In[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Data_In[1] : Data_In[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Data_In[2] : Data_In[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Data_In[3] : Data_In[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Data_In[4] : Data_In[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Data_In[5] : Data_In[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Data_In[6] : Data_In[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Data_In[7] : Data_In[15];

                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0]  <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[0];
                    Shift_Rotate_Bits_4[1]  <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[1];
                    Shift_Rotate_Bits_4[2]  <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[2];
                    Shift_Rotate_Bits_4[3]  <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[3];
                    Shift_Rotate_Bits_4[4]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[0]  : Shift_Rotate_Bits_8[4];
                    Shift_Rotate_Bits_4[5]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[1]  : Shift_Rotate_Bits_8[5];
                    Shift_Rotate_Bits_4[6]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[2]  : Shift_Rotate_Bits_8[6];
                    Shift_Rotate_Bits_4[7]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[3]  : Shift_Rotate_Bits_8[7];
                    Shift_Rotate_Bits_4[8]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[4]  : Shift_Rotate_Bits_8[8];
                    Shift_Rotate_Bits_4[9]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[5]  : Shift_Rotate_Bits_8[9];
                    Shift_Rotate_Bits_4[10] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[6]  : Shift_Rotate_Bits_8[10];
                    Shift_Rotate_Bits_4[11] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[7]  : Shift_Rotate_Bits_8[11];
                    Shift_Rotate_Bits_4[12] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[8]  : Shift_Rotate_Bits_8[12];
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[9]  : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[10] : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[11] : Shift_Rotate_Bits_8[15];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0]  <= Shift_Bits_Length_In[1] ? 1'b0                    : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1]  <= Shift_Bits_Length_In[1] ? 1'b0                    : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0]  : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1]  : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2]  : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3]  : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4]  : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5]  : Shift_Rotate_Bits_4[7];
                    Shift_Rotate_Bits_2[8]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6]  : Shift_Rotate_Bits_4[8];
                    Shift_Rotate_Bits_2[9]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7]  : Shift_Rotate_Bits_4[9];
                    Shift_Rotate_Bits_2[10] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[8]  : Shift_Rotate_Bits_4[10];
                    Shift_Rotate_Bits_2[11] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[9]  : Shift_Rotate_Bits_4[11];
                    Shift_Rotate_Bits_2[12] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[10] : Shift_Rotate_Bits_4[12];
                    Shift_Rotate_Bits_2[13] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[11] : Shift_Rotate_Bits_4[13];
                    Shift_Rotate_Bits_2[14] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[12] : Shift_Rotate_Bits_4[14];
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[13] : Shift_Rotate_Bits_4[15];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0]  <= Shift_Bits_Length_In[0] ? 1'b0                    : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0]  : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1]  : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2]  : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3]  : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4]  : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5]  : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6]  : Shift_Rotate_Bits_2[7];
                    Shift_Rotate_Bits_1[8]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7]  : Shift_Rotate_Bits_2[8];
                    Shift_Rotate_Bits_1[9]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[8]  : Shift_Rotate_Bits_2[9];
                    Shift_Rotate_Bits_1[10] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[9]  : Shift_Rotate_Bits_2[10];
                    Shift_Rotate_Bits_1[11] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[10] : Shift_Rotate_Bits_2[11];
                    Shift_Rotate_Bits_1[12] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[11] : Shift_Rotate_Bits_2[12];
                    Shift_Rotate_Bits_1[13] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[12] : Shift_Rotate_Bits_2[13];
                    Shift_Rotate_Bits_1[14] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[13] : Shift_Rotate_Bits_2[14];
                    Shift_Rotate_Bits_1[15] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[14] : Shift_Rotate_Bits_2[15];
                end

            LOGICAL_SHIFT_RIGHT        : // 3'h1
                begin
                    Shift_Rotate_Bits_8[16] <= 1'b0;
                    Shift_Rotate_Bits_4[16] <= 1'b0;
                    Shift_Rotate_Bits_2[16] <= 1'b0;
                    Shift_Rotate_Bits_1[16] <= 1'b0;
                    
                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Data_In[8]  : Data_In[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Data_In[9]  : Data_In[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Data_In[10] : Data_In[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Data_In[11] : Data_In[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Data_In[12] : Data_In[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Data_In[13] : Data_In[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Data_In[14] : Data_In[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? 1'b0        : Data_In[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? 1'b0        : Data_In[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? 1'b0        : Data_In[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? 1'b0        : Data_In[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? 1'b0        : Data_In[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? 1'b0        : Data_In[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? 1'b0        : Data_In[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? 1'b0        : Data_In[15];

                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[4]  : Shift_Rotate_Bits_8[0];
                    Shift_Rotate_Bits_4[1]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[5]  : Shift_Rotate_Bits_8[1];
                    Shift_Rotate_Bits_4[2]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[6]  : Shift_Rotate_Bits_8[2];
                    Shift_Rotate_Bits_4[3]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[7]  : Shift_Rotate_Bits_8[3];
                    Shift_Rotate_Bits_4[4]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[8]  : Shift_Rotate_Bits_8[4];
                    Shift_Rotate_Bits_4[5]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[9]  : Shift_Rotate_Bits_8[5];
                    Shift_Rotate_Bits_4[6]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[10] : Shift_Rotate_Bits_8[6];
                    Shift_Rotate_Bits_4[7]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[11] : Shift_Rotate_Bits_8[7];
                    Shift_Rotate_Bits_4[8]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[12] : Shift_Rotate_Bits_8[8];
                    Shift_Rotate_Bits_4[9]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[13] : Shift_Rotate_Bits_8[9];
                    Shift_Rotate_Bits_4[10] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[14] : Shift_Rotate_Bits_8[10];
                    Shift_Rotate_Bits_4[11] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[15] : Shift_Rotate_Bits_8[11];
                    Shift_Rotate_Bits_4[12] <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[12];
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[15];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2]  : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3]  : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4]  : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5]  : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6]  : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7]  : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[8]  : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[9]  : Shift_Rotate_Bits_4[7];
                    Shift_Rotate_Bits_2[8]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[10] : Shift_Rotate_Bits_4[8];
                    Shift_Rotate_Bits_2[9]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[11] : Shift_Rotate_Bits_4[9];
                    Shift_Rotate_Bits_2[10] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[12] : Shift_Rotate_Bits_4[10];
                    Shift_Rotate_Bits_2[11] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[13] : Shift_Rotate_Bits_4[11];
                    Shift_Rotate_Bits_2[12] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[14] : Shift_Rotate_Bits_4[12];
                    Shift_Rotate_Bits_2[13] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[15] : Shift_Rotate_Bits_4[13];
                    Shift_Rotate_Bits_2[14] <= Shift_Bits_Length_In[1] ? 1'b0                    : Shift_Rotate_Bits_4[14];
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? 1'b0                    : Shift_Rotate_Bits_4[15];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1]  : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2]  : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3]  : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4]  : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5]  : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6]  : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7]  : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[8]  : Shift_Rotate_Bits_2[7];
                    Shift_Rotate_Bits_1[8]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[9]  : Shift_Rotate_Bits_2[8];
                    Shift_Rotate_Bits_1[9]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[10] : Shift_Rotate_Bits_2[9];
                    Shift_Rotate_Bits_1[10] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[11] : Shift_Rotate_Bits_2[10];
                    Shift_Rotate_Bits_1[11] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[12] : Shift_Rotate_Bits_2[11];
                    Shift_Rotate_Bits_1[12] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[13] : Shift_Rotate_Bits_2[12];
                    Shift_Rotate_Bits_1[13] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[14] : Shift_Rotate_Bits_2[13];
                    Shift_Rotate_Bits_1[14] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[15] : Shift_Rotate_Bits_2[14];
                    Shift_Rotate_Bits_1[15] <= Shift_Bits_Length_In[0] ? 1'b0                    : Shift_Rotate_Bits_2[15];
                end

            ARITHMETIC_SHIFT_LEFT      : // 3'h2
                begin
                    Shift_Rotate_Bits_8[16] <= 1'b0;
                    Shift_Rotate_Bits_4[16] <= 1'b0;
                    Shift_Rotate_Bits_2[16] <= 1'b0;
                    Shift_Rotate_Bits_1[16] <= 1'b0;
                    
                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? 1'b0       : Data_In[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Data_In[0] : Data_In[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Data_In[1] : Data_In[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Data_In[2] : Data_In[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Data_In[3] : Data_In[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Data_In[4] : Data_In[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Data_In[5] : Data_In[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Data_In[6] : Data_In[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Data_In[7] : Data_In[15];

                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0]  <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[0];
                    Shift_Rotate_Bits_4[1]  <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[1];
                    Shift_Rotate_Bits_4[2]  <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[2];
                    Shift_Rotate_Bits_4[3]  <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[3];
                    Shift_Rotate_Bits_4[4]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[0]  : Shift_Rotate_Bits_8[4];
                    Shift_Rotate_Bits_4[5]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[1]  : Shift_Rotate_Bits_8[5];
                    Shift_Rotate_Bits_4[6]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[2]  : Shift_Rotate_Bits_8[6];
                    Shift_Rotate_Bits_4[7]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[3]  : Shift_Rotate_Bits_8[7];
                    Shift_Rotate_Bits_4[8]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[4]  : Shift_Rotate_Bits_8[8];
                    Shift_Rotate_Bits_4[9]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[5]  : Shift_Rotate_Bits_8[9];
                    Shift_Rotate_Bits_4[10] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[6]  : Shift_Rotate_Bits_8[10];
                    Shift_Rotate_Bits_4[11] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[7]  : Shift_Rotate_Bits_8[11];
                    Shift_Rotate_Bits_4[12] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[8]  : Shift_Rotate_Bits_8[12];
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[9]  : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[10] : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[11] : Shift_Rotate_Bits_8[15];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0]  <= Shift_Bits_Length_In[1] ? 1'b0                    : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1]  <= Shift_Bits_Length_In[1] ? 1'b0                    : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0]  : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1]  : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2]  : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3]  : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4]  : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5]  : Shift_Rotate_Bits_4[7];
                    Shift_Rotate_Bits_2[8]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6]  : Shift_Rotate_Bits_4[8];
                    Shift_Rotate_Bits_2[9]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7]  : Shift_Rotate_Bits_4[9];
                    Shift_Rotate_Bits_2[10] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[8]  : Shift_Rotate_Bits_4[10];
                    Shift_Rotate_Bits_2[11] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[9]  : Shift_Rotate_Bits_4[11];
                    Shift_Rotate_Bits_2[12] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[10] : Shift_Rotate_Bits_4[12];
                    Shift_Rotate_Bits_2[13] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[11] : Shift_Rotate_Bits_4[13];
                    Shift_Rotate_Bits_2[14] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[12] : Shift_Rotate_Bits_4[14];
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[13] : Shift_Rotate_Bits_4[15];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0]  <= Shift_Bits_Length_In[0] ? 1'b0                    : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0]  : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1]  : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2]  : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3]  : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4]  : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5]  : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6]  : Shift_Rotate_Bits_2[7];
                    Shift_Rotate_Bits_1[8]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7]  : Shift_Rotate_Bits_2[8];
                    Shift_Rotate_Bits_1[9]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[8]  : Shift_Rotate_Bits_2[9];
                    Shift_Rotate_Bits_1[10] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[9]  : Shift_Rotate_Bits_2[10];
                    Shift_Rotate_Bits_1[11] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[10] : Shift_Rotate_Bits_2[11];
                    Shift_Rotate_Bits_1[12] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[11] : Shift_Rotate_Bits_2[12];
                    Shift_Rotate_Bits_1[13] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[12] : Shift_Rotate_Bits_2[13];
                    Shift_Rotate_Bits_1[14] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[13] : Shift_Rotate_Bits_2[14];
                    Shift_Rotate_Bits_1[15] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[14] : Shift_Rotate_Bits_2[15];
                end

            ARITHMETIC_SHIFT_RIGHT     : // 3'h3
                begin
                    Shift_Rotate_Bits_8[16] <= 1'b0;
                    Shift_Rotate_Bits_4[16] <= 1'b0;
                    Shift_Rotate_Bits_2[16] <= 1'b0;
                    Shift_Rotate_Bits_1[16] <= 1'b0;
                    
                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Data_In[8]  : Data_In[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Data_In[9]  : Data_In[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Data_In[10] : Data_In[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Data_In[11] : Data_In[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Data_In[12] : Data_In[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Data_In[13] : Data_In[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Data_In[14] : Data_In[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[15];

                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[4]  : Shift_Rotate_Bits_8[0];
                    Shift_Rotate_Bits_4[1]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[5]  : Shift_Rotate_Bits_8[1];
                    Shift_Rotate_Bits_4[2]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[6]  : Shift_Rotate_Bits_8[2];
                    Shift_Rotate_Bits_4[3]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[7]  : Shift_Rotate_Bits_8[3];
                    Shift_Rotate_Bits_4[4]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[8]  : Shift_Rotate_Bits_8[4];
                    Shift_Rotate_Bits_4[5]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[9]  : Shift_Rotate_Bits_8[5];
                    Shift_Rotate_Bits_4[6]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[10] : Shift_Rotate_Bits_8[6];
                    Shift_Rotate_Bits_4[7]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[11] : Shift_Rotate_Bits_8[7];
                    Shift_Rotate_Bits_4[8]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[12] : Shift_Rotate_Bits_8[8];
                    Shift_Rotate_Bits_4[9]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[13] : Shift_Rotate_Bits_8[9];
                    Shift_Rotate_Bits_4[10] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[14] : Shift_Rotate_Bits_8[10];
                    Shift_Rotate_Bits_4[11] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[15] : Shift_Rotate_Bits_8[11];
                    Shift_Rotate_Bits_4[12] <= Shift_Bits_Length_In[2] ? Data_In[15]             : Shift_Rotate_Bits_8[12];
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? Data_In[15]             : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? Data_In[15]             : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? Data_In[15]             : Shift_Rotate_Bits_8[15];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2]  : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3]  : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4]  : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5]  : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6]  : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7]  : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[8]  : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[9]  : Shift_Rotate_Bits_4[7];
                    Shift_Rotate_Bits_2[8]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[10] : Shift_Rotate_Bits_4[8];
                    Shift_Rotate_Bits_2[9]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[11] : Shift_Rotate_Bits_4[9];
                    Shift_Rotate_Bits_2[10] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[12] : Shift_Rotate_Bits_4[10];
                    Shift_Rotate_Bits_2[11] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[13] : Shift_Rotate_Bits_4[11];
                    Shift_Rotate_Bits_2[12] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[14] : Shift_Rotate_Bits_4[12];
                    Shift_Rotate_Bits_2[13] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[15] : Shift_Rotate_Bits_4[13];
                    Shift_Rotate_Bits_2[14] <= Shift_Bits_Length_In[1] ? Data_In[15]             : Shift_Rotate_Bits_4[14];
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? Data_In[15]             : Shift_Rotate_Bits_4[15];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1]  : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2]  : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3]  : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4]  : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5]  : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6]  : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7]  : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[8]  : Shift_Rotate_Bits_2[7];
                    Shift_Rotate_Bits_1[8]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[9]  : Shift_Rotate_Bits_2[8];
                    Shift_Rotate_Bits_1[9]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[10] : Shift_Rotate_Bits_2[9];
                    Shift_Rotate_Bits_1[10] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[11] : Shift_Rotate_Bits_2[10];
                    Shift_Rotate_Bits_1[11] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[12] : Shift_Rotate_Bits_2[11];
                    Shift_Rotate_Bits_1[12] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[13] : Shift_Rotate_Bits_2[12];
                    Shift_Rotate_Bits_1[13] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[14] : Shift_Rotate_Bits_2[13];
                    Shift_Rotate_Bits_1[14] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[15] : Shift_Rotate_Bits_2[14];
                    Shift_Rotate_Bits_1[15] <= Shift_Bits_Length_In[0] ? Data_In[15]             : Shift_Rotate_Bits_2[15];
                end

            ROTATE_LEFT                : // 3'h4
                begin
                    Shift_Rotate_Bits_8[16] <= 1'b0;
                    Shift_Rotate_Bits_4[16] <= 1'b0;
                    Shift_Rotate_Bits_2[16] <= 1'b0;
                    Shift_Rotate_Bits_1[16] <= 1'b0;
                    
                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Data_In[8]  : Data_In[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Data_In[9]  : Data_In[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Data_In[10] : Data_In[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Data_In[11] : Data_In[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Data_In[12] : Data_In[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Data_In[13] : Data_In[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Data_In[14] : Data_In[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Data_In[0]  : Data_In[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Data_In[1]  : Data_In[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Data_In[2]  : Data_In[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Data_In[3]  : Data_In[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Data_In[4]  : Data_In[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Data_In[5]  : Data_In[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Data_In[6]  : Data_In[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Data_In[7]  : Data_In[15];

                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[12] : Shift_Rotate_Bits_8[0];
                    Shift_Rotate_Bits_4[1]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[13] : Shift_Rotate_Bits_8[1];
                    Shift_Rotate_Bits_4[2]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[14] : Shift_Rotate_Bits_8[2];
                    Shift_Rotate_Bits_4[3]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[15] : Shift_Rotate_Bits_8[3];
                    Shift_Rotate_Bits_4[4]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[0]  : Shift_Rotate_Bits_8[4];
                    Shift_Rotate_Bits_4[5]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[1]  : Shift_Rotate_Bits_8[5];
                    Shift_Rotate_Bits_4[6]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[2]  : Shift_Rotate_Bits_8[6];
                    Shift_Rotate_Bits_4[7]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[3]  : Shift_Rotate_Bits_8[7];
                    Shift_Rotate_Bits_4[8]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[4]  : Shift_Rotate_Bits_8[8];
                    Shift_Rotate_Bits_4[9]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[5]  : Shift_Rotate_Bits_8[9];
                    Shift_Rotate_Bits_4[10] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[6]  : Shift_Rotate_Bits_8[10];
                    Shift_Rotate_Bits_4[11] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[7]  : Shift_Rotate_Bits_8[11];
                    Shift_Rotate_Bits_4[12] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[8]  : Shift_Rotate_Bits_8[12];
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[9]  : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[10] : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[11] : Shift_Rotate_Bits_8[15];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[14] : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[15] : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0]  : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1]  : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2]  : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3]  : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4]  : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5]  : Shift_Rotate_Bits_4[7];
                    Shift_Rotate_Bits_2[8]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6]  : Shift_Rotate_Bits_4[8];
                    Shift_Rotate_Bits_2[9]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7]  : Shift_Rotate_Bits_4[9];
                    Shift_Rotate_Bits_2[10] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[8]  : Shift_Rotate_Bits_4[10];
                    Shift_Rotate_Bits_2[11] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[9]  : Shift_Rotate_Bits_4[11];
                    Shift_Rotate_Bits_2[12] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[10] : Shift_Rotate_Bits_4[12];
                    Shift_Rotate_Bits_2[13] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[11] : Shift_Rotate_Bits_4[13];
                    Shift_Rotate_Bits_2[14] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[12] : Shift_Rotate_Bits_4[14];
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[13] : Shift_Rotate_Bits_4[15];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[15] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0]  : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1]  : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2]  : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3]  : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4]  : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5]  : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6]  : Shift_Rotate_Bits_2[7];
                    Shift_Rotate_Bits_1[8]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7]  : Shift_Rotate_Bits_2[8];
                    Shift_Rotate_Bits_1[9]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[8]  : Shift_Rotate_Bits_2[9];
                    Shift_Rotate_Bits_1[10] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[9]  : Shift_Rotate_Bits_2[10];
                    Shift_Rotate_Bits_1[11] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[10] : Shift_Rotate_Bits_2[11];
                    Shift_Rotate_Bits_1[12] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[11] : Shift_Rotate_Bits_2[12];
                    Shift_Rotate_Bits_1[13] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[12] : Shift_Rotate_Bits_2[13];
                    Shift_Rotate_Bits_1[14] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[13] : Shift_Rotate_Bits_2[14];
                    Shift_Rotate_Bits_1[15] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[14] : Shift_Rotate_Bits_2[15];
                end

            ROTATE_RIGHT               : // 3'h5
                begin
                    Shift_Rotate_Bits_8[16] <= 1'b0;
                    Shift_Rotate_Bits_4[16] <= 1'b0;
                    Shift_Rotate_Bits_2[16] <= 1'b0;
                    Shift_Rotate_Bits_1[16] <= 1'b0;
                    
                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Data_In[8]  : Data_In[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Data_In[9]  : Data_In[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Data_In[10] : Data_In[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Data_In[11] : Data_In[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Data_In[12] : Data_In[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Data_In[13] : Data_In[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Data_In[14] : Data_In[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Data_In[0]  : Data_In[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Data_In[1]  : Data_In[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Data_In[2]  : Data_In[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Data_In[3]  : Data_In[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Data_In[4]  : Data_In[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Data_In[5]  : Data_In[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Data_In[6]  : Data_In[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Data_In[7]  : Data_In[15];

                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[4]  : Shift_Rotate_Bits_8[0];
                    Shift_Rotate_Bits_4[1]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[5]  : Shift_Rotate_Bits_8[1];
                    Shift_Rotate_Bits_4[2]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[6]  : Shift_Rotate_Bits_8[2];
                    Shift_Rotate_Bits_4[3]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[7]  : Shift_Rotate_Bits_8[3];
                    Shift_Rotate_Bits_4[4]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[8]  : Shift_Rotate_Bits_8[4];
                    Shift_Rotate_Bits_4[5]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[9]  : Shift_Rotate_Bits_8[5];
                    Shift_Rotate_Bits_4[6]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[10] : Shift_Rotate_Bits_8[6];
                    Shift_Rotate_Bits_4[7]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[11] : Shift_Rotate_Bits_8[7];
                    Shift_Rotate_Bits_4[8]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[12] : Shift_Rotate_Bits_8[8];
                    Shift_Rotate_Bits_4[9]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[13] : Shift_Rotate_Bits_8[9];
                    Shift_Rotate_Bits_4[10] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[14] : Shift_Rotate_Bits_8[10];
                    Shift_Rotate_Bits_4[11] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[15] : Shift_Rotate_Bits_8[11];
                    Shift_Rotate_Bits_4[12] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[0]  : Shift_Rotate_Bits_8[12];
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[1]  : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[2]  : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[3]  : Shift_Rotate_Bits_8[15];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2]  : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3]  : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4]  : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5]  : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6]  : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7]  : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[8]  : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[9]  : Shift_Rotate_Bits_4[7];
                    Shift_Rotate_Bits_2[8]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[10] : Shift_Rotate_Bits_4[8];
                    Shift_Rotate_Bits_2[9]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[11] : Shift_Rotate_Bits_4[9];
                    Shift_Rotate_Bits_2[10] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[12] : Shift_Rotate_Bits_4[10];
                    Shift_Rotate_Bits_2[11] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[13] : Shift_Rotate_Bits_4[11];
                    Shift_Rotate_Bits_2[12] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[14] : Shift_Rotate_Bits_4[12];
                    Shift_Rotate_Bits_2[13] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[15] : Shift_Rotate_Bits_4[13];
                    Shift_Rotate_Bits_2[14] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0]  : Shift_Rotate_Bits_4[14];
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1]  : Shift_Rotate_Bits_4[15];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1]  : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2]  : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3]  : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4]  : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5]  : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6]  : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7]  : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[8]  : Shift_Rotate_Bits_2[7];
                    Shift_Rotate_Bits_1[8]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[9]  : Shift_Rotate_Bits_2[8];
                    Shift_Rotate_Bits_1[9]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[10] : Shift_Rotate_Bits_2[9];
                    Shift_Rotate_Bits_1[10] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[11] : Shift_Rotate_Bits_2[10];
                    Shift_Rotate_Bits_1[11] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[12] : Shift_Rotate_Bits_2[11];
                    Shift_Rotate_Bits_1[12] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[13] : Shift_Rotate_Bits_2[12];
                    Shift_Rotate_Bits_1[13] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[14] : Shift_Rotate_Bits_2[13];
                    Shift_Rotate_Bits_1[14] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[15] : Shift_Rotate_Bits_2[14];
                    Shift_Rotate_Bits_1[15] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0]  : Shift_Rotate_Bits_2[15];
                end

            ROTATE_LEFT_THROUGH_CARRY  : // 3'h6
                begin
                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Data_In[9]  : Data_In[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Data_In[10] : Data_In[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Data_In[11] : Data_In[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Data_In[12] : Data_In[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Data_In[13] : Data_In[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Data_In[14] : Data_In[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Carry_In    : Data_In[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Data_In[0]  : Data_In[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Data_In[1]  : Data_In[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Data_In[2]  : Data_In[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Data_In[3]  : Data_In[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Data_In[4]  : Data_In[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Data_In[5]  : Data_In[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Data_In[6]  : Data_In[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Data_In[7]  : Data_In[15];
                    Shift_Rotate_Bits_8[16] <= Shift_Bits_Length_In[3] ? Data_In[8]  : Carry_In;

                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[13] : Shift_Rotate_Bits_8[0];
                    Shift_Rotate_Bits_4[1]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[14] : Shift_Rotate_Bits_8[1];
                    Shift_Rotate_Bits_4[2]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[15] : Shift_Rotate_Bits_8[2];
                    Shift_Rotate_Bits_4[3]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[16] : Shift_Rotate_Bits_8[3];
                    Shift_Rotate_Bits_4[4]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[0]  : Shift_Rotate_Bits_8[4];
                    Shift_Rotate_Bits_4[5]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[1]  : Shift_Rotate_Bits_8[5];
                    Shift_Rotate_Bits_4[6]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[2]  : Shift_Rotate_Bits_8[6];
                    Shift_Rotate_Bits_4[7]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[3]  : Shift_Rotate_Bits_8[7];
                    Shift_Rotate_Bits_4[8]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[4]  : Shift_Rotate_Bits_8[8];
                    Shift_Rotate_Bits_4[9]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[5]  : Shift_Rotate_Bits_8[9];
                    Shift_Rotate_Bits_4[10] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[6]  : Shift_Rotate_Bits_8[10];
                    Shift_Rotate_Bits_4[11] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[7]  : Shift_Rotate_Bits_8[11];
                    Shift_Rotate_Bits_4[12] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[8]  : Shift_Rotate_Bits_8[12];
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[9]  : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[10] : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[11] : Shift_Rotate_Bits_8[15];
                    Shift_Rotate_Bits_4[16] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[12] : Shift_Rotate_Bits_8[16];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[15] : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[16] : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0]  : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1]  : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2]  : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3]  : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4]  : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5]  : Shift_Rotate_Bits_4[7];
                    Shift_Rotate_Bits_2[8]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6]  : Shift_Rotate_Bits_4[8];
                    Shift_Rotate_Bits_2[9]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7]  : Shift_Rotate_Bits_4[9];
                    Shift_Rotate_Bits_2[10] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[8]  : Shift_Rotate_Bits_4[10];
                    Shift_Rotate_Bits_2[11] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[9]  : Shift_Rotate_Bits_4[11];
                    Shift_Rotate_Bits_2[12] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[10] : Shift_Rotate_Bits_4[12];
                    Shift_Rotate_Bits_2[13] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[11] : Shift_Rotate_Bits_4[13];
                    Shift_Rotate_Bits_2[14] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[12] : Shift_Rotate_Bits_4[14];
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[13] : Shift_Rotate_Bits_4[15];
                    Shift_Rotate_Bits_2[16] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[14] : Shift_Rotate_Bits_4[16];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[16] : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0]  : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1]  : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2]  : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3]  : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4]  : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5]  : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6]  : Shift_Rotate_Bits_2[7];
                    Shift_Rotate_Bits_1[8]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7]  : Shift_Rotate_Bits_2[8];
                    Shift_Rotate_Bits_1[9]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[8]  : Shift_Rotate_Bits_2[9];
                    Shift_Rotate_Bits_1[10] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[9]  : Shift_Rotate_Bits_2[10];
                    Shift_Rotate_Bits_1[11] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[10] : Shift_Rotate_Bits_2[11];
                    Shift_Rotate_Bits_1[12] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[11] : Shift_Rotate_Bits_2[12];
                    Shift_Rotate_Bits_1[13] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[12] : Shift_Rotate_Bits_2[13];
                    Shift_Rotate_Bits_1[14] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[13] : Shift_Rotate_Bits_2[14];
                    Shift_Rotate_Bits_1[15] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[14] : Shift_Rotate_Bits_2[15];
                    Shift_Rotate_Bits_1[16] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[15] : Shift_Rotate_Bits_2[16];
                end

            ROTATE_RIGHT_THROUGH_CARRY : // 3'h7
                begin
                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Data_In[8]  : Data_In[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Data_In[9]  : Data_In[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Data_In[10] : Data_In[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Data_In[11] : Data_In[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Data_In[12] : Data_In[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Data_In[13] : Data_In[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Data_In[14] : Data_In[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Data_In[15] : Data_In[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Carry_In    : Data_In[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Data_In[0]  : Data_In[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Data_In[1]  : Data_In[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Data_In[2]  : Data_In[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Data_In[3]  : Data_In[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Data_In[4]  : Data_In[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Data_In[5]  : Data_In[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Data_In[6]  : Data_In[15];
                    Shift_Rotate_Bits_8[16] <= Shift_Bits_Length_In[3] ? Data_In[7]  : Carry_In;

                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[4]  : Shift_Rotate_Bits_8[0];
                    Shift_Rotate_Bits_4[1]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[5]  : Shift_Rotate_Bits_8[1];
                    Shift_Rotate_Bits_4[2]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[6]  : Shift_Rotate_Bits_8[2];
                    Shift_Rotate_Bits_4[3]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[7]  : Shift_Rotate_Bits_8[3];
                    Shift_Rotate_Bits_4[4]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[8]  : Shift_Rotate_Bits_8[4];
                    Shift_Rotate_Bits_4[5]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[9]  : Shift_Rotate_Bits_8[5];
                    Shift_Rotate_Bits_4[6]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[10] : Shift_Rotate_Bits_8[6];
                    Shift_Rotate_Bits_4[7]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[11] : Shift_Rotate_Bits_8[7];
                    Shift_Rotate_Bits_4[8]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[12] : Shift_Rotate_Bits_8[8];
                    Shift_Rotate_Bits_4[9]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[13] : Shift_Rotate_Bits_8[9];
                    Shift_Rotate_Bits_4[10] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[14] : Shift_Rotate_Bits_8[10];
                    Shift_Rotate_Bits_4[11] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[15] : Shift_Rotate_Bits_8[11];
                    Shift_Rotate_Bits_4[12] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[16] : Shift_Rotate_Bits_8[12];
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[0]  : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[1]  : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[2]  : Shift_Rotate_Bits_8[15];
                    Shift_Rotate_Bits_4[16] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[3]  : Shift_Rotate_Bits_8[16];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[2]  : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[3]  : Shift_Rotate_Bits_4[1];
                    Shift_Rotate_Bits_2[2]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[4]  : Shift_Rotate_Bits_4[2];
                    Shift_Rotate_Bits_2[3]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[5]  : Shift_Rotate_Bits_4[3];
                    Shift_Rotate_Bits_2[4]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[6]  : Shift_Rotate_Bits_4[4];
                    Shift_Rotate_Bits_2[5]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[7]  : Shift_Rotate_Bits_4[5];
                    Shift_Rotate_Bits_2[6]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[8]  : Shift_Rotate_Bits_4[6];
                    Shift_Rotate_Bits_2[7]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[9]  : Shift_Rotate_Bits_4[7];
                    Shift_Rotate_Bits_2[8]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[10] : Shift_Rotate_Bits_4[8];
                    Shift_Rotate_Bits_2[9]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[11] : Shift_Rotate_Bits_4[9];
                    Shift_Rotate_Bits_2[10] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[12] : Shift_Rotate_Bits_4[10];
                    Shift_Rotate_Bits_2[11] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[13] : Shift_Rotate_Bits_4[11];
                    Shift_Rotate_Bits_2[12] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[14] : Shift_Rotate_Bits_4[12];
                    Shift_Rotate_Bits_2[13] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[15] : Shift_Rotate_Bits_4[13];
                    Shift_Rotate_Bits_2[14] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[16] : Shift_Rotate_Bits_4[14];
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0]  : Shift_Rotate_Bits_4[15];
                    Shift_Rotate_Bits_2[16] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1]  : Shift_Rotate_Bits_4[16];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[1]  : Shift_Rotate_Bits_2[0];
                    Shift_Rotate_Bits_1[1]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[2]  : Shift_Rotate_Bits_2[1];
                    Shift_Rotate_Bits_1[2]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[3]  : Shift_Rotate_Bits_2[2];
                    Shift_Rotate_Bits_1[3]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[4]  : Shift_Rotate_Bits_2[3];
                    Shift_Rotate_Bits_1[4]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[5]  : Shift_Rotate_Bits_2[4];
                    Shift_Rotate_Bits_1[5]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[6]  : Shift_Rotate_Bits_2[5];
                    Shift_Rotate_Bits_1[6]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[7]  : Shift_Rotate_Bits_2[6];
                    Shift_Rotate_Bits_1[7]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[8]  : Shift_Rotate_Bits_2[7];
                    Shift_Rotate_Bits_1[8]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[9]  : Shift_Rotate_Bits_2[8];
                    Shift_Rotate_Bits_1[9]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[10] : Shift_Rotate_Bits_2[9];
                    Shift_Rotate_Bits_1[10] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[11] : Shift_Rotate_Bits_2[10];
                    Shift_Rotate_Bits_1[11] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[12] : Shift_Rotate_Bits_2[11];
                    Shift_Rotate_Bits_1[12] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[13] : Shift_Rotate_Bits_2[12];
                    Shift_Rotate_Bits_1[13] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[14] : Shift_Rotate_Bits_2[13];
                    Shift_Rotate_Bits_1[14] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[15] : Shift_Rotate_Bits_2[14];
                    Shift_Rotate_Bits_1[15] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[16] : Shift_Rotate_Bits_2[15];
                    Shift_Rotate_Bits_1[16] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0]  : Shift_Rotate_Bits_2[16];
                end
    
            default: 
                begin
                    Shift_Rotate_Bits_8 <= 17'b0;
                    Shift_Rotate_Bits_4 <= 17'b0;
                    Shift_Rotate_Bits_2 <= 17'b0;
                    Shift_Rotate_Bits_1 <= 17'b0;
                end
        endcase
    end



endmodule
