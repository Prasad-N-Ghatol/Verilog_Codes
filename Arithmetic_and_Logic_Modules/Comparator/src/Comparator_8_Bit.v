/*
--------------------------------------------------
Module :
--------------------------------------------------
Comparator_8_Bit


--------------------------------------------------
Description :
--------------------------------------------------
A Comparator module, to compare between two inputs, and produce 3 output:
    Greater than, 
    Equal to, 
    Less than.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Comparator_8_Bit (
    input        Enable_In,

    input  [7:0] Data_A_In,
    input  [7:0] Data_B_In,

    output       A_gt_B_Out,
    output       A_eq_B_Out,
    output       A_lt_B_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire A_gt_B;
wire A_eq_B;
wire A_lt_B;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign A_gt_B_Out = Enable_In ? A_gt_B : 1'bZ;
assign A_eq_B_Out = Enable_In ? A_eq_B : 1'bZ;
assign A_lt_B_Out = Enable_In ? A_lt_B : 1'bZ;



// --------------------------------------------------
// Comparator_8_Bit Logic
// --------------------------------------------------
// Greater than
assign A_gt_B = (Data_A_In  > Data_B_In) ? 1'b1 : 1'b0;

// Equal to
assign A_eq_B = (Data_A_In == Data_B_In) ? 1'b1 : 1'b0;

// Less than
assign A_lt_B = (Data_A_In  < Data_B_In) ? 1'b1 : 1'b0;



endmodule
