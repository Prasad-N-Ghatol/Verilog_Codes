/*
--------------------------------------------------
Module :
--------------------------------------------------
Binary_to_Gray_Converter_32_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 32-Bit Binary to Gray Converter.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Binary_to_Gray_Converter_32_Bit (
    input         Enable_In,
    
    input  [31:0] Binary_Data_In,

    output [31:0] Gray_Data_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire [31:0] Gray_Data;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Gray_Data_Out = Enable_In ? Gray_Data : 32'bZ;



// --------------------------------------------------
// Binary_to_Gray_Converter_32_Bit Logic
// --------------------------------------------------
assign Gray_Data[31] = Binary_Data_In[31];
assign Gray_Data[30] = Binary_Data_In[30] ^ Binary_Data_In[31];
assign Gray_Data[29] = Binary_Data_In[29] ^ Binary_Data_In[30];
assign Gray_Data[28] = Binary_Data_In[28] ^ Binary_Data_In[29];
assign Gray_Data[27] = Binary_Data_In[27] ^ Binary_Data_In[28];
assign Gray_Data[26] = Binary_Data_In[26] ^ Binary_Data_In[27];
assign Gray_Data[25] = Binary_Data_In[25] ^ Binary_Data_In[26];
assign Gray_Data[24] = Binary_Data_In[24] ^ Binary_Data_In[25];
assign Gray_Data[23] = Binary_Data_In[23] ^ Binary_Data_In[24];
assign Gray_Data[22] = Binary_Data_In[22] ^ Binary_Data_In[23];
assign Gray_Data[21] = Binary_Data_In[21] ^ Binary_Data_In[22];
assign Gray_Data[20] = Binary_Data_In[20] ^ Binary_Data_In[21];
assign Gray_Data[19] = Binary_Data_In[19] ^ Binary_Data_In[20];
assign Gray_Data[18] = Binary_Data_In[18] ^ Binary_Data_In[19];
assign Gray_Data[17] = Binary_Data_In[17] ^ Binary_Data_In[18];
assign Gray_Data[16] = Binary_Data_In[16] ^ Binary_Data_In[17];
assign Gray_Data[15] = Binary_Data_In[15] ^ Binary_Data_In[16];
assign Gray_Data[14] = Binary_Data_In[14] ^ Binary_Data_In[15];
assign Gray_Data[13] = Binary_Data_In[13] ^ Binary_Data_In[14];
assign Gray_Data[12] = Binary_Data_In[12] ^ Binary_Data_In[13];
assign Gray_Data[11] = Binary_Data_In[11] ^ Binary_Data_In[12];
assign Gray_Data[10] = Binary_Data_In[10] ^ Binary_Data_In[11];
assign Gray_Data[9]  = Binary_Data_In[9]  ^ Binary_Data_In[10];
assign Gray_Data[8]  = Binary_Data_In[8]  ^ Binary_Data_In[9];
assign Gray_Data[7]  = Binary_Data_In[7]  ^ Binary_Data_In[8];
assign Gray_Data[6]  = Binary_Data_In[6]  ^ Binary_Data_In[7];
assign Gray_Data[5]  = Binary_Data_In[5]  ^ Binary_Data_In[6];
assign Gray_Data[4]  = Binary_Data_In[4]  ^ Binary_Data_In[5];
assign Gray_Data[3]  = Binary_Data_In[3]  ^ Binary_Data_In[4];
assign Gray_Data[2]  = Binary_Data_In[2]  ^ Binary_Data_In[3];
assign Gray_Data[1]  = Binary_Data_In[1]  ^ Binary_Data_In[2];
assign Gray_Data[0]  = Binary_Data_In[0]  ^ Binary_Data_In[1];



endmodule
