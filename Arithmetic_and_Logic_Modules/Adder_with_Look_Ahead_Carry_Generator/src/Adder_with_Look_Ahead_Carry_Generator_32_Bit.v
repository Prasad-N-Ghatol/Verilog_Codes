/*
--------------------------------------------------
Module :
--------------------------------------------------
Adder_with_Look_Ahead_Carry_Generator_32_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 32-Bit Look Ahead Carry Generator.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Adder_with_Look_Ahead_Carry_Generator_32_Bit (
    input         Enable_In,

    input  [31:0] Data_A_In,
    input  [31:0] Data_B_In,
    input         Carry_In,

    output [31:0] Sum_Out,
    output        Carry_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire [32:0] Adder_Result;

wire [31:0] P;
wire [31:0] G;
wire [31:0] C;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Carry_Out = Enable_In ? Adder_Result[32]   : 1'bZ;
assign Sum_Out   = Enable_In ? Adder_Result[31:0] : 32'bZ;



// --------------------------------------------------
// Carry Propogate
// --------------------------------------------------
assign P[0]  = Data_A_In[0]  ^ Data_B_In[0];
assign P[1]  = Data_A_In[1]  ^ Data_B_In[1];
assign P[2]  = Data_A_In[2]  ^ Data_B_In[2];
assign P[3]  = Data_A_In[3]  ^ Data_B_In[3];
assign P[4]  = Data_A_In[4]  ^ Data_B_In[4];
assign P[5]  = Data_A_In[5]  ^ Data_B_In[5];
assign P[6]  = Data_A_In[6]  ^ Data_B_In[6];
assign P[7]  = Data_A_In[7]  ^ Data_B_In[7];

assign P[8]  = Data_A_In[8]  ^ Data_B_In[8];
assign P[9]  = Data_A_In[9]  ^ Data_B_In[9];
assign P[10] = Data_A_In[10] ^ Data_B_In[10];
assign P[11] = Data_A_In[11] ^ Data_B_In[11];
assign P[12] = Data_A_In[12] ^ Data_B_In[12];
assign P[13] = Data_A_In[13] ^ Data_B_In[13];
assign P[14] = Data_A_In[14] ^ Data_B_In[14];
assign P[15] = Data_A_In[15] ^ Data_B_In[15];

assign P[16] = Data_A_In[16] ^ Data_B_In[16];
assign P[17] = Data_A_In[17] ^ Data_B_In[17];
assign P[18] = Data_A_In[18] ^ Data_B_In[18];
assign P[19] = Data_A_In[19] ^ Data_B_In[19];
assign P[20] = Data_A_In[20] ^ Data_B_In[20];
assign P[21] = Data_A_In[21] ^ Data_B_In[21];
assign P[22] = Data_A_In[22] ^ Data_B_In[22];
assign P[23] = Data_A_In[23] ^ Data_B_In[23];

assign P[24] = Data_A_In[24] ^ Data_B_In[24];
assign P[25] = Data_A_In[25] ^ Data_B_In[25];
assign P[26] = Data_A_In[26] ^ Data_B_In[26];
assign P[27] = Data_A_In[27] ^ Data_B_In[27];
assign P[28] = Data_A_In[28] ^ Data_B_In[28];
assign P[29] = Data_A_In[29] ^ Data_B_In[29];
assign P[30] = Data_A_In[30] ^ Data_B_In[30];
assign P[31] = Data_A_In[31] ^ Data_B_In[31];



// --------------------------------------------------
// Carry Generate
// --------------------------------------------------
assign G[0]  = Data_A_In[0]  & Data_B_In[0];
assign G[1]  = Data_A_In[1]  & Data_B_In[1];
assign G[2]  = Data_A_In[2]  & Data_B_In[2];
assign G[3]  = Data_A_In[3]  & Data_B_In[3];
assign G[4]  = Data_A_In[4]  & Data_B_In[4];
assign G[5]  = Data_A_In[5]  & Data_B_In[5];
assign G[6]  = Data_A_In[6]  & Data_B_In[6];
assign G[7]  = Data_A_In[7]  & Data_B_In[7];

assign G[8]  = Data_A_In[8]  & Data_B_In[8];
assign G[9]  = Data_A_In[9]  & Data_B_In[9];
assign G[10] = Data_A_In[10] & Data_B_In[10];
assign G[11] = Data_A_In[11] & Data_B_In[11];
assign G[12] = Data_A_In[12] & Data_B_In[12];
assign G[13] = Data_A_In[13] & Data_B_In[13];
assign G[14] = Data_A_In[14] & Data_B_In[14];
assign G[15] = Data_A_In[15] & Data_B_In[15];

assign G[16] = Data_A_In[16] & Data_B_In[16];
assign G[17] = Data_A_In[17] & Data_B_In[17];
assign G[18] = Data_A_In[18] & Data_B_In[18];
assign G[19] = Data_A_In[19] & Data_B_In[19];
assign G[20] = Data_A_In[20] & Data_B_In[20];
assign G[21] = Data_A_In[21] & Data_B_In[21];
assign G[22] = Data_A_In[22] & Data_B_In[22];
assign G[23] = Data_A_In[23] & Data_B_In[23];

assign G[24] = Data_A_In[24] & Data_B_In[24];
assign G[25] = Data_A_In[25] & Data_B_In[25];
assign G[26] = Data_A_In[26] & Data_B_In[26];
assign G[27] = Data_A_In[27] & Data_B_In[27];
assign G[28] = Data_A_In[28] & Data_B_In[28];
assign G[29] = Data_A_In[29] & Data_B_In[29];
assign G[30] = Data_A_In[30] & Data_B_In[30];
assign G[31] = Data_A_In[31] & Data_B_In[31];



// --------------------------------------------------
// Look Ahead Carry Generator - 32-Bit Logic
// --------------------------------------------------
assign C[0] = (P[0] & Carry_In) + G[0];
assign C[1] = (P[1] & ((P[0] & Carry_In) + G[0])) + G[1];
assign C[2] = (P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2];
assign C[3] = (P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3];
assign C[4] = (P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4];
assign C[5] = (P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5];
assign C[6] = (P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6];
assign C[7] = (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7];

assign C[8] = (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8];
assign C[9] = (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9];
assign C[10] = (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10];
assign C[11] = (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11];
assign C[12] = (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12];
assign C[13] = (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13];
assign C[14] = (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14];
assign C[15] = (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15];

assign C[16] = (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16];
assign C[17] = (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17];
assign C[18] = (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18];
assign C[19] = (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19];
assign C[20] = (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20];
assign C[21] = (P[21] & (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20]) + G[21];
assign C[22] = (P[22] & (P[21] & (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20]) + G[21]) + G[22];
assign C[23] = (P[23] &(P[22] & (P[21] & (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20]) + G[21]) + G[22]) + G[23];

assign C[24] = (P[24] & (P[23] &(P[22] & (P[21] & (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20]) + G[21]) + G[22]) + G[23]) + G[24];
assign C[25] = (P[25] & (P[24] & (P[23] &(P[22] & (P[21] & (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20]) + G[21]) + G[22]) + G[23]) + G[24]) + G[25];
assign C[26] = (P[26] & (P[25] & (P[24] & (P[23] &(P[22] & (P[21] & (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20]) + G[21]) + G[22]) + G[23]) + G[24]) + G[25]) + G[26];
assign C[27] = (P[27] & (P[26] & (P[25] & (P[24] & (P[23] &(P[22] & (P[21] & (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20]) + G[21]) + G[22]) + G[23]) + G[24]) + G[25]) + G[26]) + G[27];
assign C[28] = (P[28] & (P[27] & (P[26] & (P[25] & (P[24] & (P[23] &(P[22] & (P[21] & (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20]) + G[21]) + G[22]) + G[23]) + G[24]) + G[25]) + G[26]) + G[27]) + G[28];
assign C[29] = (P[29] & (P[28] & (P[27] & (P[26] & (P[25] & (P[24] & (P[23] &(P[22] & (P[21] & (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20]) + G[21]) + G[22]) + G[23]) + G[24]) + G[25]) + G[26]) + G[27]) + G[28]) + G[29];
assign C[30] = (P[30] & (P[29] & (P[28] & (P[27] & (P[26] & (P[25] & (P[24] & (P[23] &(P[22] & (P[21] & (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20]) + G[21]) + G[22]) + G[23]) + G[24]) + G[25]) + G[26]) + G[27]) + G[28]) + G[29]) + G[30];
assign C[31] = (P[31] & (P[30] & (P[29] & (P[28] & (P[27] & (P[26] & (P[25] & (P[24] & (P[23] &(P[22] & (P[21] & (P[20] & (P[19] & (P[18] &  (P[17] & (P[16] & (P[15] & (P[14] & (P[13] & (P[12] & (P[11] & (P[10] & (P[9] & (P[8] & (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7]) + G[8]) + G[9]) + G[10]) + G[11]) + G[12]) + G[13]) + G[14]) + G[15]) + G[16]) + G[17]) + G[18]) + G[19]) + G[20]) + G[21]) + G[22]) + G[23]) + G[24]) + G[25]) + G[26]) + G[27]) + G[28]) + G[29]) + G[30]) + G[31];


assign Adder_Result[0]  = P[0]  ^ Carry_In;
assign Adder_Result[1]  = P[1]  ^ C[0];
assign Adder_Result[2]  = P[2]  ^ C[1];
assign Adder_Result[3]  = P[3]  ^ C[2];
assign Adder_Result[4]  = P[4]  ^ C[3];
assign Adder_Result[5]  = P[5]  ^ C[4];
assign Adder_Result[6]  = P[6]  ^ C[5];
assign Adder_Result[7]  = P[7]  ^ C[6];
assign Adder_Result[8]  = P[8]  ^ C[7];
assign Adder_Result[9]  = P[9]  ^ C[8];
assign Adder_Result[10] = P[10] ^ C[9];
assign Adder_Result[11] = P[11] ^ C[10];
assign Adder_Result[12] = P[12] ^ C[11];
assign Adder_Result[13] = P[13] ^ C[12];
assign Adder_Result[14] = P[14] ^ C[13];
assign Adder_Result[15] = P[15] ^ C[14];
assign Adder_Result[16] = P[16] ^ C[15];
assign Adder_Result[17] = P[17] ^ C[16];
assign Adder_Result[18] = P[18] ^ C[17];
assign Adder_Result[19] = P[19] ^ C[18];
assign Adder_Result[20] = P[20] ^ C[19];
assign Adder_Result[21] = P[21] ^ C[20];
assign Adder_Result[22] = P[22] ^ C[21];
assign Adder_Result[23] = P[23] ^ C[22];
assign Adder_Result[24] = P[24] ^ C[23];
assign Adder_Result[25] = P[25] ^ C[24];
assign Adder_Result[26] = P[26] ^ C[25];
assign Adder_Result[27] = P[27] ^ C[26];
assign Adder_Result[28] = P[28] ^ C[27];
assign Adder_Result[29] = P[29] ^ C[28];
assign Adder_Result[30] = P[30] ^ C[29];
assign Adder_Result[31] = P[31] ^ C[30];
assign Adder_Result[32] = C[31];



endmodule
