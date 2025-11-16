/*
--------------------------------------------------
Module :
--------------------------------------------------
Gray_to_Binary_Converter_32_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 32-Bit Gray to Binary Converter.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Gray_to_Binary_Converter_32_Bit (
    input         Enable_In,
    
    input  [31:0] Gray_Data_In,

    output [31:0] Binary_Data_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire [31:0] Binary_Data;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Binary_Data_Out = Enable_In ? Binary_Data : 32'bZ;



// --------------------------------------------------
// Gray_to_Binary_Converter_32_Bit Logic
// --------------------------------------------------
assign Binary_Data[31] = Gray_Data_In[31];
assign Binary_Data[30] = Gray_Data_In[30] ^ Binary_Data[31];
assign Binary_Data[29] = Gray_Data_In[29] ^ Binary_Data[30];
assign Binary_Data[28] = Gray_Data_In[28] ^ Binary_Data[29];
assign Binary_Data[27] = Gray_Data_In[27] ^ Binary_Data[28];
assign Binary_Data[26] = Gray_Data_In[26] ^ Binary_Data[27];
assign Binary_Data[25] = Gray_Data_In[25] ^ Binary_Data[26];
assign Binary_Data[24] = Gray_Data_In[24] ^ Binary_Data[25];
assign Binary_Data[23] = Gray_Data_In[23] ^ Binary_Data[24];
assign Binary_Data[22] = Gray_Data_In[22] ^ Binary_Data[23];
assign Binary_Data[21] = Gray_Data_In[21] ^ Binary_Data[22];
assign Binary_Data[20] = Gray_Data_In[20] ^ Binary_Data[21];
assign Binary_Data[19] = Gray_Data_In[19] ^ Binary_Data[20];
assign Binary_Data[18] = Gray_Data_In[18] ^ Binary_Data[19];
assign Binary_Data[17] = Gray_Data_In[17] ^ Binary_Data[18];
assign Binary_Data[16] = Gray_Data_In[16] ^ Binary_Data[17];
assign Binary_Data[15] = Gray_Data_In[15] ^ Binary_Data[16];
assign Binary_Data[14] = Gray_Data_In[14] ^ Binary_Data[15];
assign Binary_Data[13] = Gray_Data_In[13] ^ Binary_Data[14];
assign Binary_Data[12] = Gray_Data_In[12] ^ Binary_Data[13];
assign Binary_Data[11] = Gray_Data_In[11] ^ Binary_Data[12];
assign Binary_Data[10] = Gray_Data_In[10] ^ Binary_Data[11];
assign Binary_Data[9]  = Gray_Data_In[9]  ^ Binary_Data[10];
assign Binary_Data[8]  = Gray_Data_In[8]  ^ Binary_Data[9];
assign Binary_Data[7]  = Gray_Data_In[7]  ^ Binary_Data[8];
assign Binary_Data[6]  = Gray_Data_In[6]  ^ Binary_Data[7];
assign Binary_Data[5]  = Gray_Data_In[5]  ^ Binary_Data[6];
assign Binary_Data[4]  = Gray_Data_In[4]  ^ Binary_Data[5];
assign Binary_Data[3]  = Gray_Data_In[3]  ^ Binary_Data[4];
assign Binary_Data[2]  = Gray_Data_In[2]  ^ Binary_Data[3];
assign Binary_Data[1]  = Gray_Data_In[1]  ^ Binary_Data[2];
assign Binary_Data[0]  = Gray_Data_In[0]  ^ Binary_Data[1];



endmodule
