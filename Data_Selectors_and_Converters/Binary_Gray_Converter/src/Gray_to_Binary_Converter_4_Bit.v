/*
--------------------------------------------------
Module :
--------------------------------------------------
Gray_to_Binary_Converter_4_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 4-Bit Gray to Binary Converter.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Gray_to_Binary_Converter_4_Bit (
    input        Enable_In,
    
    input  [3:0] Gray_Data_In,

    output [3:0] Binary_Data_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire [3:0] Binary_Data;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Binary_Data_Out = Enable_In ? Binary_Data : 4'bZ;



// --------------------------------------------------
// Gray_to_Binary_Converter_4_Bit Logic
// --------------------------------------------------
assign Binary_Data[3] = Gray_Data_In[3];
assign Binary_Data[2] = Gray_Data_In[2] ^ Binary_Data[3];
assign Binary_Data[1] = Gray_Data_In[1] ^ Binary_Data[2];
assign Binary_Data[0] = Gray_Data_In[0] ^ Binary_Data[1];



endmodule
