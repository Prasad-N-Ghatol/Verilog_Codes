/*
--------------------------------------------------
Module :
--------------------------------------------------
Decoder_3_8


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 3:8 Decoder.

Data_0_Out is treated as the LSB.
Data_7_Out is treated as the MSB.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Decoder_3_8 (
    input        Enable_In,

    input  [2:0] Encoded_Value_In,
    
    output       Data_0_Out,
    output       Data_1_Out,
    output       Data_2_Out,
    output       Data_3_Out,
    output       Data_4_Out,
    output       Data_5_Out,
    output       Data_6_Out,
    output       Data_7_Out
);



// --------------------------------------------------
// Decoder_3_8 Logic
// --------------------------------------------------
assign Data_0_Out = Enable_In ? ((Encoded_Value_In == 3'd0) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_1_Out = Enable_In ? ((Encoded_Value_In == 3'd1) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_2_Out = Enable_In ? ((Encoded_Value_In == 3'd2) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_3_Out = Enable_In ? ((Encoded_Value_In == 3'd3) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_4_Out = Enable_In ? ((Encoded_Value_In == 3'd4) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_5_Out = Enable_In ? ((Encoded_Value_In == 3'd5) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_6_Out = Enable_In ? ((Encoded_Value_In == 3'd6) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_7_Out = Enable_In ? ((Encoded_Value_In == 3'd7) ? 1'b1 : 1'b0) : 1'bZ;



endmodule
