/*
--------------------------------------------------
Module :
--------------------------------------------------
Full_Subtractor


--------------------------------------------------
Description :
--------------------------------------------------
A Full Subtractor implementation.

Inputs are three 1-bit data.
Outputs consists of the Borrow and Sum values.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Full_Subtractor (
    input   Data_A_In,
    input   Data_B_In,
    input   Borrow_In,

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
// Full_Subtractor Logic
// --------------------------------------------------
assign Borrow_Out = (Complement_A_w & Data_B_In) | (Data_B_In & Borrow_In) | (Complement_A_w & Borrow_In);

assign Sum_Out   = Data_A_In ^ Data_B_In ^ Borrow_In;



endmodule
