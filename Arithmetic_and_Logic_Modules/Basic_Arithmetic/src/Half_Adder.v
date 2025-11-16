/*
--------------------------------------------------
Module :
--------------------------------------------------
Half_Adder


--------------------------------------------------
Description :
--------------------------------------------------
A Half Adder implementation.

Inputs are two 1-bit data.
Outputs consists of two 1-bit values, Carry and Sum values.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Half_Adder (
    input   Data_A_In,
    input   Data_B_In,

    output  Carry_Out,
    output  Sum_Out
);



// --------------------------------------------------
// Half_Adder Logic
// --------------------------------------------------
assign Carry_Out = Data_A_In & Data_B_In;

assign Sum_Out   = Data_A_In ^ Data_B_In;



endmodule
