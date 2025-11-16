/*
--------------------------------------------------
Module :
--------------------------------------------------
Adder_with_Look_Ahead_Carry_Generator_8_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 8-Bit Look Ahead Carry Generator.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Adder_with_Look_Ahead_Carry_Generator_8_Bit (
    input        Enable_In,

    input  [7:0] Data_A_In,
    input  [7:0] Data_B_In,
    input        Carry_In,

    output [7:0] Sum_Out,
    output       Carry_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire [8:0] Adder_Result;

wire [7:0] P;
wire [7:0] G;
wire [7:0] C;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Carry_Out = Enable_In ? Adder_Result[8]   : 1'bZ;
assign Sum_Out   = Enable_In ? Adder_Result[7:0] : 8'bZ;



// --------------------------------------------------
// Carry Propogate
// --------------------------------------------------
assign P[0] = Data_A_In[0] ^ Data_B_In[0];
assign P[1] = Data_A_In[1] ^ Data_B_In[1];
assign P[2] = Data_A_In[2] ^ Data_B_In[2];
assign P[3] = Data_A_In[3] ^ Data_B_In[3];
assign P[4] = Data_A_In[4] ^ Data_B_In[4];
assign P[5] = Data_A_In[5] ^ Data_B_In[5];
assign P[6] = Data_A_In[6] ^ Data_B_In[6];
assign P[7] = Data_A_In[7] ^ Data_B_In[7];



// --------------------------------------------------
// Carry Generate
// --------------------------------------------------
assign G[0] = Data_A_In[0] & Data_B_In[0];
assign G[1] = Data_A_In[1] & Data_B_In[1];
assign G[2] = Data_A_In[2] & Data_B_In[2];
assign G[3] = Data_A_In[3] & Data_B_In[3];
assign G[4] = Data_A_In[4] & Data_B_In[4];
assign G[5] = Data_A_In[5] & Data_B_In[5];
assign G[6] = Data_A_In[6] & Data_B_In[6];
assign G[7] = Data_A_In[7] & Data_B_In[7];



// --------------------------------------------------
// Look Ahead Carry Generator - 8-Bit Logic
// --------------------------------------------------
assign C[0] = (P[0] & Carry_In) + G[0];
assign C[1] = (P[1] & ((P[0] & Carry_In) + G[0])) + G[1];
assign C[2] = (P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2];
assign C[3] = (P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3];
assign C[4] = (P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4];
assign C[5] = (P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5];
assign C[6] = (P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6];
assign C[7] = (P[7] & ((P[6] & ((P[5] & ((P[4] & ((P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3])) + G[4])) + G[5])) + G[6])) + G[7];


assign Adder_Result[0] = P[0] ^ Carry_In;
assign Adder_Result[1] = P[1] ^ C[0];
assign Adder_Result[2] = P[2] ^ C[1];
assign Adder_Result[3] = P[3] ^ C[2];
assign Adder_Result[4] = P[4] ^ C[3];
assign Adder_Result[5] = P[5] ^ C[4];
assign Adder_Result[6] = P[6] ^ C[5];
assign Adder_Result[7] = P[7] ^ C[6];
assign Adder_Result[8] = C[7];





endmodule
