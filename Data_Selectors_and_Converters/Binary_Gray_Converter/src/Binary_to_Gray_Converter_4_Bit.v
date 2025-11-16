/*
--------------------------------------------------
Module :
--------------------------------------------------
Binary_to_Gray_Converter_4_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 4-Bit Binary to Gray Converter.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Binary_to_Gray_Converter_4_Bit (
    input        Enable_In,
    
    input  [3:0] Binary_Data_In,

    output [3:0] Gray_Data_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire [3:0] Gray_Data;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Gray_Data_Out = Enable_In ? Gray_Data : 4'bZ;



// --------------------------------------------------
// Binary_to_Gray_Converter_4_Bit Logic
// --------------------------------------------------
assign Gray_Data[3] = Binary_Data_In[3];
assign Gray_Data[2] = Binary_Data_In[2] ^ Binary_Data_In[3];
assign Gray_Data[1] = Binary_Data_In[1] ^ Binary_Data_In[2];
assign Gray_Data[0] = Binary_Data_In[0] ^ Binary_Data_In[1];



endmodule
