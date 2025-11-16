/*
--------------------------------------------------
Module :
--------------------------------------------------
Binary_to_Gray_Converter_8_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 8-Bit Binary to Gray Converter.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Binary_to_Gray_Converter_8_Bit (
    input        Enable_In,
    
    input  [7:0] Binary_Data_In,

    output [7:0] Gray_Data_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire [7:0] Gray_Data;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Gray_Data_Out = Enable_In ? Gray_Data : 8'bZ;



// --------------------------------------------------
// Binary_to_Gray_Converter_8_Bit Logic
// --------------------------------------------------
assign Gray_Data[7] = Binary_Data_In[7];
assign Gray_Data[6] = Binary_Data_In[6] ^ Binary_Data_In[7];
assign Gray_Data[5] = Binary_Data_In[5] ^ Binary_Data_In[6];
assign Gray_Data[4] = Binary_Data_In[4] ^ Binary_Data_In[5];
assign Gray_Data[3] = Binary_Data_In[3] ^ Binary_Data_In[4];
assign Gray_Data[2] = Binary_Data_In[2] ^ Binary_Data_In[3];
assign Gray_Data[1] = Binary_Data_In[1] ^ Binary_Data_In[2];
assign Gray_Data[0] = Binary_Data_In[0] ^ Binary_Data_In[1];



endmodule
