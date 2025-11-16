/*
--------------------------------------------------
Module :
--------------------------------------------------
Half_Subtractor


--------------------------------------------------
Description :
--------------------------------------------------
A Half Subtractor implementation.

Inputs are two 1-bit data.
Outputs consists of the Borrow and Sum values.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Half_Subtractor (
    input   Data_A_In,
    input   Data_B_In,

    output  Borrow_Out,
    output  Sum_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire Complement_A_w;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Complement_A_w = ~Data_A_In;



// --------------------------------------------------
// Half_Subtractor Logic
// --------------------------------------------------
assign Borrow_Out = Complement_A_w & Data_B_In;

assign Sum_Out    = Data_A_In ^ Data_B_In;



endmodule
