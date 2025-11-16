/*
--------------------------------------------------
Module :
--------------------------------------------------
Adder_with_Look_Ahead_Carry_Generator_4_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 4-Bit Look Ahead Carry Generator.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Adder_with_Look_Ahead_Carry_Generator_4_Bit (
    input        Enable_In,

    input  [3:0] Data_A_In,
    input  [3:0] Data_B_In,
    input        Carry_In,

    output [3:0] Sum_Out,
    output       Carry_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire [4:0] Adder_Result;

wire [3:0] P;
wire [3:0] G;
wire [3:0] C;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Carry_Out = Enable_In ? Adder_Result[4]   : 1'bZ;
assign Sum_Out   = Enable_In ? Adder_Result[3:0] : 4'bZ;



// --------------------------------------------------
// Carry Propogate
// --------------------------------------------------
assign P[0] = Data_A_In[0] ^ Data_B_In[0];
assign P[1] = Data_A_In[1] ^ Data_B_In[1];
assign P[2] = Data_A_In[2] ^ Data_B_In[2];
assign P[3] = Data_A_In[3] ^ Data_B_In[3];



// --------------------------------------------------
// Carry Generate
// --------------------------------------------------
assign G[0] = Data_A_In[0] & Data_B_In[0];
assign G[1] = Data_A_In[1] & Data_B_In[1];
assign G[2] = Data_A_In[2] & Data_B_In[2];
assign G[3] = Data_A_In[3] & Data_B_In[3];



// --------------------------------------------------
// Look Ahead Carry Generator - 4-Bit Logic
// --------------------------------------------------
assign C[0] = (P[0] & Carry_In) + G[0];
assign C[1] = (P[1] & ((P[0] & Carry_In) + G[0])) + G[1];
assign C[2] = (P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2];
assign C[3] = (P[3] & ((P[2] & ((P[1] & ((P[0] & Carry_In) + G[0])) + G[1])) + G[2])) + G[3];


assign Adder_Result[0] = P[0] ^ Carry_In;
assign Adder_Result[1] = P[1] ^ C[0];
assign Adder_Result[2] = P[2] ^ C[1];
assign Adder_Result[3] = P[3] ^ C[2];
assign Adder_Result[4] = C[3];





endmodule
