/*
--------------------------------------------------
Module :
--------------------------------------------------
Gray_to_Binary_Converter_8_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 8-Bit Gray to Binary Converter.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Gray_to_Binary_Converter_8_Bit (
    input        Enable_In,
    
    input  [7:0] Gray_Data_In,

    output [7:0] Binary_Data_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire [7:0] Binary_Data;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Binary_Data_Out = Enable_In ? Binary_Data : 8'bZ;



// --------------------------------------------------
// Gray_to_Binary_Converter_8_Bit Logic
// --------------------------------------------------
assign Binary_Data[7] = Gray_Data_In[7];
assign Binary_Data[6] = Gray_Data_In[6] ^ Binary_Data[7];
assign Binary_Data[5] = Gray_Data_In[5] ^ Binary_Data[6];
assign Binary_Data[4] = Gray_Data_In[4] ^ Binary_Data[5];
assign Binary_Data[3] = Gray_Data_In[3] ^ Binary_Data[4];
assign Binary_Data[2] = Gray_Data_In[2] ^ Binary_Data[3];
assign Binary_Data[1] = Gray_Data_In[1] ^ Binary_Data[2];
assign Binary_Data[0] = Gray_Data_In[0] ^ Binary_Data[1];



endmodule
