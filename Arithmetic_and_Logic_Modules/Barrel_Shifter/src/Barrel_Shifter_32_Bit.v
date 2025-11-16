/*
--------------------------------------------------
Module :
--------------------------------------------------
Barrel_Shifter_32_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 32-Bit Barrel Shifter.

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
module Barrel_Shifter_32_Bit (
    input         Enable_In,             // Enable the output of the Barrel Shifter
    
    input  [2:0]  Shift_Operation_In,    // Select the operation to be performed

    input  [4:0]  Shift_Bits_Length_In,  // Specify the number of bits to be shifted
    input         Carry_In,              // For the purpose of Shift through Carry
    input  [31:0] Data_In,               // Data to be shifted

    output [31:0] Shifted_Data_Out,      // Shifted data out
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
reg [32:0] Shift_Rotate_Bits_16;
reg [32:0] Shift_Rotate_Bits_8;
reg [32:0] Shift_Rotate_Bits_4;
reg [32:0] Shift_Rotate_Bits_2;
reg [32:0] Shift_Rotate_Bits_1;



// --------------------------------------------------
// Assignment
// --------------------------------------------------
assign Shifted_Data_Out = Enable_In ? Shift_Rotate_Bits_1[31:0] : 32'bZ;
assign Carry_Out        = Enable_In ? Shift_Rotate_Bits_1[32]   : 1'bZ;



// --------------------------------------------------
// Barrel_Shifter_32_Bit Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Shift_Operation_In)
            LOGICAL_SHIFT_LEFT         : // 3'h0
                begin
                    Shift_Rotate_Bits_16[32] <= 1'b0;
                    Shift_Rotate_Bits_8[32]  <= 1'b0;
                    Shift_Rotate_Bits_4[32]  <= 1'b0;
                    Shift_Rotate_Bits_2[32]  <= 1'b0;
                    Shift_Rotate_Bits_1[32]  <= 1'b0;
                    
                    // Shift 16-Bits
                    Shift_Rotate_Bits_16[0]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[0];
                    Shift_Rotate_Bits_16[1]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[1];
                    Shift_Rotate_Bits_16[2]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[2];
                    Shift_Rotate_Bits_16[3]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[3];
                    Shift_Rotate_Bits_16[4]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[4];
                    Shift_Rotate_Bits_16[5]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[5];
                    Shift_Rotate_Bits_16[6]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[6];
                    Shift_Rotate_Bits_16[7]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[7];
                    Shift_Rotate_Bits_16[8]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[8];
                    Shift_Rotate_Bits_16[9]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[9];
                    Shift_Rotate_Bits_16[10] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[10];
                    Shift_Rotate_Bits_16[11] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[11];
                    Shift_Rotate_Bits_16[12] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[12];
                    Shift_Rotate_Bits_16[13] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[13];
                    Shift_Rotate_Bits_16[14] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[14];
                    Shift_Rotate_Bits_16[15] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[15];
                    Shift_Rotate_Bits_16[16] <= Shift_Bits_Length_In[4] ? Data_In[0]  : Data_In[16];
                    Shift_Rotate_Bits_16[17] <= Shift_Bits_Length_In[4] ? Data_In[1]  : Data_In[17];
                    Shift_Rotate_Bits_16[18] <= Shift_Bits_Length_In[4] ? Data_In[2]  : Data_In[18];
                    Shift_Rotate_Bits_16[19] <= Shift_Bits_Length_In[4] ? Data_In[3]  : Data_In[19];
                    Shift_Rotate_Bits_16[20] <= Shift_Bits_Length_In[4] ? Data_In[4]  : Data_In[20];
                    Shift_Rotate_Bits_16[21] <= Shift_Bits_Length_In[4] ? Data_In[5]  : Data_In[21];
                    Shift_Rotate_Bits_16[22] <= Shift_Bits_Length_In[4] ? Data_In[6]  : Data_In[22];
                    Shift_Rotate_Bits_16[23] <= Shift_Bits_Length_In[4] ? Data_In[7]  : Data_In[23];
                    Shift_Rotate_Bits_16[24] <= Shift_Bits_Length_In[4] ? Data_In[8]  : Data_In[24];
                    Shift_Rotate_Bits_16[25] <= Shift_Bits_Length_In[4] ? Data_In[9]  : Data_In[25];
                    Shift_Rotate_Bits_16[26] <= Shift_Bits_Length_In[4] ? Data_In[10] : Data_In[26];
                    Shift_Rotate_Bits_16[27] <= Shift_Bits_Length_In[4] ? Data_In[11] : Data_In[27];
                    Shift_Rotate_Bits_16[28] <= Shift_Bits_Length_In[4] ? Data_In[12] : Data_In[28];
                    Shift_Rotate_Bits_16[29] <= Shift_Bits_Length_In[4] ? Data_In[13] : Data_In[29];
                    Shift_Rotate_Bits_16[30] <= Shift_Bits_Length_In[4] ? Data_In[14] : Data_In[30];
                    Shift_Rotate_Bits_16[31] <= Shift_Bits_Length_In[4] ? Data_In[15] : Data_In[31];

                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[0]  : Shift_Rotate_Bits_16[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[1]  : Shift_Rotate_Bits_16[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[2]  : Shift_Rotate_Bits_16[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[3]  : Shift_Rotate_Bits_16[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[4]  : Shift_Rotate_Bits_16[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[5]  : Shift_Rotate_Bits_16[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[6]  : Shift_Rotate_Bits_16[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[7]  : Shift_Rotate_Bits_16[15];
                    Shift_Rotate_Bits_8[16] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[8]  : Shift_Rotate_Bits_16[16];
                    Shift_Rotate_Bits_8[17] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[9]  : Shift_Rotate_Bits_16[17];
                    Shift_Rotate_Bits_8[18] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[10] : Shift_Rotate_Bits_16[18];
                    Shift_Rotate_Bits_8[19] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[11] : Shift_Rotate_Bits_16[19];
                    Shift_Rotate_Bits_8[20] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[12] : Shift_Rotate_Bits_16[20];
                    Shift_Rotate_Bits_8[21] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[13] : Shift_Rotate_Bits_16[21];
                    Shift_Rotate_Bits_8[22] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[14] : Shift_Rotate_Bits_16[22];
                    Shift_Rotate_Bits_8[23] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[15] : Shift_Rotate_Bits_16[23];
                    Shift_Rotate_Bits_8[24] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[16] : Shift_Rotate_Bits_16[24];
                    Shift_Rotate_Bits_8[25] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[17] : Shift_Rotate_Bits_16[25];
                    Shift_Rotate_Bits_8[26] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[18] : Shift_Rotate_Bits_16[26];
                    Shift_Rotate_Bits_8[27] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[19] : Shift_Rotate_Bits_16[27];
                    Shift_Rotate_Bits_8[28] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[20] : Shift_Rotate_Bits_16[28];
                    Shift_Rotate_Bits_8[29] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[21] : Shift_Rotate_Bits_16[29];
                    Shift_Rotate_Bits_8[30] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[22] : Shift_Rotate_Bits_16[30];
                    Shift_Rotate_Bits_8[31] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[23] : Shift_Rotate_Bits_16[31];

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
                    Shift_Rotate_Bits_4[16] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[12] : Shift_Rotate_Bits_8[16];
                    Shift_Rotate_Bits_4[17] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[13] : Shift_Rotate_Bits_8[17];
                    Shift_Rotate_Bits_4[18] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[14] : Shift_Rotate_Bits_8[18];
                    Shift_Rotate_Bits_4[19] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[15] : Shift_Rotate_Bits_8[19];
                    Shift_Rotate_Bits_4[20] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[16] : Shift_Rotate_Bits_8[20];
                    Shift_Rotate_Bits_4[21] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[17] : Shift_Rotate_Bits_8[21];
                    Shift_Rotate_Bits_4[22] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[18] : Shift_Rotate_Bits_8[22];
                    Shift_Rotate_Bits_4[23] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[19] : Shift_Rotate_Bits_8[23];
                    Shift_Rotate_Bits_4[24] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[20] : Shift_Rotate_Bits_8[24];
                    Shift_Rotate_Bits_4[25] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[21] : Shift_Rotate_Bits_8[25];
                    Shift_Rotate_Bits_4[26] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[22] : Shift_Rotate_Bits_8[26];
                    Shift_Rotate_Bits_4[27] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[23] : Shift_Rotate_Bits_8[27];
                    Shift_Rotate_Bits_4[28] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[24] : Shift_Rotate_Bits_8[28];
                    Shift_Rotate_Bits_4[29] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[25] : Shift_Rotate_Bits_8[29];
                    Shift_Rotate_Bits_4[30] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[26] : Shift_Rotate_Bits_8[30];
                    Shift_Rotate_Bits_4[31] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[27] : Shift_Rotate_Bits_8[31];

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
                    Shift_Rotate_Bits_2[16] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[14] : Shift_Rotate_Bits_4[16];
                    Shift_Rotate_Bits_2[17] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[15] : Shift_Rotate_Bits_4[17];
                    Shift_Rotate_Bits_2[18] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[16] : Shift_Rotate_Bits_4[18];
                    Shift_Rotate_Bits_2[19] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[17] : Shift_Rotate_Bits_4[19];
                    Shift_Rotate_Bits_2[20] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[18] : Shift_Rotate_Bits_4[20];
                    Shift_Rotate_Bits_2[21] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[19] : Shift_Rotate_Bits_4[21];
                    Shift_Rotate_Bits_2[22] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[20] : Shift_Rotate_Bits_4[22];
                    Shift_Rotate_Bits_2[23] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[21] : Shift_Rotate_Bits_4[23];
                    Shift_Rotate_Bits_2[24] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[22] : Shift_Rotate_Bits_4[24];
                    Shift_Rotate_Bits_2[25] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[23] : Shift_Rotate_Bits_4[25];
                    Shift_Rotate_Bits_2[26] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[24] : Shift_Rotate_Bits_4[26];
                    Shift_Rotate_Bits_2[27] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[25] : Shift_Rotate_Bits_4[27];
                    Shift_Rotate_Bits_2[28] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[26] : Shift_Rotate_Bits_4[28];
                    Shift_Rotate_Bits_2[29] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[27] : Shift_Rotate_Bits_4[29];
                    Shift_Rotate_Bits_2[30] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[28] : Shift_Rotate_Bits_4[30];
                    Shift_Rotate_Bits_2[31] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[29] : Shift_Rotate_Bits_4[31];

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
                    Shift_Rotate_Bits_1[16] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[15] : Shift_Rotate_Bits_2[16];
                    Shift_Rotate_Bits_1[17] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[16] : Shift_Rotate_Bits_2[17];
                    Shift_Rotate_Bits_1[18] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[17] : Shift_Rotate_Bits_2[18];
                    Shift_Rotate_Bits_1[19] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[18] : Shift_Rotate_Bits_2[19];
                    Shift_Rotate_Bits_1[20] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[19] : Shift_Rotate_Bits_2[20];
                    Shift_Rotate_Bits_1[21] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[20] : Shift_Rotate_Bits_2[21];
                    Shift_Rotate_Bits_1[22] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[21] : Shift_Rotate_Bits_2[22];
                    Shift_Rotate_Bits_1[23] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[22] : Shift_Rotate_Bits_2[23];
                    Shift_Rotate_Bits_1[24] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[23] : Shift_Rotate_Bits_2[24];
                    Shift_Rotate_Bits_1[25] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[24] : Shift_Rotate_Bits_2[25];
                    Shift_Rotate_Bits_1[26] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[25] : Shift_Rotate_Bits_2[26];
                    Shift_Rotate_Bits_1[27] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[26] : Shift_Rotate_Bits_2[27];
                    Shift_Rotate_Bits_1[28] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[27] : Shift_Rotate_Bits_2[28];
                    Shift_Rotate_Bits_1[29] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[28] : Shift_Rotate_Bits_2[29];
                    Shift_Rotate_Bits_1[30] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[29] : Shift_Rotate_Bits_2[30];
                    Shift_Rotate_Bits_1[31] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[30] : Shift_Rotate_Bits_2[31];
                end

            LOGICAL_SHIFT_RIGHT        : // 3'h1
                begin
                    Shift_Rotate_Bits_16[32] <= 1'b0;
                    Shift_Rotate_Bits_8[32]  <= 1'b0;
                    Shift_Rotate_Bits_4[32]  <= 1'b0;
                    Shift_Rotate_Bits_2[32]  <= 1'b0;
                    Shift_Rotate_Bits_1[32]  <= 1'b0;
                    
                    // Shift 16-Bits
                    Shift_Rotate_Bits_16[0]  <= Shift_Bits_Length_In[4] ? Data_In[16] : Data_In[0];
                    Shift_Rotate_Bits_16[1]  <= Shift_Bits_Length_In[4] ? Data_In[17] : Data_In[1];
                    Shift_Rotate_Bits_16[2]  <= Shift_Bits_Length_In[4] ? Data_In[18] : Data_In[2];
                    Shift_Rotate_Bits_16[3]  <= Shift_Bits_Length_In[4] ? Data_In[19] : Data_In[3];
                    Shift_Rotate_Bits_16[4]  <= Shift_Bits_Length_In[4] ? Data_In[20] : Data_In[4];
                    Shift_Rotate_Bits_16[5]  <= Shift_Bits_Length_In[4] ? Data_In[21] : Data_In[5];
                    Shift_Rotate_Bits_16[6]  <= Shift_Bits_Length_In[4] ? Data_In[22] : Data_In[6];
                    Shift_Rotate_Bits_16[7]  <= Shift_Bits_Length_In[4] ? Data_In[23] : Data_In[7];
                    Shift_Rotate_Bits_16[8]  <= Shift_Bits_Length_In[4] ? Data_In[24] : Data_In[8];
                    Shift_Rotate_Bits_16[9]  <= Shift_Bits_Length_In[4] ? Data_In[25] : Data_In[9];
                    Shift_Rotate_Bits_16[10] <= Shift_Bits_Length_In[4] ? Data_In[26] : Data_In[10];
                    Shift_Rotate_Bits_16[11] <= Shift_Bits_Length_In[4] ? Data_In[27] : Data_In[11];
                    Shift_Rotate_Bits_16[12] <= Shift_Bits_Length_In[4] ? Data_In[28] : Data_In[12];
                    Shift_Rotate_Bits_16[13] <= Shift_Bits_Length_In[4] ? Data_In[29] : Data_In[13];
                    Shift_Rotate_Bits_16[14] <= Shift_Bits_Length_In[4] ? Data_In[30] : Data_In[14];
                    Shift_Rotate_Bits_16[15] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[15];
                    Shift_Rotate_Bits_16[16] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[16];
                    Shift_Rotate_Bits_16[17] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[17];
                    Shift_Rotate_Bits_16[18] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[18];
                    Shift_Rotate_Bits_16[19] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[19];
                    Shift_Rotate_Bits_16[20] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[20];
                    Shift_Rotate_Bits_16[21] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[21];
                    Shift_Rotate_Bits_16[22] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[22];
                    Shift_Rotate_Bits_16[23] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[23];
                    Shift_Rotate_Bits_16[24] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[24];
                    Shift_Rotate_Bits_16[25] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[25];
                    Shift_Rotate_Bits_16[26] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[26];
                    Shift_Rotate_Bits_16[27] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[27];
                    Shift_Rotate_Bits_16[28] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[28];
                    Shift_Rotate_Bits_16[29] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[29];
                    Shift_Rotate_Bits_16[30] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[30];
                    Shift_Rotate_Bits_16[31] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[31];

                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[8]  : Shift_Rotate_Bits_16[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[9]  : Shift_Rotate_Bits_16[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[10] : Shift_Rotate_Bits_16[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[11] : Shift_Rotate_Bits_16[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[12] : Shift_Rotate_Bits_16[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[13] : Shift_Rotate_Bits_16[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[14] : Shift_Rotate_Bits_16[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[15] : Shift_Rotate_Bits_16[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[16] : Shift_Rotate_Bits_16[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[17] : Shift_Rotate_Bits_16[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[18] : Shift_Rotate_Bits_16[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[19] : Shift_Rotate_Bits_16[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[20] : Shift_Rotate_Bits_16[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[21] : Shift_Rotate_Bits_16[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[22] : Shift_Rotate_Bits_16[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[23] : Shift_Rotate_Bits_16[15];
                    Shift_Rotate_Bits_8[16] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[24] : Shift_Rotate_Bits_16[16];
                    Shift_Rotate_Bits_8[17] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[25] : Shift_Rotate_Bits_16[17];
                    Shift_Rotate_Bits_8[18] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[26] : Shift_Rotate_Bits_16[18];
                    Shift_Rotate_Bits_8[19] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[27] : Shift_Rotate_Bits_16[19];
                    Shift_Rotate_Bits_8[20] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[28] : Shift_Rotate_Bits_16[20];
                    Shift_Rotate_Bits_8[21] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[29] : Shift_Rotate_Bits_16[21];
                    Shift_Rotate_Bits_8[22] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[30] : Shift_Rotate_Bits_16[22];
                    Shift_Rotate_Bits_8[23] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[31] : Shift_Rotate_Bits_16[23];
                    Shift_Rotate_Bits_8[24] <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[24];
                    Shift_Rotate_Bits_8[25] <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[25];
                    Shift_Rotate_Bits_8[26] <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[26];
                    Shift_Rotate_Bits_8[27] <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[27];
                    Shift_Rotate_Bits_8[28] <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[28];
                    Shift_Rotate_Bits_8[29] <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[29];
                    Shift_Rotate_Bits_8[30] <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[30];
                    Shift_Rotate_Bits_8[31] <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[31];

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
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[17] : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[18] : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[19] : Shift_Rotate_Bits_8[15];
                    Shift_Rotate_Bits_4[16] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[20] : Shift_Rotate_Bits_8[16];
                    Shift_Rotate_Bits_4[17] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[21] : Shift_Rotate_Bits_8[17];
                    Shift_Rotate_Bits_4[18] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[22] : Shift_Rotate_Bits_8[18];
                    Shift_Rotate_Bits_4[19] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[23] : Shift_Rotate_Bits_8[19];
                    Shift_Rotate_Bits_4[20] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[24] : Shift_Rotate_Bits_8[20];
                    Shift_Rotate_Bits_4[21] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[25] : Shift_Rotate_Bits_8[21];
                    Shift_Rotate_Bits_4[22] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[26] : Shift_Rotate_Bits_8[22];
                    Shift_Rotate_Bits_4[23] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[27] : Shift_Rotate_Bits_8[23];
                    Shift_Rotate_Bits_4[24] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[28] : Shift_Rotate_Bits_8[24];
                    Shift_Rotate_Bits_4[25] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[29] : Shift_Rotate_Bits_8[25];
                    Shift_Rotate_Bits_4[26] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[30] : Shift_Rotate_Bits_8[26];
                    Shift_Rotate_Bits_4[27] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[31] : Shift_Rotate_Bits_8[27];
                    Shift_Rotate_Bits_4[28] <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[28];
                    Shift_Rotate_Bits_4[29] <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[29];
                    Shift_Rotate_Bits_4[30] <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[30];
                    Shift_Rotate_Bits_4[31] <= Shift_Bits_Length_In[2] ? 1'b0                    : Shift_Rotate_Bits_8[31];

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
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[17] : Shift_Rotate_Bits_4[15];
                    Shift_Rotate_Bits_2[16] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[18] : Shift_Rotate_Bits_4[16];
                    Shift_Rotate_Bits_2[17] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[19] : Shift_Rotate_Bits_4[17];
                    Shift_Rotate_Bits_2[18] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[20] : Shift_Rotate_Bits_4[18];
                    Shift_Rotate_Bits_2[19] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[21] : Shift_Rotate_Bits_4[19];
                    Shift_Rotate_Bits_2[20] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[22] : Shift_Rotate_Bits_4[20];
                    Shift_Rotate_Bits_2[21] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[23] : Shift_Rotate_Bits_4[21];
                    Shift_Rotate_Bits_2[22] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[24] : Shift_Rotate_Bits_4[22];
                    Shift_Rotate_Bits_2[23] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[25] : Shift_Rotate_Bits_4[23];
                    Shift_Rotate_Bits_2[24] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[26] : Shift_Rotate_Bits_4[24];
                    Shift_Rotate_Bits_2[25] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[27] : Shift_Rotate_Bits_4[25];
                    Shift_Rotate_Bits_2[26] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[28] : Shift_Rotate_Bits_4[26];
                    Shift_Rotate_Bits_2[27] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[29] : Shift_Rotate_Bits_4[27];
                    Shift_Rotate_Bits_2[28] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[30] : Shift_Rotate_Bits_4[28];
                    Shift_Rotate_Bits_2[29] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[31] : Shift_Rotate_Bits_4[29];
                    Shift_Rotate_Bits_2[30] <= Shift_Bits_Length_In[1] ? 1'b0                    : Shift_Rotate_Bits_4[30];
                    Shift_Rotate_Bits_2[31] <= Shift_Bits_Length_In[1] ? 1'b0                    : Shift_Rotate_Bits_4[31];

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
                    Shift_Rotate_Bits_1[16] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[17] : Shift_Rotate_Bits_2[16];
                    Shift_Rotate_Bits_1[17] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[18] : Shift_Rotate_Bits_2[17];
                    Shift_Rotate_Bits_1[18] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[19] : Shift_Rotate_Bits_2[18];
                    Shift_Rotate_Bits_1[19] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[20] : Shift_Rotate_Bits_2[19];
                    Shift_Rotate_Bits_1[20] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[21] : Shift_Rotate_Bits_2[20];
                    Shift_Rotate_Bits_1[21] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[22] : Shift_Rotate_Bits_2[21];
                    Shift_Rotate_Bits_1[22] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[23] : Shift_Rotate_Bits_2[22];
                    Shift_Rotate_Bits_1[23] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[24] : Shift_Rotate_Bits_2[23];
                    Shift_Rotate_Bits_1[24] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[25] : Shift_Rotate_Bits_2[24];
                    Shift_Rotate_Bits_1[25] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[26] : Shift_Rotate_Bits_2[25];
                    Shift_Rotate_Bits_1[26] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[27] : Shift_Rotate_Bits_2[26];
                    Shift_Rotate_Bits_1[27] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[28] : Shift_Rotate_Bits_2[27];
                    Shift_Rotate_Bits_1[28] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[29] : Shift_Rotate_Bits_2[28];
                    Shift_Rotate_Bits_1[29] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[30] : Shift_Rotate_Bits_2[29];
                    Shift_Rotate_Bits_1[30] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[31] : Shift_Rotate_Bits_2[30];
                    Shift_Rotate_Bits_1[31] <= Shift_Bits_Length_In[0] ? 1'b0                    : Shift_Rotate_Bits_2[31];
                end

            ARITHMETIC_SHIFT_LEFT      : // 3'h2
                begin
                    Shift_Rotate_Bits_16[32] <= 1'b0;
                    Shift_Rotate_Bits_8[32]  <= 1'b0;
                    Shift_Rotate_Bits_4[32]  <= 1'b0;
                    Shift_Rotate_Bits_2[32]  <= 1'b0;
                    Shift_Rotate_Bits_1[32]  <= 1'b0;
                    
                    // Shift 16-Bits
                    Shift_Rotate_Bits_16[0]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[0];
                    Shift_Rotate_Bits_16[1]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[1];
                    Shift_Rotate_Bits_16[2]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[2];
                    Shift_Rotate_Bits_16[3]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[3];
                    Shift_Rotate_Bits_16[4]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[4];
                    Shift_Rotate_Bits_16[5]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[5];
                    Shift_Rotate_Bits_16[6]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[6];
                    Shift_Rotate_Bits_16[7]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[7];
                    Shift_Rotate_Bits_16[8]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[8];
                    Shift_Rotate_Bits_16[9]  <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[9];
                    Shift_Rotate_Bits_16[10] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[10];
                    Shift_Rotate_Bits_16[11] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[11];
                    Shift_Rotate_Bits_16[12] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[12];
                    Shift_Rotate_Bits_16[13] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[13];
                    Shift_Rotate_Bits_16[14] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[14];
                    Shift_Rotate_Bits_16[15] <= Shift_Bits_Length_In[4] ? 1'b0        : Data_In[15];
                    Shift_Rotate_Bits_16[16] <= Shift_Bits_Length_In[4] ? Data_In[0]  : Data_In[16];
                    Shift_Rotate_Bits_16[17] <= Shift_Bits_Length_In[4] ? Data_In[1]  : Data_In[17];
                    Shift_Rotate_Bits_16[18] <= Shift_Bits_Length_In[4] ? Data_In[2]  : Data_In[18];
                    Shift_Rotate_Bits_16[19] <= Shift_Bits_Length_In[4] ? Data_In[3]  : Data_In[19];
                    Shift_Rotate_Bits_16[20] <= Shift_Bits_Length_In[4] ? Data_In[4]  : Data_In[20];
                    Shift_Rotate_Bits_16[21] <= Shift_Bits_Length_In[4] ? Data_In[5]  : Data_In[21];
                    Shift_Rotate_Bits_16[22] <= Shift_Bits_Length_In[4] ? Data_In[6]  : Data_In[22];
                    Shift_Rotate_Bits_16[23] <= Shift_Bits_Length_In[4] ? Data_In[7]  : Data_In[23];
                    Shift_Rotate_Bits_16[24] <= Shift_Bits_Length_In[4] ? Data_In[8]  : Data_In[24];
                    Shift_Rotate_Bits_16[25] <= Shift_Bits_Length_In[4] ? Data_In[9]  : Data_In[25];
                    Shift_Rotate_Bits_16[26] <= Shift_Bits_Length_In[4] ? Data_In[10] : Data_In[26];
                    Shift_Rotate_Bits_16[27] <= Shift_Bits_Length_In[4] ? Data_In[11] : Data_In[27];
                    Shift_Rotate_Bits_16[28] <= Shift_Bits_Length_In[4] ? Data_In[12] : Data_In[28];
                    Shift_Rotate_Bits_16[29] <= Shift_Bits_Length_In[4] ? Data_In[13] : Data_In[29];
                    Shift_Rotate_Bits_16[30] <= Shift_Bits_Length_In[4] ? Data_In[14] : Data_In[30];
                    Shift_Rotate_Bits_16[31] <= Shift_Bits_Length_In[4] ? Data_In[15] : Data_In[31];

                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? 1'b0                     : Shift_Rotate_Bits_16[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[0]  : Shift_Rotate_Bits_16[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[1]  : Shift_Rotate_Bits_16[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[2]  : Shift_Rotate_Bits_16[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[3]  : Shift_Rotate_Bits_16[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[4]  : Shift_Rotate_Bits_16[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[5]  : Shift_Rotate_Bits_16[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[6]  : Shift_Rotate_Bits_16[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[7]  : Shift_Rotate_Bits_16[15];
                    Shift_Rotate_Bits_8[16] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[8]  : Shift_Rotate_Bits_16[16];
                    Shift_Rotate_Bits_8[17] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[9]  : Shift_Rotate_Bits_16[17];
                    Shift_Rotate_Bits_8[18] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[10] : Shift_Rotate_Bits_16[18];
                    Shift_Rotate_Bits_8[19] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[11] : Shift_Rotate_Bits_16[19];
                    Shift_Rotate_Bits_8[20] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[12] : Shift_Rotate_Bits_16[20];
                    Shift_Rotate_Bits_8[21] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[13] : Shift_Rotate_Bits_16[21];
                    Shift_Rotate_Bits_8[22] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[14] : Shift_Rotate_Bits_16[22];
                    Shift_Rotate_Bits_8[23] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[15] : Shift_Rotate_Bits_16[23];
                    Shift_Rotate_Bits_8[24] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[16] : Shift_Rotate_Bits_16[24];
                    Shift_Rotate_Bits_8[25] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[17] : Shift_Rotate_Bits_16[25];
                    Shift_Rotate_Bits_8[26] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[18] : Shift_Rotate_Bits_16[26];
                    Shift_Rotate_Bits_8[27] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[19] : Shift_Rotate_Bits_16[27];
                    Shift_Rotate_Bits_8[28] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[20] : Shift_Rotate_Bits_16[28];
                    Shift_Rotate_Bits_8[29] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[21] : Shift_Rotate_Bits_16[29];
                    Shift_Rotate_Bits_8[30] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[22] : Shift_Rotate_Bits_16[30];
                    Shift_Rotate_Bits_8[31] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[23] : Shift_Rotate_Bits_16[31];

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
                    Shift_Rotate_Bits_4[16] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[12] : Shift_Rotate_Bits_8[16];
                    Shift_Rotate_Bits_4[17] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[13] : Shift_Rotate_Bits_8[17];
                    Shift_Rotate_Bits_4[18] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[14] : Shift_Rotate_Bits_8[18];
                    Shift_Rotate_Bits_4[19] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[15] : Shift_Rotate_Bits_8[19];
                    Shift_Rotate_Bits_4[20] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[16] : Shift_Rotate_Bits_8[20];
                    Shift_Rotate_Bits_4[21] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[17] : Shift_Rotate_Bits_8[21];
                    Shift_Rotate_Bits_4[22] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[18] : Shift_Rotate_Bits_8[22];
                    Shift_Rotate_Bits_4[23] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[19] : Shift_Rotate_Bits_8[23];
                    Shift_Rotate_Bits_4[24] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[20] : Shift_Rotate_Bits_8[24];
                    Shift_Rotate_Bits_4[25] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[21] : Shift_Rotate_Bits_8[25];
                    Shift_Rotate_Bits_4[26] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[22] : Shift_Rotate_Bits_8[26];
                    Shift_Rotate_Bits_4[27] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[23] : Shift_Rotate_Bits_8[27];
                    Shift_Rotate_Bits_4[28] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[24] : Shift_Rotate_Bits_8[28];
                    Shift_Rotate_Bits_4[29] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[25] : Shift_Rotate_Bits_8[29];
                    Shift_Rotate_Bits_4[30] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[26] : Shift_Rotate_Bits_8[30];
                    Shift_Rotate_Bits_4[31] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[27] : Shift_Rotate_Bits_8[31];

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
                    Shift_Rotate_Bits_2[16] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[14] : Shift_Rotate_Bits_4[16];
                    Shift_Rotate_Bits_2[17] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[15] : Shift_Rotate_Bits_4[17];
                    Shift_Rotate_Bits_2[18] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[16] : Shift_Rotate_Bits_4[18];
                    Shift_Rotate_Bits_2[19] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[17] : Shift_Rotate_Bits_4[19];
                    Shift_Rotate_Bits_2[20] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[18] : Shift_Rotate_Bits_4[20];
                    Shift_Rotate_Bits_2[21] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[19] : Shift_Rotate_Bits_4[21];
                    Shift_Rotate_Bits_2[22] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[20] : Shift_Rotate_Bits_4[22];
                    Shift_Rotate_Bits_2[23] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[21] : Shift_Rotate_Bits_4[23];
                    Shift_Rotate_Bits_2[24] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[22] : Shift_Rotate_Bits_4[24];
                    Shift_Rotate_Bits_2[25] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[23] : Shift_Rotate_Bits_4[25];
                    Shift_Rotate_Bits_2[26] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[24] : Shift_Rotate_Bits_4[26];
                    Shift_Rotate_Bits_2[27] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[25] : Shift_Rotate_Bits_4[27];
                    Shift_Rotate_Bits_2[28] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[26] : Shift_Rotate_Bits_4[28];
                    Shift_Rotate_Bits_2[29] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[27] : Shift_Rotate_Bits_4[29];
                    Shift_Rotate_Bits_2[30] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[28] : Shift_Rotate_Bits_4[30];
                    Shift_Rotate_Bits_2[31] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[29] : Shift_Rotate_Bits_4[31];

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
                    Shift_Rotate_Bits_1[16] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[15] : Shift_Rotate_Bits_2[16];
                    Shift_Rotate_Bits_1[17] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[16] : Shift_Rotate_Bits_2[17];
                    Shift_Rotate_Bits_1[18] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[17] : Shift_Rotate_Bits_2[18];
                    Shift_Rotate_Bits_1[19] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[18] : Shift_Rotate_Bits_2[19];
                    Shift_Rotate_Bits_1[20] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[19] : Shift_Rotate_Bits_2[20];
                    Shift_Rotate_Bits_1[21] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[20] : Shift_Rotate_Bits_2[21];
                    Shift_Rotate_Bits_1[22] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[21] : Shift_Rotate_Bits_2[22];
                    Shift_Rotate_Bits_1[23] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[22] : Shift_Rotate_Bits_2[23];
                    Shift_Rotate_Bits_1[24] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[23] : Shift_Rotate_Bits_2[24];
                    Shift_Rotate_Bits_1[25] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[24] : Shift_Rotate_Bits_2[25];
                    Shift_Rotate_Bits_1[26] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[25] : Shift_Rotate_Bits_2[26];
                    Shift_Rotate_Bits_1[27] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[26] : Shift_Rotate_Bits_2[27];
                    Shift_Rotate_Bits_1[28] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[27] : Shift_Rotate_Bits_2[28];
                    Shift_Rotate_Bits_1[29] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[28] : Shift_Rotate_Bits_2[29];
                    Shift_Rotate_Bits_1[30] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[29] : Shift_Rotate_Bits_2[30];
                    Shift_Rotate_Bits_1[31] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[30] : Shift_Rotate_Bits_2[31];
                end

            ARITHMETIC_SHIFT_RIGHT     : // 3'h3
                begin
                    Shift_Rotate_Bits_16[32] <= 1'b0;
                    Shift_Rotate_Bits_8[32]  <= 1'b0;
                    Shift_Rotate_Bits_4[32]  <= 1'b0;
                    Shift_Rotate_Bits_2[32]  <= 1'b0;
                    Shift_Rotate_Bits_1[32]  <= 1'b0;
                    
                    // Shift 16-Bits
                    Shift_Rotate_Bits_16[0]  <= Shift_Bits_Length_In[4] ? Data_In[16] : Data_In[0];
                    Shift_Rotate_Bits_16[1]  <= Shift_Bits_Length_In[4] ? Data_In[17] : Data_In[1];
                    Shift_Rotate_Bits_16[2]  <= Shift_Bits_Length_In[4] ? Data_In[18] : Data_In[2];
                    Shift_Rotate_Bits_16[3]  <= Shift_Bits_Length_In[4] ? Data_In[19] : Data_In[3];
                    Shift_Rotate_Bits_16[4]  <= Shift_Bits_Length_In[4] ? Data_In[20] : Data_In[4];
                    Shift_Rotate_Bits_16[5]  <= Shift_Bits_Length_In[4] ? Data_In[21] : Data_In[5];
                    Shift_Rotate_Bits_16[6]  <= Shift_Bits_Length_In[4] ? Data_In[22] : Data_In[6];
                    Shift_Rotate_Bits_16[7]  <= Shift_Bits_Length_In[4] ? Data_In[23] : Data_In[7];
                    Shift_Rotate_Bits_16[8]  <= Shift_Bits_Length_In[4] ? Data_In[24] : Data_In[8];
                    Shift_Rotate_Bits_16[9]  <= Shift_Bits_Length_In[4] ? Data_In[25] : Data_In[9];
                    Shift_Rotate_Bits_16[10] <= Shift_Bits_Length_In[4] ? Data_In[26] : Data_In[10];
                    Shift_Rotate_Bits_16[11] <= Shift_Bits_Length_In[4] ? Data_In[27] : Data_In[11];
                    Shift_Rotate_Bits_16[12] <= Shift_Bits_Length_In[4] ? Data_In[28] : Data_In[12];
                    Shift_Rotate_Bits_16[13] <= Shift_Bits_Length_In[4] ? Data_In[29] : Data_In[13];
                    Shift_Rotate_Bits_16[14] <= Shift_Bits_Length_In[4] ? Data_In[30] : Data_In[14];
                    Shift_Rotate_Bits_16[15] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[15];
                    Shift_Rotate_Bits_16[16] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[16];
                    Shift_Rotate_Bits_16[17] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[17];
                    Shift_Rotate_Bits_16[18] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[18];
                    Shift_Rotate_Bits_16[19] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[19];
                    Shift_Rotate_Bits_16[20] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[20];
                    Shift_Rotate_Bits_16[21] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[21];
                    Shift_Rotate_Bits_16[22] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[22];
                    Shift_Rotate_Bits_16[23] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[23];
                    Shift_Rotate_Bits_16[24] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[24];
                    Shift_Rotate_Bits_16[25] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[25];
                    Shift_Rotate_Bits_16[26] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[26];
                    Shift_Rotate_Bits_16[27] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[27];
                    Shift_Rotate_Bits_16[28] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[28];
                    Shift_Rotate_Bits_16[29] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[29];
                    Shift_Rotate_Bits_16[30] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[30];
                    Shift_Rotate_Bits_16[31] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[31];

                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[8]  : Shift_Rotate_Bits_16[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[9]  : Shift_Rotate_Bits_16[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[10] : Shift_Rotate_Bits_16[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[11] : Shift_Rotate_Bits_16[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[12] : Shift_Rotate_Bits_16[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[13] : Shift_Rotate_Bits_16[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[14] : Shift_Rotate_Bits_16[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[15] : Shift_Rotate_Bits_16[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[16] : Shift_Rotate_Bits_16[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[17] : Shift_Rotate_Bits_16[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[18] : Shift_Rotate_Bits_16[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[19] : Shift_Rotate_Bits_16[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[20] : Shift_Rotate_Bits_16[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[21] : Shift_Rotate_Bits_16[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[22] : Shift_Rotate_Bits_16[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[23] : Shift_Rotate_Bits_16[15];
                    Shift_Rotate_Bits_8[16] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[24] : Shift_Rotate_Bits_16[16];
                    Shift_Rotate_Bits_8[17] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[25] : Shift_Rotate_Bits_16[17];
                    Shift_Rotate_Bits_8[18] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[26] : Shift_Rotate_Bits_16[18];
                    Shift_Rotate_Bits_8[19] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[27] : Shift_Rotate_Bits_16[19];
                    Shift_Rotate_Bits_8[20] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[28] : Shift_Rotate_Bits_16[20];
                    Shift_Rotate_Bits_8[21] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[29] : Shift_Rotate_Bits_16[21];
                    Shift_Rotate_Bits_8[22] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[30] : Shift_Rotate_Bits_16[22];
                    Shift_Rotate_Bits_8[23] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[31] : Shift_Rotate_Bits_16[23];
                    Shift_Rotate_Bits_8[24] <= Shift_Bits_Length_In[3] ? Data_In[31]              : Shift_Rotate_Bits_16[24];
                    Shift_Rotate_Bits_8[25] <= Shift_Bits_Length_In[3] ? Data_In[31]              : Shift_Rotate_Bits_16[25];
                    Shift_Rotate_Bits_8[26] <= Shift_Bits_Length_In[3] ? Data_In[31]              : Shift_Rotate_Bits_16[26];
                    Shift_Rotate_Bits_8[27] <= Shift_Bits_Length_In[3] ? Data_In[31]              : Shift_Rotate_Bits_16[27];
                    Shift_Rotate_Bits_8[28] <= Shift_Bits_Length_In[3] ? Data_In[31]              : Shift_Rotate_Bits_16[28];
                    Shift_Rotate_Bits_8[29] <= Shift_Bits_Length_In[3] ? Data_In[31]              : Shift_Rotate_Bits_16[29];
                    Shift_Rotate_Bits_8[30] <= Shift_Bits_Length_In[3] ? Data_In[31]              : Shift_Rotate_Bits_16[30];
                    Shift_Rotate_Bits_8[31] <= Shift_Bits_Length_In[3] ? Data_In[31]              : Shift_Rotate_Bits_16[31];

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
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[17] : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[18] : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[19] : Shift_Rotate_Bits_8[15];
                    Shift_Rotate_Bits_4[16] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[20] : Shift_Rotate_Bits_8[16];
                    Shift_Rotate_Bits_4[17] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[21] : Shift_Rotate_Bits_8[17];
                    Shift_Rotate_Bits_4[18] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[22] : Shift_Rotate_Bits_8[18];
                    Shift_Rotate_Bits_4[19] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[23] : Shift_Rotate_Bits_8[19];
                    Shift_Rotate_Bits_4[20] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[24] : Shift_Rotate_Bits_8[20];
                    Shift_Rotate_Bits_4[21] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[25] : Shift_Rotate_Bits_8[21];
                    Shift_Rotate_Bits_4[22] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[26] : Shift_Rotate_Bits_8[22];
                    Shift_Rotate_Bits_4[23] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[27] : Shift_Rotate_Bits_8[23];
                    Shift_Rotate_Bits_4[24] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[28] : Shift_Rotate_Bits_8[24];
                    Shift_Rotate_Bits_4[25] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[29] : Shift_Rotate_Bits_8[25];
                    Shift_Rotate_Bits_4[26] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[30] : Shift_Rotate_Bits_8[26];
                    Shift_Rotate_Bits_4[27] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[31] : Shift_Rotate_Bits_8[27];
                    Shift_Rotate_Bits_4[28] <= Shift_Bits_Length_In[2] ? Data_In[31]             : Shift_Rotate_Bits_8[28];
                    Shift_Rotate_Bits_4[29] <= Shift_Bits_Length_In[2] ? Data_In[31]             : Shift_Rotate_Bits_8[29];
                    Shift_Rotate_Bits_4[30] <= Shift_Bits_Length_In[2] ? Data_In[31]             : Shift_Rotate_Bits_8[30];
                    Shift_Rotate_Bits_4[31] <= Shift_Bits_Length_In[2] ? Data_In[31]             : Shift_Rotate_Bits_8[31];

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
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[17] : Shift_Rotate_Bits_4[15];
                    Shift_Rotate_Bits_2[16] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[18] : Shift_Rotate_Bits_4[16];
                    Shift_Rotate_Bits_2[17] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[19] : Shift_Rotate_Bits_4[17];
                    Shift_Rotate_Bits_2[18] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[20] : Shift_Rotate_Bits_4[18];
                    Shift_Rotate_Bits_2[19] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[21] : Shift_Rotate_Bits_4[19];
                    Shift_Rotate_Bits_2[20] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[22] : Shift_Rotate_Bits_4[20];
                    Shift_Rotate_Bits_2[21] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[23] : Shift_Rotate_Bits_4[21];
                    Shift_Rotate_Bits_2[22] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[24] : Shift_Rotate_Bits_4[22];
                    Shift_Rotate_Bits_2[23] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[25] : Shift_Rotate_Bits_4[23];
                    Shift_Rotate_Bits_2[24] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[26] : Shift_Rotate_Bits_4[24];
                    Shift_Rotate_Bits_2[25] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[27] : Shift_Rotate_Bits_4[25];
                    Shift_Rotate_Bits_2[26] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[28] : Shift_Rotate_Bits_4[26];
                    Shift_Rotate_Bits_2[27] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[29] : Shift_Rotate_Bits_4[27];
                    Shift_Rotate_Bits_2[28] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[30] : Shift_Rotate_Bits_4[28];
                    Shift_Rotate_Bits_2[29] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[31] : Shift_Rotate_Bits_4[29];
                    Shift_Rotate_Bits_2[30] <= Shift_Bits_Length_In[1] ? Data_In[31]             : Shift_Rotate_Bits_4[30];
                    Shift_Rotate_Bits_2[31] <= Shift_Bits_Length_In[1] ? Data_In[31]             : Shift_Rotate_Bits_4[31];

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
                    Shift_Rotate_Bits_1[16] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[17] : Shift_Rotate_Bits_2[16];
                    Shift_Rotate_Bits_1[17] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[18] : Shift_Rotate_Bits_2[17];
                    Shift_Rotate_Bits_1[18] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[19] : Shift_Rotate_Bits_2[18];
                    Shift_Rotate_Bits_1[19] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[20] : Shift_Rotate_Bits_2[19];
                    Shift_Rotate_Bits_1[20] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[21] : Shift_Rotate_Bits_2[20];
                    Shift_Rotate_Bits_1[21] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[22] : Shift_Rotate_Bits_2[21];
                    Shift_Rotate_Bits_1[22] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[23] : Shift_Rotate_Bits_2[22];
                    Shift_Rotate_Bits_1[23] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[24] : Shift_Rotate_Bits_2[23];
                    Shift_Rotate_Bits_1[24] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[25] : Shift_Rotate_Bits_2[24];
                    Shift_Rotate_Bits_1[25] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[26] : Shift_Rotate_Bits_2[25];
                    Shift_Rotate_Bits_1[26] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[27] : Shift_Rotate_Bits_2[26];
                    Shift_Rotate_Bits_1[27] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[28] : Shift_Rotate_Bits_2[27];
                    Shift_Rotate_Bits_1[28] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[29] : Shift_Rotate_Bits_2[28];
                    Shift_Rotate_Bits_1[29] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[30] : Shift_Rotate_Bits_2[29];
                    Shift_Rotate_Bits_1[30] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[31] : Shift_Rotate_Bits_2[30];
                    Shift_Rotate_Bits_1[31] <= Shift_Bits_Length_In[0] ? Data_In[31]             : Shift_Rotate_Bits_2[31];
                end

            ROTATE_LEFT                : // 3'h4
                begin
                    Shift_Rotate_Bits_16[32] <= 1'b0;
                    Shift_Rotate_Bits_8[32]  <= 1'b0;
                    Shift_Rotate_Bits_4[32]  <= 1'b0;
                    Shift_Rotate_Bits_2[32]  <= 1'b0;
                    Shift_Rotate_Bits_1[32]  <= 1'b0;
                    
                    // Shift 16-Bits
                    Shift_Rotate_Bits_16[0]  <= Shift_Bits_Length_In[4] ? Data_In[16] : Data_In[0];
                    Shift_Rotate_Bits_16[1]  <= Shift_Bits_Length_In[4] ? Data_In[17] : Data_In[1];
                    Shift_Rotate_Bits_16[2]  <= Shift_Bits_Length_In[4] ? Data_In[18] : Data_In[2];
                    Shift_Rotate_Bits_16[3]  <= Shift_Bits_Length_In[4] ? Data_In[19] : Data_In[3];
                    Shift_Rotate_Bits_16[4]  <= Shift_Bits_Length_In[4] ? Data_In[20] : Data_In[4];
                    Shift_Rotate_Bits_16[5]  <= Shift_Bits_Length_In[4] ? Data_In[21] : Data_In[5];
                    Shift_Rotate_Bits_16[6]  <= Shift_Bits_Length_In[4] ? Data_In[22] : Data_In[6];
                    Shift_Rotate_Bits_16[7]  <= Shift_Bits_Length_In[4] ? Data_In[23] : Data_In[7];
                    Shift_Rotate_Bits_16[8]  <= Shift_Bits_Length_In[4] ? Data_In[24] : Data_In[8];
                    Shift_Rotate_Bits_16[9]  <= Shift_Bits_Length_In[4] ? Data_In[25] : Data_In[9];
                    Shift_Rotate_Bits_16[10] <= Shift_Bits_Length_In[4] ? Data_In[26] : Data_In[10];
                    Shift_Rotate_Bits_16[11] <= Shift_Bits_Length_In[4] ? Data_In[27] : Data_In[11];
                    Shift_Rotate_Bits_16[12] <= Shift_Bits_Length_In[4] ? Data_In[28] : Data_In[12];
                    Shift_Rotate_Bits_16[13] <= Shift_Bits_Length_In[4] ? Data_In[29] : Data_In[13];
                    Shift_Rotate_Bits_16[14] <= Shift_Bits_Length_In[4] ? Data_In[30] : Data_In[14];
                    Shift_Rotate_Bits_16[15] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[15];
                    Shift_Rotate_Bits_16[16] <= Shift_Bits_Length_In[4] ? Data_In[0]  : Data_In[16];
                    Shift_Rotate_Bits_16[17] <= Shift_Bits_Length_In[4] ? Data_In[1]  : Data_In[17];
                    Shift_Rotate_Bits_16[18] <= Shift_Bits_Length_In[4] ? Data_In[2]  : Data_In[18];
                    Shift_Rotate_Bits_16[19] <= Shift_Bits_Length_In[4] ? Data_In[3]  : Data_In[19];
                    Shift_Rotate_Bits_16[20] <= Shift_Bits_Length_In[4] ? Data_In[4]  : Data_In[20];
                    Shift_Rotate_Bits_16[21] <= Shift_Bits_Length_In[4] ? Data_In[5]  : Data_In[21];
                    Shift_Rotate_Bits_16[22] <= Shift_Bits_Length_In[4] ? Data_In[6]  : Data_In[22];
                    Shift_Rotate_Bits_16[23] <= Shift_Bits_Length_In[4] ? Data_In[7]  : Data_In[23];
                    Shift_Rotate_Bits_16[24] <= Shift_Bits_Length_In[4] ? Data_In[8]  : Data_In[24];
                    Shift_Rotate_Bits_16[25] <= Shift_Bits_Length_In[4] ? Data_In[9]  : Data_In[25];
                    Shift_Rotate_Bits_16[26] <= Shift_Bits_Length_In[4] ? Data_In[10] : Data_In[26];
                    Shift_Rotate_Bits_16[27] <= Shift_Bits_Length_In[4] ? Data_In[11] : Data_In[27];
                    Shift_Rotate_Bits_16[28] <= Shift_Bits_Length_In[4] ? Data_In[12] : Data_In[28];
                    Shift_Rotate_Bits_16[29] <= Shift_Bits_Length_In[4] ? Data_In[13] : Data_In[29];
                    Shift_Rotate_Bits_16[30] <= Shift_Bits_Length_In[4] ? Data_In[14] : Data_In[30];
                    Shift_Rotate_Bits_16[31] <= Shift_Bits_Length_In[4] ? Data_In[15] : Data_In[31];

                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[24] : Shift_Rotate_Bits_16[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[25] : Shift_Rotate_Bits_16[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[26] : Shift_Rotate_Bits_16[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[27] : Shift_Rotate_Bits_16[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[28] : Shift_Rotate_Bits_16[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[29] : Shift_Rotate_Bits_16[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[30] : Shift_Rotate_Bits_16[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[31] : Shift_Rotate_Bits_16[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[0]  : Shift_Rotate_Bits_16[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[1]  : Shift_Rotate_Bits_16[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[2]  : Shift_Rotate_Bits_16[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[3]  : Shift_Rotate_Bits_16[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[4]  : Shift_Rotate_Bits_16[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[5]  : Shift_Rotate_Bits_16[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[6]  : Shift_Rotate_Bits_16[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[7]  : Shift_Rotate_Bits_16[15];
                    Shift_Rotate_Bits_8[16] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[8]  : Shift_Rotate_Bits_16[16];
                    Shift_Rotate_Bits_8[17] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[9]  : Shift_Rotate_Bits_16[17];
                    Shift_Rotate_Bits_8[18] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[10] : Shift_Rotate_Bits_16[18];
                    Shift_Rotate_Bits_8[19] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[11] : Shift_Rotate_Bits_16[19];
                    Shift_Rotate_Bits_8[20] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[12] : Shift_Rotate_Bits_16[20];
                    Shift_Rotate_Bits_8[21] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[13] : Shift_Rotate_Bits_16[21];
                    Shift_Rotate_Bits_8[22] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[14] : Shift_Rotate_Bits_16[22];
                    Shift_Rotate_Bits_8[23] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[15] : Shift_Rotate_Bits_16[23];
                    Shift_Rotate_Bits_8[24] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[16] : Shift_Rotate_Bits_16[24];
                    Shift_Rotate_Bits_8[25] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[17] : Shift_Rotate_Bits_16[25];
                    Shift_Rotate_Bits_8[26] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[18] : Shift_Rotate_Bits_16[26];
                    Shift_Rotate_Bits_8[27] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[19] : Shift_Rotate_Bits_16[27];
                    Shift_Rotate_Bits_8[28] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[20] : Shift_Rotate_Bits_16[28];
                    Shift_Rotate_Bits_8[29] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[21] : Shift_Rotate_Bits_16[29];
                    Shift_Rotate_Bits_8[30] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[22] : Shift_Rotate_Bits_16[30];
                    Shift_Rotate_Bits_8[31] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[23] : Shift_Rotate_Bits_16[31];

                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[28] : Shift_Rotate_Bits_8[0];
                    Shift_Rotate_Bits_4[1]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[29] : Shift_Rotate_Bits_8[1];
                    Shift_Rotate_Bits_4[2]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[30] : Shift_Rotate_Bits_8[2];
                    Shift_Rotate_Bits_4[3]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[31] : Shift_Rotate_Bits_8[3];
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
                    Shift_Rotate_Bits_4[17] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[13] : Shift_Rotate_Bits_8[17];
                    Shift_Rotate_Bits_4[18] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[14] : Shift_Rotate_Bits_8[18];
                    Shift_Rotate_Bits_4[19] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[15] : Shift_Rotate_Bits_8[19];
                    Shift_Rotate_Bits_4[20] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[16] : Shift_Rotate_Bits_8[20];
                    Shift_Rotate_Bits_4[21] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[17] : Shift_Rotate_Bits_8[21];
                    Shift_Rotate_Bits_4[22] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[18] : Shift_Rotate_Bits_8[22];
                    Shift_Rotate_Bits_4[23] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[19] : Shift_Rotate_Bits_8[23];
                    Shift_Rotate_Bits_4[24] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[20] : Shift_Rotate_Bits_8[24];
                    Shift_Rotate_Bits_4[25] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[21] : Shift_Rotate_Bits_8[25];
                    Shift_Rotate_Bits_4[26] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[22] : Shift_Rotate_Bits_8[26];
                    Shift_Rotate_Bits_4[27] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[23] : Shift_Rotate_Bits_8[27];
                    Shift_Rotate_Bits_4[28] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[24] : Shift_Rotate_Bits_8[28];
                    Shift_Rotate_Bits_4[29] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[25] : Shift_Rotate_Bits_8[29];
                    Shift_Rotate_Bits_4[30] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[26] : Shift_Rotate_Bits_8[30];
                    Shift_Rotate_Bits_4[31] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[27] : Shift_Rotate_Bits_8[31];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[30] : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[31] : Shift_Rotate_Bits_4[1];
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
                    Shift_Rotate_Bits_2[17] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[15] : Shift_Rotate_Bits_4[17];
                    Shift_Rotate_Bits_2[18] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[16] : Shift_Rotate_Bits_4[18];
                    Shift_Rotate_Bits_2[19] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[17] : Shift_Rotate_Bits_4[19];
                    Shift_Rotate_Bits_2[20] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[18] : Shift_Rotate_Bits_4[20];
                    Shift_Rotate_Bits_2[21] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[19] : Shift_Rotate_Bits_4[21];
                    Shift_Rotate_Bits_2[22] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[20] : Shift_Rotate_Bits_4[22];
                    Shift_Rotate_Bits_2[23] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[21] : Shift_Rotate_Bits_4[23];
                    Shift_Rotate_Bits_2[24] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[22] : Shift_Rotate_Bits_4[24];
                    Shift_Rotate_Bits_2[25] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[23] : Shift_Rotate_Bits_4[25];
                    Shift_Rotate_Bits_2[26] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[24] : Shift_Rotate_Bits_4[26];
                    Shift_Rotate_Bits_2[27] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[25] : Shift_Rotate_Bits_4[27];
                    Shift_Rotate_Bits_2[28] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[26] : Shift_Rotate_Bits_4[28];
                    Shift_Rotate_Bits_2[29] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[27] : Shift_Rotate_Bits_4[29];
                    Shift_Rotate_Bits_2[30] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[28] : Shift_Rotate_Bits_4[30];
                    Shift_Rotate_Bits_2[31] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[29] : Shift_Rotate_Bits_4[31];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[31] : Shift_Rotate_Bits_2[0];
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
                    Shift_Rotate_Bits_1[17] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[16] : Shift_Rotate_Bits_2[17];
                    Shift_Rotate_Bits_1[18] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[17] : Shift_Rotate_Bits_2[18];
                    Shift_Rotate_Bits_1[19] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[18] : Shift_Rotate_Bits_2[19];
                    Shift_Rotate_Bits_1[20] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[19] : Shift_Rotate_Bits_2[20];
                    Shift_Rotate_Bits_1[21] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[20] : Shift_Rotate_Bits_2[21];
                    Shift_Rotate_Bits_1[22] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[21] : Shift_Rotate_Bits_2[22];
                    Shift_Rotate_Bits_1[23] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[22] : Shift_Rotate_Bits_2[23];
                    Shift_Rotate_Bits_1[24] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[23] : Shift_Rotate_Bits_2[24];
                    Shift_Rotate_Bits_1[25] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[24] : Shift_Rotate_Bits_2[25];
                    Shift_Rotate_Bits_1[26] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[25] : Shift_Rotate_Bits_2[26];
                    Shift_Rotate_Bits_1[27] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[26] : Shift_Rotate_Bits_2[27];
                    Shift_Rotate_Bits_1[28] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[27] : Shift_Rotate_Bits_2[28];
                    Shift_Rotate_Bits_1[29] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[28] : Shift_Rotate_Bits_2[29];
                    Shift_Rotate_Bits_1[30] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[29] : Shift_Rotate_Bits_2[30];
                    Shift_Rotate_Bits_1[31] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[30] : Shift_Rotate_Bits_2[31];
                end

            ROTATE_RIGHT               : // 3'h5
                begin
                    Shift_Rotate_Bits_16[32] <= 1'b0;
                    Shift_Rotate_Bits_8[32]  <= 1'b0;
                    Shift_Rotate_Bits_4[32]  <= 1'b0;
                    Shift_Rotate_Bits_2[32]  <= 1'b0;
                    Shift_Rotate_Bits_1[32]  <= 1'b0;
                    
                    // Shift 16-Bits
                    Shift_Rotate_Bits_16[0]  <= Shift_Bits_Length_In[4] ? Data_In[16] : Data_In[0];
                    Shift_Rotate_Bits_16[1]  <= Shift_Bits_Length_In[4] ? Data_In[17] : Data_In[1];
                    Shift_Rotate_Bits_16[2]  <= Shift_Bits_Length_In[4] ? Data_In[18] : Data_In[2];
                    Shift_Rotate_Bits_16[3]  <= Shift_Bits_Length_In[4] ? Data_In[19] : Data_In[3];
                    Shift_Rotate_Bits_16[4]  <= Shift_Bits_Length_In[4] ? Data_In[20] : Data_In[4];
                    Shift_Rotate_Bits_16[5]  <= Shift_Bits_Length_In[4] ? Data_In[21] : Data_In[5];
                    Shift_Rotate_Bits_16[6]  <= Shift_Bits_Length_In[4] ? Data_In[22] : Data_In[6];
                    Shift_Rotate_Bits_16[7]  <= Shift_Bits_Length_In[4] ? Data_In[23] : Data_In[7];
                    Shift_Rotate_Bits_16[8]  <= Shift_Bits_Length_In[4] ? Data_In[24] : Data_In[8];
                    Shift_Rotate_Bits_16[9]  <= Shift_Bits_Length_In[4] ? Data_In[25] : Data_In[9];
                    Shift_Rotate_Bits_16[10] <= Shift_Bits_Length_In[4] ? Data_In[26] : Data_In[10];
                    Shift_Rotate_Bits_16[11] <= Shift_Bits_Length_In[4] ? Data_In[27] : Data_In[11];
                    Shift_Rotate_Bits_16[12] <= Shift_Bits_Length_In[4] ? Data_In[28] : Data_In[12];
                    Shift_Rotate_Bits_16[13] <= Shift_Bits_Length_In[4] ? Data_In[29] : Data_In[13];
                    Shift_Rotate_Bits_16[14] <= Shift_Bits_Length_In[4] ? Data_In[30] : Data_In[14];
                    Shift_Rotate_Bits_16[15] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[15];
                    Shift_Rotate_Bits_16[16] <= Shift_Bits_Length_In[4] ? Data_In[0]  : Data_In[16];
                    Shift_Rotate_Bits_16[17] <= Shift_Bits_Length_In[4] ? Data_In[1]  : Data_In[17];
                    Shift_Rotate_Bits_16[18] <= Shift_Bits_Length_In[4] ? Data_In[2]  : Data_In[18];
                    Shift_Rotate_Bits_16[19] <= Shift_Bits_Length_In[4] ? Data_In[3]  : Data_In[19];
                    Shift_Rotate_Bits_16[20] <= Shift_Bits_Length_In[4] ? Data_In[4]  : Data_In[20];
                    Shift_Rotate_Bits_16[21] <= Shift_Bits_Length_In[4] ? Data_In[5]  : Data_In[21];
                    Shift_Rotate_Bits_16[22] <= Shift_Bits_Length_In[4] ? Data_In[6]  : Data_In[22];
                    Shift_Rotate_Bits_16[23] <= Shift_Bits_Length_In[4] ? Data_In[7]  : Data_In[23];
                    Shift_Rotate_Bits_16[24] <= Shift_Bits_Length_In[4] ? Data_In[8]  : Data_In[24];
                    Shift_Rotate_Bits_16[25] <= Shift_Bits_Length_In[4] ? Data_In[9]  : Data_In[25];
                    Shift_Rotate_Bits_16[26] <= Shift_Bits_Length_In[4] ? Data_In[10] : Data_In[26];
                    Shift_Rotate_Bits_16[27] <= Shift_Bits_Length_In[4] ? Data_In[11] : Data_In[27];
                    Shift_Rotate_Bits_16[28] <= Shift_Bits_Length_In[4] ? Data_In[12] : Data_In[28];
                    Shift_Rotate_Bits_16[29] <= Shift_Bits_Length_In[4] ? Data_In[13] : Data_In[29];
                    Shift_Rotate_Bits_16[30] <= Shift_Bits_Length_In[4] ? Data_In[14] : Data_In[30];
                    Shift_Rotate_Bits_16[31] <= Shift_Bits_Length_In[4] ? Data_In[15] : Data_In[31];

                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[8]  : Shift_Rotate_Bits_16[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[9]  : Shift_Rotate_Bits_16[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[10] : Shift_Rotate_Bits_16[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[11] : Shift_Rotate_Bits_16[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[12] : Shift_Rotate_Bits_16[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[13] : Shift_Rotate_Bits_16[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[14] : Shift_Rotate_Bits_16[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[15] : Shift_Rotate_Bits_16[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[16] : Shift_Rotate_Bits_16[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[17] : Shift_Rotate_Bits_16[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[18] : Shift_Rotate_Bits_16[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[19] : Shift_Rotate_Bits_16[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[20] : Shift_Rotate_Bits_16[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[21] : Shift_Rotate_Bits_16[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[22] : Shift_Rotate_Bits_16[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[23] : Shift_Rotate_Bits_16[15];
                    Shift_Rotate_Bits_8[16] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[24] : Shift_Rotate_Bits_16[16];
                    Shift_Rotate_Bits_8[17] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[25] : Shift_Rotate_Bits_16[17];
                    Shift_Rotate_Bits_8[18] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[26] : Shift_Rotate_Bits_16[18];
                    Shift_Rotate_Bits_8[19] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[27] : Shift_Rotate_Bits_16[19];
                    Shift_Rotate_Bits_8[20] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[28] : Shift_Rotate_Bits_16[20];
                    Shift_Rotate_Bits_8[21] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[29] : Shift_Rotate_Bits_16[21];
                    Shift_Rotate_Bits_8[22] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[30] : Shift_Rotate_Bits_16[22];
                    Shift_Rotate_Bits_8[23] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[31] : Shift_Rotate_Bits_16[23];
                    Shift_Rotate_Bits_8[24] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[0]  : Shift_Rotate_Bits_16[24];
                    Shift_Rotate_Bits_8[25] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[1]  : Shift_Rotate_Bits_16[25];
                    Shift_Rotate_Bits_8[26] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[2]  : Shift_Rotate_Bits_16[26];
                    Shift_Rotate_Bits_8[27] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[3]  : Shift_Rotate_Bits_16[27];
                    Shift_Rotate_Bits_8[28] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[4]  : Shift_Rotate_Bits_16[28];
                    Shift_Rotate_Bits_8[29] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[5]  : Shift_Rotate_Bits_16[29];
                    Shift_Rotate_Bits_8[30] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[6]  : Shift_Rotate_Bits_16[30];
                    Shift_Rotate_Bits_8[31] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[7]  : Shift_Rotate_Bits_16[31];

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
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[17] : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[18] : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[19] : Shift_Rotate_Bits_8[15];
                    Shift_Rotate_Bits_4[16] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[20] : Shift_Rotate_Bits_8[16];
                    Shift_Rotate_Bits_4[17] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[21] : Shift_Rotate_Bits_8[17];
                    Shift_Rotate_Bits_4[18] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[22] : Shift_Rotate_Bits_8[18];
                    Shift_Rotate_Bits_4[19] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[23] : Shift_Rotate_Bits_8[19];
                    Shift_Rotate_Bits_4[20] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[24] : Shift_Rotate_Bits_8[20];
                    Shift_Rotate_Bits_4[21] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[25] : Shift_Rotate_Bits_8[21];
                    Shift_Rotate_Bits_4[22] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[26] : Shift_Rotate_Bits_8[22];
                    Shift_Rotate_Bits_4[23] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[27] : Shift_Rotate_Bits_8[23];
                    Shift_Rotate_Bits_4[24] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[28] : Shift_Rotate_Bits_8[24];
                    Shift_Rotate_Bits_4[25] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[29] : Shift_Rotate_Bits_8[25];
                    Shift_Rotate_Bits_4[26] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[30] : Shift_Rotate_Bits_8[26];
                    Shift_Rotate_Bits_4[27] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[31] : Shift_Rotate_Bits_8[27];
                    Shift_Rotate_Bits_4[28] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[0]  : Shift_Rotate_Bits_8[28];
                    Shift_Rotate_Bits_4[29] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[1]  : Shift_Rotate_Bits_8[29];
                    Shift_Rotate_Bits_4[30] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[2]  : Shift_Rotate_Bits_8[30];
                    Shift_Rotate_Bits_4[31] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[3]  : Shift_Rotate_Bits_8[31];

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
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[17] : Shift_Rotate_Bits_4[15];
                    Shift_Rotate_Bits_2[16] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[18] : Shift_Rotate_Bits_4[16];
                    Shift_Rotate_Bits_2[17] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[19] : Shift_Rotate_Bits_4[17];
                    Shift_Rotate_Bits_2[18] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[20] : Shift_Rotate_Bits_4[18];
                    Shift_Rotate_Bits_2[19] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[21] : Shift_Rotate_Bits_4[19];
                    Shift_Rotate_Bits_2[20] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[22] : Shift_Rotate_Bits_4[20];
                    Shift_Rotate_Bits_2[21] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[23] : Shift_Rotate_Bits_4[21];
                    Shift_Rotate_Bits_2[22] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[24] : Shift_Rotate_Bits_4[22];
                    Shift_Rotate_Bits_2[23] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[25] : Shift_Rotate_Bits_4[23];
                    Shift_Rotate_Bits_2[24] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[26] : Shift_Rotate_Bits_4[24];
                    Shift_Rotate_Bits_2[25] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[27] : Shift_Rotate_Bits_4[25];
                    Shift_Rotate_Bits_2[26] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[28] : Shift_Rotate_Bits_4[26];
                    Shift_Rotate_Bits_2[27] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[29] : Shift_Rotate_Bits_4[27];
                    Shift_Rotate_Bits_2[28] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[30] : Shift_Rotate_Bits_4[28];
                    Shift_Rotate_Bits_2[29] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[31] : Shift_Rotate_Bits_4[29];
                    Shift_Rotate_Bits_2[30] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0]  : Shift_Rotate_Bits_4[30];
                    Shift_Rotate_Bits_2[31] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1]  : Shift_Rotate_Bits_4[31];

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
                    Shift_Rotate_Bits_1[16] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[17] : Shift_Rotate_Bits_2[16];
                    Shift_Rotate_Bits_1[17] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[18] : Shift_Rotate_Bits_2[17];
                    Shift_Rotate_Bits_1[18] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[19] : Shift_Rotate_Bits_2[18];
                    Shift_Rotate_Bits_1[19] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[20] : Shift_Rotate_Bits_2[19];
                    Shift_Rotate_Bits_1[20] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[21] : Shift_Rotate_Bits_2[20];
                    Shift_Rotate_Bits_1[21] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[22] : Shift_Rotate_Bits_2[21];
                    Shift_Rotate_Bits_1[22] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[23] : Shift_Rotate_Bits_2[22];
                    Shift_Rotate_Bits_1[23] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[24] : Shift_Rotate_Bits_2[23];
                    Shift_Rotate_Bits_1[24] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[25] : Shift_Rotate_Bits_2[24];
                    Shift_Rotate_Bits_1[25] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[26] : Shift_Rotate_Bits_2[25];
                    Shift_Rotate_Bits_1[26] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[27] : Shift_Rotate_Bits_2[26];
                    Shift_Rotate_Bits_1[27] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[28] : Shift_Rotate_Bits_2[27];
                    Shift_Rotate_Bits_1[28] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[29] : Shift_Rotate_Bits_2[28];
                    Shift_Rotate_Bits_1[29] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[30] : Shift_Rotate_Bits_2[29];
                    Shift_Rotate_Bits_1[30] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[31] : Shift_Rotate_Bits_2[30];
                    Shift_Rotate_Bits_1[31] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0]  : Shift_Rotate_Bits_2[31];
                end

            ROTATE_LEFT_THROUGH_CARRY  : // 3'h6
                begin
                    // Shift 16-Bits
                    Shift_Rotate_Bits_16[0]  <= Shift_Bits_Length_In[4] ? Data_In[17] : Data_In[0];
                    Shift_Rotate_Bits_16[1]  <= Shift_Bits_Length_In[4] ? Data_In[18] : Data_In[1];
                    Shift_Rotate_Bits_16[2]  <= Shift_Bits_Length_In[4] ? Data_In[19] : Data_In[2];
                    Shift_Rotate_Bits_16[3]  <= Shift_Bits_Length_In[4] ? Data_In[20] : Data_In[3];
                    Shift_Rotate_Bits_16[4]  <= Shift_Bits_Length_In[4] ? Data_In[21] : Data_In[4];
                    Shift_Rotate_Bits_16[5]  <= Shift_Bits_Length_In[4] ? Data_In[22] : Data_In[5];
                    Shift_Rotate_Bits_16[6]  <= Shift_Bits_Length_In[4] ? Data_In[23] : Data_In[6];
                    Shift_Rotate_Bits_16[7]  <= Shift_Bits_Length_In[4] ? Data_In[24] : Data_In[7];
                    Shift_Rotate_Bits_16[8]  <= Shift_Bits_Length_In[4] ? Data_In[25] : Data_In[8];
                    Shift_Rotate_Bits_16[9]  <= Shift_Bits_Length_In[4] ? Data_In[26] : Data_In[9];
                    Shift_Rotate_Bits_16[10] <= Shift_Bits_Length_In[4] ? Data_In[27] : Data_In[10];
                    Shift_Rotate_Bits_16[11] <= Shift_Bits_Length_In[4] ? Data_In[28] : Data_In[11];
                    Shift_Rotate_Bits_16[12] <= Shift_Bits_Length_In[4] ? Data_In[29] : Data_In[12];
                    Shift_Rotate_Bits_16[13] <= Shift_Bits_Length_In[4] ? Data_In[30] : Data_In[13];
                    Shift_Rotate_Bits_16[14] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[14];
                    Shift_Rotate_Bits_16[15] <= Shift_Bits_Length_In[4] ? Carry_In    : Data_In[15];
                    Shift_Rotate_Bits_16[16] <= Shift_Bits_Length_In[4] ? Data_In[0]  : Data_In[16];
                    Shift_Rotate_Bits_16[17] <= Shift_Bits_Length_In[4] ? Data_In[1]  : Data_In[17];
                    Shift_Rotate_Bits_16[18] <= Shift_Bits_Length_In[4] ? Data_In[2]  : Data_In[18];
                    Shift_Rotate_Bits_16[19] <= Shift_Bits_Length_In[4] ? Data_In[3]  : Data_In[19];
                    Shift_Rotate_Bits_16[20] <= Shift_Bits_Length_In[4] ? Data_In[4]  : Data_In[20];
                    Shift_Rotate_Bits_16[21] <= Shift_Bits_Length_In[4] ? Data_In[5]  : Data_In[21];
                    Shift_Rotate_Bits_16[22] <= Shift_Bits_Length_In[4] ? Data_In[6]  : Data_In[22];
                    Shift_Rotate_Bits_16[23] <= Shift_Bits_Length_In[4] ? Data_In[7]  : Data_In[23];
                    Shift_Rotate_Bits_16[24] <= Shift_Bits_Length_In[4] ? Data_In[8]  : Data_In[24];
                    Shift_Rotate_Bits_16[25] <= Shift_Bits_Length_In[4] ? Data_In[9]  : Data_In[25];
                    Shift_Rotate_Bits_16[26] <= Shift_Bits_Length_In[4] ? Data_In[10] : Data_In[26];
                    Shift_Rotate_Bits_16[27] <= Shift_Bits_Length_In[4] ? Data_In[11] : Data_In[27];
                    Shift_Rotate_Bits_16[28] <= Shift_Bits_Length_In[4] ? Data_In[12] : Data_In[28];
                    Shift_Rotate_Bits_16[29] <= Shift_Bits_Length_In[4] ? Data_In[13] : Data_In[29];
                    Shift_Rotate_Bits_16[30] <= Shift_Bits_Length_In[4] ? Data_In[14] : Data_In[30];
                    Shift_Rotate_Bits_16[31] <= Shift_Bits_Length_In[4] ? Data_In[15] : Data_In[31];
                    Shift_Rotate_Bits_16[32] <= Shift_Bits_Length_In[4] ? Data_In[16] : Carry_In;

                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[25] : Shift_Rotate_Bits_16[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[26] : Shift_Rotate_Bits_16[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[27] : Shift_Rotate_Bits_16[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[28] : Shift_Rotate_Bits_16[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[29] : Shift_Rotate_Bits_16[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[30] : Shift_Rotate_Bits_16[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[31] : Shift_Rotate_Bits_16[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[32] : Shift_Rotate_Bits_16[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[0]  : Shift_Rotate_Bits_16[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[1]  : Shift_Rotate_Bits_16[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[2]  : Shift_Rotate_Bits_16[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[3]  : Shift_Rotate_Bits_16[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[4]  : Shift_Rotate_Bits_16[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[5]  : Shift_Rotate_Bits_16[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[6]  : Shift_Rotate_Bits_16[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[7]  : Shift_Rotate_Bits_16[15];
                    Shift_Rotate_Bits_8[16] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[8]  : Shift_Rotate_Bits_16[16];
                    Shift_Rotate_Bits_8[17] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[9]  : Shift_Rotate_Bits_16[17];
                    Shift_Rotate_Bits_8[18] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[10] : Shift_Rotate_Bits_16[18];
                    Shift_Rotate_Bits_8[19] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[11] : Shift_Rotate_Bits_16[19];
                    Shift_Rotate_Bits_8[20] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[12] : Shift_Rotate_Bits_16[20];
                    Shift_Rotate_Bits_8[21] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[13] : Shift_Rotate_Bits_16[21];
                    Shift_Rotate_Bits_8[22] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[14] : Shift_Rotate_Bits_16[22];
                    Shift_Rotate_Bits_8[23] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[15] : Shift_Rotate_Bits_16[23];
                    Shift_Rotate_Bits_8[24] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[16] : Shift_Rotate_Bits_16[24];
                    Shift_Rotate_Bits_8[25] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[17] : Shift_Rotate_Bits_16[25];
                    Shift_Rotate_Bits_8[26] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[18] : Shift_Rotate_Bits_16[26];
                    Shift_Rotate_Bits_8[27] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[19] : Shift_Rotate_Bits_16[27];
                    Shift_Rotate_Bits_8[28] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[20] : Shift_Rotate_Bits_16[28];
                    Shift_Rotate_Bits_8[29] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[21] : Shift_Rotate_Bits_16[29];
                    Shift_Rotate_Bits_8[30] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[22] : Shift_Rotate_Bits_16[30];
                    Shift_Rotate_Bits_8[31] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[23] : Shift_Rotate_Bits_16[31];
                    Shift_Rotate_Bits_8[32] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[24] : Shift_Rotate_Bits_16[32];

                    // Shift 4-Bits
                    Shift_Rotate_Bits_4[0]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[29] : Shift_Rotate_Bits_8[0];
                    Shift_Rotate_Bits_4[1]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[30] : Shift_Rotate_Bits_8[1];
                    Shift_Rotate_Bits_4[2]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[31] : Shift_Rotate_Bits_8[2];
                    Shift_Rotate_Bits_4[3]  <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[32] : Shift_Rotate_Bits_8[3];
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
                    Shift_Rotate_Bits_4[17] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[13] : Shift_Rotate_Bits_8[17];
                    Shift_Rotate_Bits_4[18] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[14] : Shift_Rotate_Bits_8[18];
                    Shift_Rotate_Bits_4[19] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[15] : Shift_Rotate_Bits_8[19];
                    Shift_Rotate_Bits_4[20] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[16] : Shift_Rotate_Bits_8[20];
                    Shift_Rotate_Bits_4[21] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[17] : Shift_Rotate_Bits_8[21];
                    Shift_Rotate_Bits_4[22] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[18] : Shift_Rotate_Bits_8[22];
                    Shift_Rotate_Bits_4[23] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[19] : Shift_Rotate_Bits_8[23];
                    Shift_Rotate_Bits_4[24] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[20] : Shift_Rotate_Bits_8[24];
                    Shift_Rotate_Bits_4[25] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[21] : Shift_Rotate_Bits_8[25];
                    Shift_Rotate_Bits_4[26] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[22] : Shift_Rotate_Bits_8[26];
                    Shift_Rotate_Bits_4[27] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[23] : Shift_Rotate_Bits_8[27];
                    Shift_Rotate_Bits_4[28] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[24] : Shift_Rotate_Bits_8[28];
                    Shift_Rotate_Bits_4[29] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[25] : Shift_Rotate_Bits_8[29];
                    Shift_Rotate_Bits_4[30] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[26] : Shift_Rotate_Bits_8[30];
                    Shift_Rotate_Bits_4[31] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[27] : Shift_Rotate_Bits_8[31];
                    Shift_Rotate_Bits_4[32] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[28] : Shift_Rotate_Bits_8[32];

                    // Shift 2-Bits
                    Shift_Rotate_Bits_2[0]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[31] : Shift_Rotate_Bits_4[0];
                    Shift_Rotate_Bits_2[1]  <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[32] : Shift_Rotate_Bits_4[1];
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
                    Shift_Rotate_Bits_2[17] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[15] : Shift_Rotate_Bits_4[17];
                    Shift_Rotate_Bits_2[18] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[16] : Shift_Rotate_Bits_4[18];
                    Shift_Rotate_Bits_2[19] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[17] : Shift_Rotate_Bits_4[19];
                    Shift_Rotate_Bits_2[20] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[18] : Shift_Rotate_Bits_4[20];
                    Shift_Rotate_Bits_2[21] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[19] : Shift_Rotate_Bits_4[21];
                    Shift_Rotate_Bits_2[22] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[20] : Shift_Rotate_Bits_4[22];
                    Shift_Rotate_Bits_2[23] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[21] : Shift_Rotate_Bits_4[23];
                    Shift_Rotate_Bits_2[24] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[22] : Shift_Rotate_Bits_4[24];
                    Shift_Rotate_Bits_2[25] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[23] : Shift_Rotate_Bits_4[25];
                    Shift_Rotate_Bits_2[26] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[24] : Shift_Rotate_Bits_4[26];
                    Shift_Rotate_Bits_2[27] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[25] : Shift_Rotate_Bits_4[27];
                    Shift_Rotate_Bits_2[28] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[26] : Shift_Rotate_Bits_4[28];
                    Shift_Rotate_Bits_2[29] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[27] : Shift_Rotate_Bits_4[29];
                    Shift_Rotate_Bits_2[30] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[28] : Shift_Rotate_Bits_4[30];
                    Shift_Rotate_Bits_2[31] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[29] : Shift_Rotate_Bits_4[31];
                    Shift_Rotate_Bits_2[32] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[30] : Shift_Rotate_Bits_4[32];

                    // Shift 1-Bits
                    Shift_Rotate_Bits_1[0]  <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[32] : Shift_Rotate_Bits_2[0];
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
                    Shift_Rotate_Bits_1[17] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[16] : Shift_Rotate_Bits_2[17];
                    Shift_Rotate_Bits_1[18] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[17] : Shift_Rotate_Bits_2[18];
                    Shift_Rotate_Bits_1[19] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[18] : Shift_Rotate_Bits_2[19];
                    Shift_Rotate_Bits_1[20] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[19] : Shift_Rotate_Bits_2[20];
                    Shift_Rotate_Bits_1[21] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[20] : Shift_Rotate_Bits_2[21];
                    Shift_Rotate_Bits_1[22] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[21] : Shift_Rotate_Bits_2[22];
                    Shift_Rotate_Bits_1[23] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[22] : Shift_Rotate_Bits_2[23];
                    Shift_Rotate_Bits_1[24] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[23] : Shift_Rotate_Bits_2[24];
                    Shift_Rotate_Bits_1[25] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[24] : Shift_Rotate_Bits_2[25];
                    Shift_Rotate_Bits_1[26] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[25] : Shift_Rotate_Bits_2[26];
                    Shift_Rotate_Bits_1[27] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[26] : Shift_Rotate_Bits_2[27];
                    Shift_Rotate_Bits_1[28] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[27] : Shift_Rotate_Bits_2[28];
                    Shift_Rotate_Bits_1[29] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[28] : Shift_Rotate_Bits_2[29];
                    Shift_Rotate_Bits_1[30] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[29] : Shift_Rotate_Bits_2[30];
                    Shift_Rotate_Bits_1[31] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[30] : Shift_Rotate_Bits_2[31];
                    Shift_Rotate_Bits_1[32] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[31] : Shift_Rotate_Bits_2[32];
                end

            ROTATE_RIGHT_THROUGH_CARRY : // 3'h7
                begin
                    // Shift 16-Bits
                    Shift_Rotate_Bits_16[0]  <= Shift_Bits_Length_In[4] ? Data_In[16] : Data_In[0];
                    Shift_Rotate_Bits_16[1]  <= Shift_Bits_Length_In[4] ? Data_In[17] : Data_In[1];
                    Shift_Rotate_Bits_16[2]  <= Shift_Bits_Length_In[4] ? Data_In[18] : Data_In[2];
                    Shift_Rotate_Bits_16[3]  <= Shift_Bits_Length_In[4] ? Data_In[19] : Data_In[3];
                    Shift_Rotate_Bits_16[4]  <= Shift_Bits_Length_In[4] ? Data_In[20] : Data_In[4];
                    Shift_Rotate_Bits_16[5]  <= Shift_Bits_Length_In[4] ? Data_In[21] : Data_In[5];
                    Shift_Rotate_Bits_16[6]  <= Shift_Bits_Length_In[4] ? Data_In[22] : Data_In[6];
                    Shift_Rotate_Bits_16[7]  <= Shift_Bits_Length_In[4] ? Data_In[23] : Data_In[7];
                    Shift_Rotate_Bits_16[8]  <= Shift_Bits_Length_In[4] ? Data_In[24] : Data_In[8];
                    Shift_Rotate_Bits_16[9]  <= Shift_Bits_Length_In[4] ? Data_In[25] : Data_In[9];
                    Shift_Rotate_Bits_16[10] <= Shift_Bits_Length_In[4] ? Data_In[26] : Data_In[10];
                    Shift_Rotate_Bits_16[11] <= Shift_Bits_Length_In[4] ? Data_In[27] : Data_In[11];
                    Shift_Rotate_Bits_16[12] <= Shift_Bits_Length_In[4] ? Data_In[28] : Data_In[12];
                    Shift_Rotate_Bits_16[13] <= Shift_Bits_Length_In[4] ? Data_In[29] : Data_In[13];
                    Shift_Rotate_Bits_16[14] <= Shift_Bits_Length_In[4] ? Data_In[30] : Data_In[14];
                    Shift_Rotate_Bits_16[15] <= Shift_Bits_Length_In[4] ? Data_In[31] : Data_In[15];
                    Shift_Rotate_Bits_16[16] <= Shift_Bits_Length_In[4] ? Carry_In    : Data_In[16];
                    Shift_Rotate_Bits_16[17] <= Shift_Bits_Length_In[4] ? Data_In[0]  : Data_In[17];
                    Shift_Rotate_Bits_16[18] <= Shift_Bits_Length_In[4] ? Data_In[1]  : Data_In[18];
                    Shift_Rotate_Bits_16[19] <= Shift_Bits_Length_In[4] ? Data_In[2]  : Data_In[19];
                    Shift_Rotate_Bits_16[20] <= Shift_Bits_Length_In[4] ? Data_In[3]  : Data_In[20];
                    Shift_Rotate_Bits_16[21] <= Shift_Bits_Length_In[4] ? Data_In[4]  : Data_In[21];
                    Shift_Rotate_Bits_16[22] <= Shift_Bits_Length_In[4] ? Data_In[5]  : Data_In[22];
                    Shift_Rotate_Bits_16[23] <= Shift_Bits_Length_In[4] ? Data_In[6]  : Data_In[23];
                    Shift_Rotate_Bits_16[24] <= Shift_Bits_Length_In[4] ? Data_In[7]  : Data_In[24];
                    Shift_Rotate_Bits_16[25] <= Shift_Bits_Length_In[4] ? Data_In[8]  : Data_In[25];
                    Shift_Rotate_Bits_16[26] <= Shift_Bits_Length_In[4] ? Data_In[9]  : Data_In[26];
                    Shift_Rotate_Bits_16[27] <= Shift_Bits_Length_In[4] ? Data_In[10] : Data_In[27];
                    Shift_Rotate_Bits_16[28] <= Shift_Bits_Length_In[4] ? Data_In[11] : Data_In[28];
                    Shift_Rotate_Bits_16[29] <= Shift_Bits_Length_In[4] ? Data_In[12] : Data_In[29];
                    Shift_Rotate_Bits_16[30] <= Shift_Bits_Length_In[4] ? Data_In[13] : Data_In[30];
                    Shift_Rotate_Bits_16[31] <= Shift_Bits_Length_In[4] ? Data_In[14] : Data_In[31];
                    Shift_Rotate_Bits_16[32] <= Shift_Bits_Length_In[4] ? Data_In[15] : Carry_In;

                    // Shift 8-Bits
                    Shift_Rotate_Bits_8[0]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[8]  : Shift_Rotate_Bits_16[0];
                    Shift_Rotate_Bits_8[1]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[9]  : Shift_Rotate_Bits_16[1];
                    Shift_Rotate_Bits_8[2]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[10] : Shift_Rotate_Bits_16[2];
                    Shift_Rotate_Bits_8[3]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[11] : Shift_Rotate_Bits_16[3];
                    Shift_Rotate_Bits_8[4]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[12] : Shift_Rotate_Bits_16[4];
                    Shift_Rotate_Bits_8[5]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[13] : Shift_Rotate_Bits_16[5];
                    Shift_Rotate_Bits_8[6]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[14] : Shift_Rotate_Bits_16[6];
                    Shift_Rotate_Bits_8[7]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[15] : Shift_Rotate_Bits_16[7];
                    Shift_Rotate_Bits_8[8]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[16] : Shift_Rotate_Bits_16[8];
                    Shift_Rotate_Bits_8[9]  <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[17] : Shift_Rotate_Bits_16[9];
                    Shift_Rotate_Bits_8[10] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[18] : Shift_Rotate_Bits_16[10];
                    Shift_Rotate_Bits_8[11] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[19] : Shift_Rotate_Bits_16[11];
                    Shift_Rotate_Bits_8[12] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[20] : Shift_Rotate_Bits_16[12];
                    Shift_Rotate_Bits_8[13] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[21] : Shift_Rotate_Bits_16[13];
                    Shift_Rotate_Bits_8[14] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[22] : Shift_Rotate_Bits_16[14];
                    Shift_Rotate_Bits_8[15] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[23] : Shift_Rotate_Bits_16[15];
                    Shift_Rotate_Bits_8[16] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[24] : Shift_Rotate_Bits_16[16];
                    Shift_Rotate_Bits_8[17] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[25] : Shift_Rotate_Bits_16[17];
                    Shift_Rotate_Bits_8[18] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[26] : Shift_Rotate_Bits_16[18];
                    Shift_Rotate_Bits_8[19] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[27] : Shift_Rotate_Bits_16[19];
                    Shift_Rotate_Bits_8[20] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[28] : Shift_Rotate_Bits_16[20];
                    Shift_Rotate_Bits_8[21] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[29] : Shift_Rotate_Bits_16[21];
                    Shift_Rotate_Bits_8[22] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[30] : Shift_Rotate_Bits_16[22];
                    Shift_Rotate_Bits_8[23] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[31] : Shift_Rotate_Bits_16[23];
                    Shift_Rotate_Bits_8[24] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[32] : Shift_Rotate_Bits_16[24];
                    Shift_Rotate_Bits_8[25] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[0]  : Shift_Rotate_Bits_16[25];
                    Shift_Rotate_Bits_8[26] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[1]  : Shift_Rotate_Bits_16[26];
                    Shift_Rotate_Bits_8[27] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[2]  : Shift_Rotate_Bits_16[27];
                    Shift_Rotate_Bits_8[28] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[3]  : Shift_Rotate_Bits_16[28];
                    Shift_Rotate_Bits_8[29] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[4]  : Shift_Rotate_Bits_16[29];
                    Shift_Rotate_Bits_8[30] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[5]  : Shift_Rotate_Bits_16[30];
                    Shift_Rotate_Bits_8[31] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[6]  : Shift_Rotate_Bits_16[31];
                    Shift_Rotate_Bits_8[32] <= Shift_Bits_Length_In[3] ? Shift_Rotate_Bits_16[7]  : Shift_Rotate_Bits_16[32];

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
                    Shift_Rotate_Bits_4[13] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[17] : Shift_Rotate_Bits_8[13];
                    Shift_Rotate_Bits_4[14] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[18] : Shift_Rotate_Bits_8[14];
                    Shift_Rotate_Bits_4[15] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[19] : Shift_Rotate_Bits_8[15];
                    Shift_Rotate_Bits_4[16] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[20] : Shift_Rotate_Bits_8[16];
                    Shift_Rotate_Bits_4[17] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[21] : Shift_Rotate_Bits_8[17];
                    Shift_Rotate_Bits_4[18] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[22] : Shift_Rotate_Bits_8[18];
                    Shift_Rotate_Bits_4[19] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[23] : Shift_Rotate_Bits_8[19];
                    Shift_Rotate_Bits_4[20] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[24] : Shift_Rotate_Bits_8[20];
                    Shift_Rotate_Bits_4[21] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[25] : Shift_Rotate_Bits_8[21];
                    Shift_Rotate_Bits_4[22] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[26] : Shift_Rotate_Bits_8[22];
                    Shift_Rotate_Bits_4[23] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[27] : Shift_Rotate_Bits_8[23];
                    Shift_Rotate_Bits_4[24] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[28] : Shift_Rotate_Bits_8[24];
                    Shift_Rotate_Bits_4[25] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[29] : Shift_Rotate_Bits_8[25];
                    Shift_Rotate_Bits_4[26] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[30] : Shift_Rotate_Bits_8[26];
                    Shift_Rotate_Bits_4[27] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[31] : Shift_Rotate_Bits_8[27];
                    Shift_Rotate_Bits_4[28] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[32] : Shift_Rotate_Bits_8[28];
                    Shift_Rotate_Bits_4[29] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[0]  : Shift_Rotate_Bits_8[29];
                    Shift_Rotate_Bits_4[30] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[1]  : Shift_Rotate_Bits_8[30];
                    Shift_Rotate_Bits_4[31] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[2]  : Shift_Rotate_Bits_8[31];
                    Shift_Rotate_Bits_4[32] <= Shift_Bits_Length_In[2] ? Shift_Rotate_Bits_8[3]  : Shift_Rotate_Bits_8[32];

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
                    Shift_Rotate_Bits_2[15] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[17] : Shift_Rotate_Bits_4[15];
                    Shift_Rotate_Bits_2[16] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[18] : Shift_Rotate_Bits_4[16];
                    Shift_Rotate_Bits_2[17] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[19] : Shift_Rotate_Bits_4[17];
                    Shift_Rotate_Bits_2[18] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[20] : Shift_Rotate_Bits_4[18];
                    Shift_Rotate_Bits_2[19] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[21] : Shift_Rotate_Bits_4[19];
                    Shift_Rotate_Bits_2[20] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[22] : Shift_Rotate_Bits_4[20];
                    Shift_Rotate_Bits_2[21] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[23] : Shift_Rotate_Bits_4[21];
                    Shift_Rotate_Bits_2[22] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[24] : Shift_Rotate_Bits_4[22];
                    Shift_Rotate_Bits_2[23] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[25] : Shift_Rotate_Bits_4[23];
                    Shift_Rotate_Bits_2[24] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[26] : Shift_Rotate_Bits_4[24];
                    Shift_Rotate_Bits_2[25] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[27] : Shift_Rotate_Bits_4[25];
                    Shift_Rotate_Bits_2[26] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[28] : Shift_Rotate_Bits_4[26];
                    Shift_Rotate_Bits_2[27] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[29] : Shift_Rotate_Bits_4[27];
                    Shift_Rotate_Bits_2[28] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[30] : Shift_Rotate_Bits_4[28];
                    Shift_Rotate_Bits_2[29] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[31] : Shift_Rotate_Bits_4[29];
                    Shift_Rotate_Bits_2[30] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[32]  : Shift_Rotate_Bits_4[30];
                    Shift_Rotate_Bits_2[31] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[0]  : Shift_Rotate_Bits_4[31];
                    Shift_Rotate_Bits_2[32] <= Shift_Bits_Length_In[1] ? Shift_Rotate_Bits_4[1]  : Shift_Rotate_Bits_4[32];

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
                    Shift_Rotate_Bits_1[16] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[17] : Shift_Rotate_Bits_2[16];
                    Shift_Rotate_Bits_1[17] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[18] : Shift_Rotate_Bits_2[17];
                    Shift_Rotate_Bits_1[18] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[19] : Shift_Rotate_Bits_2[18];
                    Shift_Rotate_Bits_1[19] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[20] : Shift_Rotate_Bits_2[19];
                    Shift_Rotate_Bits_1[20] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[21] : Shift_Rotate_Bits_2[20];
                    Shift_Rotate_Bits_1[21] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[22] : Shift_Rotate_Bits_2[21];
                    Shift_Rotate_Bits_1[22] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[23] : Shift_Rotate_Bits_2[22];
                    Shift_Rotate_Bits_1[23] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[24] : Shift_Rotate_Bits_2[23];
                    Shift_Rotate_Bits_1[24] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[25] : Shift_Rotate_Bits_2[24];
                    Shift_Rotate_Bits_1[25] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[26] : Shift_Rotate_Bits_2[25];
                    Shift_Rotate_Bits_1[26] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[27] : Shift_Rotate_Bits_2[26];
                    Shift_Rotate_Bits_1[27] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[28] : Shift_Rotate_Bits_2[27];
                    Shift_Rotate_Bits_1[28] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[29] : Shift_Rotate_Bits_2[28];
                    Shift_Rotate_Bits_1[29] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[30] : Shift_Rotate_Bits_2[29];
                    Shift_Rotate_Bits_1[30] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[31] : Shift_Rotate_Bits_2[30];
                    Shift_Rotate_Bits_1[31] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[32]  : Shift_Rotate_Bits_2[31];
                    Shift_Rotate_Bits_1[32] <= Shift_Bits_Length_In[0] ? Shift_Rotate_Bits_2[0]  : Shift_Rotate_Bits_2[32];
                end
    
            default: 
                begin
                    Shift_Rotate_Bits_16 <= 33'b0;
                    Shift_Rotate_Bits_8  <= 33'b0;
                    Shift_Rotate_Bits_4  <= 33'b0;
                    Shift_Rotate_Bits_2  <= 33'b0;
                    Shift_Rotate_Bits_1  <= 33'b0;
                end
        endcase
    end



endmodule
