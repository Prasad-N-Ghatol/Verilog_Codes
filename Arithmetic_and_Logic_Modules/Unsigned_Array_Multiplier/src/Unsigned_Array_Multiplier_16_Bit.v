/*
--------------------------------------------------
Module :
--------------------------------------------------
Unsigned_Array_Multiplier_16_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16-Bit Unsigned Array Multiplier.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Unsigned_Array_Multiplier_16_Bit (
    input         Enable_In,

    input  [15:0] Data_A_In,
    input  [15:0] Data_B_In,

    output [31:0] Multiplied_Result_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
// Sub-Products
wire [31:0] Sub_Products [15:0];


// Additions
wire [31:0] Addition_0 [7:0];
wire [31:0] Addition_1 [3:0];
wire [31:0] Addition_2 [1:0];
wire [31:0] Addition_3;



// --------------------------------------------------
// Sub-Products
// --------------------------------------------------
assign Sub_Products[0]  = Data_B_In[0]  ? (Data_A_In)       : 32'b0;
assign Sub_Products[1]  = Data_B_In[1]  ? (Data_A_In << 1)  : 32'b0;
assign Sub_Products[2]  = Data_B_In[2]  ? (Data_A_In << 2)  : 32'b0;
assign Sub_Products[3]  = Data_B_In[3]  ? (Data_A_In << 3)  : 32'b0;
assign Sub_Products[4]  = Data_B_In[4]  ? (Data_A_In << 4)  : 32'b0;
assign Sub_Products[5]  = Data_B_In[5]  ? (Data_A_In << 5)  : 32'b0;
assign Sub_Products[6]  = Data_B_In[6]  ? (Data_A_In << 6)  : 32'b0;
assign Sub_Products[7]  = Data_B_In[7]  ? (Data_A_In << 7)  : 32'b0;

assign Sub_Products[8]  = Data_B_In[8]  ? (Data_A_In << 8)  : 32'b0;
assign Sub_Products[9]  = Data_B_In[9]  ? (Data_A_In << 9)  : 32'b0;
assign Sub_Products[10] = Data_B_In[10] ? (Data_A_In << 10) : 32'b0;
assign Sub_Products[11] = Data_B_In[11] ? (Data_A_In << 11) : 32'b0;
assign Sub_Products[12] = Data_B_In[12] ? (Data_A_In << 12) : 32'b0;
assign Sub_Products[13] = Data_B_In[13] ? (Data_A_In << 13) : 32'b0;
assign Sub_Products[14] = Data_B_In[14] ? (Data_A_In << 14) : 32'b0;
assign Sub_Products[15] = Data_B_In[15] ? (Data_A_In << 15) : 32'b0;



// --------------------------------------------------
// Adders
// --------------------------------------------------
assign Addition_0[0] = Sub_Products[0]  + Sub_Products[1];
assign Addition_0[1] = Sub_Products[2]  + Sub_Products[3];
assign Addition_0[2] = Sub_Products[4]  + Sub_Products[5];
assign Addition_0[3] = Sub_Products[6]  + Sub_Products[7];
assign Addition_0[4] = Sub_Products[8]  + Sub_Products[9];
assign Addition_0[5] = Sub_Products[10] + Sub_Products[11];
assign Addition_0[6] = Sub_Products[12] + Sub_Products[13];
assign Addition_0[7] = Sub_Products[14] + Sub_Products[15];


assign Addition_1[0] = Addition_0[0] + Addition_0[1];
assign Addition_1[1] = Addition_0[2] + Addition_0[3];
assign Addition_1[2] = Addition_0[4] + Addition_0[5];
assign Addition_1[3] = Addition_0[6] + Addition_0[7];


assign Addition_2[0] = Addition_1[0] + Addition_1[1];
assign Addition_2[1] = Addition_1[2] + Addition_1[3];


assign Addition_3 = Addition_2[0] + Addition_2[1];



// --------------------------------------------------
// Final Result
// --------------------------------------------------
assign Multiplied_Result_Out = Enable_In ? Addition_3 : 32'bZ;



endmodule
