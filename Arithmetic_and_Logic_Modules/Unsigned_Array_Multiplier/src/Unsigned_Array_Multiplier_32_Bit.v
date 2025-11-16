/*
--------------------------------------------------
Module :
--------------------------------------------------
Unsigned_Array_Multiplier_32_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 32-Bit Unsigned Array Multiplier.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Unsigned_Array_Multiplier_32_Bit (
    input         Enable_In,

    input  [31:0] Data_A_In,
    input  [31:0] Data_B_In,

    output [63:0] Multiplied_Result_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
// Sub-Products
wire [63:0] Sub_Products [31:0];


// Additions
wire [63:0] Addition_0 [15:0];
wire [63:0] Addition_1 [7:0];
wire [63:0] Addition_2 [3:0];
wire [63:0] Addition_3 [1:0];
wire [63:0] Addition_4;



// --------------------------------------------------
// Sub-Products
// --------------------------------------------------
assign Sub_Products[0]  = Data_B_In[0]  ? (Data_A_In)       : 64'b0;
assign Sub_Products[1]  = Data_B_In[1]  ? (Data_A_In << 1)  : 64'b0;
assign Sub_Products[2]  = Data_B_In[2]  ? (Data_A_In << 2)  : 64'b0;
assign Sub_Products[3]  = Data_B_In[3]  ? (Data_A_In << 3)  : 64'b0;
assign Sub_Products[4]  = Data_B_In[4]  ? (Data_A_In << 4)  : 64'b0;
assign Sub_Products[5]  = Data_B_In[5]  ? (Data_A_In << 5)  : 64'b0;
assign Sub_Products[6]  = Data_B_In[6]  ? (Data_A_In << 6)  : 64'b0;
assign Sub_Products[7]  = Data_B_In[7]  ? (Data_A_In << 7)  : 64'b0;

assign Sub_Products[8]  = Data_B_In[8]  ? (Data_A_In << 8)  : 64'b0;
assign Sub_Products[9]  = Data_B_In[9]  ? (Data_A_In << 9)  : 64'b0;
assign Sub_Products[10] = Data_B_In[10] ? (Data_A_In << 10) : 64'b0;
assign Sub_Products[11] = Data_B_In[11] ? (Data_A_In << 11) : 64'b0;
assign Sub_Products[12] = Data_B_In[12] ? (Data_A_In << 12) : 64'b0;
assign Sub_Products[13] = Data_B_In[13] ? (Data_A_In << 13) : 64'b0;
assign Sub_Products[14] = Data_B_In[14] ? (Data_A_In << 14) : 64'b0;
assign Sub_Products[15] = Data_B_In[15] ? (Data_A_In << 15) : 64'b0;

assign Sub_Products[16] = Data_B_In[16] ? (Data_A_In << 16) : 64'b0;
assign Sub_Products[17] = Data_B_In[17] ? (Data_A_In << 17) : 64'b0;
assign Sub_Products[18] = Data_B_In[18] ? (Data_A_In << 18) : 64'b0;
assign Sub_Products[19] = Data_B_In[19] ? (Data_A_In << 19) : 64'b0;
assign Sub_Products[20] = Data_B_In[20] ? (Data_A_In << 20) : 64'b0;
assign Sub_Products[21] = Data_B_In[21] ? (Data_A_In << 21) : 64'b0;
assign Sub_Products[22] = Data_B_In[22] ? (Data_A_In << 22) : 64'b0;
assign Sub_Products[23] = Data_B_In[23] ? (Data_A_In << 23) : 64'b0;

assign Sub_Products[24] = Data_B_In[24] ? (Data_A_In << 24) : 64'b0;
assign Sub_Products[25] = Data_B_In[25] ? (Data_A_In << 25) : 64'b0;
assign Sub_Products[26] = Data_B_In[26] ? (Data_A_In << 26) : 64'b0;
assign Sub_Products[27] = Data_B_In[27] ? (Data_A_In << 27) : 64'b0;
assign Sub_Products[28] = Data_B_In[28] ? (Data_A_In << 28) : 64'b0;
assign Sub_Products[29] = Data_B_In[29] ? (Data_A_In << 29) : 64'b0;
assign Sub_Products[30] = Data_B_In[30] ? (Data_A_In << 30) : 64'b0;
assign Sub_Products[31] = Data_B_In[31] ? (Data_A_In << 31) : 64'b0;



//--------------------------------------------------
// Adders
// --------------------------------------------------
assign Addition_0[0]  = Sub_Products[0]  + Sub_Products[1];
assign Addition_0[1]  = Sub_Products[2]  + Sub_Products[3];
assign Addition_0[2]  = Sub_Products[4]  + Sub_Products[5];
assign Addition_0[3]  = Sub_Products[6]  + Sub_Products[7];
assign Addition_0[4]  = Sub_Products[8]  + Sub_Products[9];
assign Addition_0[5]  = Sub_Products[10] + Sub_Products[11];
assign Addition_0[6]  = Sub_Products[12] + Sub_Products[13];
assign Addition_0[7]  = Sub_Products[14] + Sub_Products[15];

assign Addition_0[8]  = Sub_Products[16] + Sub_Products[17];
assign Addition_0[9]  = Sub_Products[18] + Sub_Products[19];
assign Addition_0[10] = Sub_Products[20] + Sub_Products[21];
assign Addition_0[11] = Sub_Products[22] + Sub_Products[23];
assign Addition_0[12] = Sub_Products[24] + Sub_Products[25];
assign Addition_0[13] = Sub_Products[26] + Sub_Products[27];
assign Addition_0[14] = Sub_Products[28] + Sub_Products[29];
assign Addition_0[15] = Sub_Products[30] + Sub_Products[31];


assign Addition_1[0] = Addition_0[0]  + Addition_0[1];
assign Addition_1[1] = Addition_0[2]  + Addition_0[3];
assign Addition_1[2] = Addition_0[4]  + Addition_0[5];
assign Addition_1[3] = Addition_0[6]  + Addition_0[7];
assign Addition_1[4] = Addition_0[8]  + Addition_0[9];
assign Addition_1[5] = Addition_0[10] + Addition_0[11];
assign Addition_1[6] = Addition_0[12] + Addition_0[13];
assign Addition_1[7] = Addition_0[14] + Addition_0[15];


assign Addition_2[0] = Addition_1[0] + Addition_1[1];
assign Addition_2[1] = Addition_1[2] + Addition_1[3];
assign Addition_2[2] = Addition_1[4] + Addition_1[5];
assign Addition_2[3] = Addition_1[6] + Addition_1[7];


assign Addition_3[0] = Addition_2[0] + Addition_2[1];
assign Addition_3[1] = Addition_2[2] + Addition_2[3];


assign Addition_4 = Addition_3[0] + Addition_3[1];



// --------------------------------------------------
// Final Result
// --------------------------------------------------
assign Multiplied_Result_Out = Enable_In ? Addition_4 : 64'bZ;



endmodule
