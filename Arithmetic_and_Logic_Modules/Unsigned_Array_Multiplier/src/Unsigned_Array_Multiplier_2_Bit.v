/*
--------------------------------------------------
Module :
--------------------------------------------------
Unsigned_Array_Multiplier_2_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 2-Bit Unsigned Array Multiplier.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Unsigned_Array_Multiplier_2_Bit (
    input        Enable_In,

    input  [1:0] Data_A_In,
    input  [1:0] Data_B_In,

    output [3:0] Multiplied_Result_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
// Sub-Products
wire [3:0] Sub_Products [1:0];


// Additions
wire [3:0] Addition_0;



// --------------------------------------------------
// Sub-Products
// --------------------------------------------------
assign Sub_Products[0] = Data_B_In[0] ? (Data_A_In)      : 2'b0;
assign Sub_Products[1] = Data_B_In[1] ? (Data_A_In << 1) : 2'b0;



// --------------------------------------------------
// Adders
// --------------------------------------------------
assign Addition_0 = Sub_Products[0] + Sub_Products[1];



// --------------------------------------------------
// Final Result
// --------------------------------------------------
assign Multiplied_Result_Out = Enable_In ? Addition_0 : 4'bZ;



endmodule
