/*
--------------------------------------------------
Module :
--------------------------------------------------
Gray_to_Binary_Converter_16_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16-Bit Gray to Binary Converter.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Gray_to_Binary_Converter_16_Bit (
    input         Enable_In,
    
    input  [15:0] Gray_Data_In,

    output [15:0] Binary_Data_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire [15:0] Binary_Data;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Binary_Data_Out = Enable_In ? Binary_Data : 16'bZ;



// --------------------------------------------------
// Gray_to_Binary_Converter_16_Bit Logic
// --------------------------------------------------
assign Binary_Data[15] = Gray_Data_In[15];
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
