/*
--------------------------------------------------
Module :
--------------------------------------------------
Unsigned_Array_Multiplier_8_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 8-Bit Unsigned Array Multiplier.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Unsigned_Array_Multiplier_8_Bit (
    input         Enable_In,

    input  [7:0]  Data_A_In,
    input  [7:0]  Data_B_In,

    output [15:0] Multiplied_Result_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
// Sub-Products
wire [15:0] Sub_Products [7:0];


// Additions
wire [15:0] Addition_0 [3:0];
wire [15:0] Addition_1 [1:0];
wire [15:0] Addition_2;



// --------------------------------------------------
// Sub-Products
// --------------------------------------------------
assign Sub_Products[0] = Data_B_In[0] ? (Data_A_In)      : 16'b0;
assign Sub_Products[1] = Data_B_In[1] ? (Data_A_In << 1) : 16'b0;
assign Sub_Products[2] = Data_B_In[2] ? (Data_A_In << 2) : 16'b0;
assign Sub_Products[3] = Data_B_In[3] ? (Data_A_In << 3) : 16'b0;
assign Sub_Products[4] = Data_B_In[4] ? (Data_A_In << 4) : 16'b0;
assign Sub_Products[5] = Data_B_In[5] ? (Data_A_In << 5) : 16'b0;
assign Sub_Products[6] = Data_B_In[6] ? (Data_A_In << 6) : 16'b0;
assign Sub_Products[7] = Data_B_In[7] ? (Data_A_In << 7) : 16'b0;



// --------------------------------------------------
// Adders
// --------------------------------------------------
assign Addition_0[0] = Sub_Products[0] + Sub_Products[1];
assign Addition_0[1] = Sub_Products[2] + Sub_Products[3];
assign Addition_0[2] = Sub_Products[4] + Sub_Products[5];
assign Addition_0[3] = Sub_Products[6] + Sub_Products[7];


assign Addition_1[0] = Addition_0[0] + Addition_0[1];
assign Addition_1[1] = Addition_0[2] + Addition_0[3];


assign Addition_2 = Addition_1[0] + Addition_1[1];



// --------------------------------------------------
// Final Result
// --------------------------------------------------
assign Multiplied_Result_Out = Enable_In ? Addition_2 : 16'bZ;



endmodule
