/*
--------------------------------------------------
Module :
--------------------------------------------------
Binary_to_Gray_Converter_16_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16-Bit Binary to Gray Converter.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Binary_to_Gray_Converter_16_Bit (
    input         Enable_In,
    
    input  [15:0] Binary_Data_In,

    output [15:0] Gray_Data_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire [15:0] Gray_Data;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Gray_Data_Out = Enable_In ? Gray_Data : 16'bZ;



// --------------------------------------------------
// Binary_to_Gray_Converter_16_Bit Logic
// --------------------------------------------------
assign Gray_Data[15] = Binary_Data_In[15];
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
