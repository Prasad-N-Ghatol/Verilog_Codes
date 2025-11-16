/*
--------------------------------------------------
Module :
--------------------------------------------------
Full_Adder


--------------------------------------------------
Description :
--------------------------------------------------
A Full Adder implementation.

Inputs are three 1-bit data.
Outputs consists of the Carry and Sum values.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Full_Adder (
    input   Data_A_In,
    input   Data_B_In,
    input   Carry_In,

    output  Carry_Out,
    output  Sum_Out
);



// --------------------------------------------------
// Full_Adder Logic
// --------------------------------------------------
assign Carry_Out = (Data_A_In & Data_B_In) | (Data_B_In & Carry_In) | (Data_A_In & Carry_In);

assign Sum_Out   = Data_A_In ^ Data_B_In ^ Carry_In;



endmodule
