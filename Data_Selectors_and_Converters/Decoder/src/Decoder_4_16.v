/*
--------------------------------------------------
Module :
--------------------------------------------------
Decoder_4_16


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 4:16 Decoder.

Data_0_Out is treated as the LSB.
Data_15_Out is treated as the MSB.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Decoder_4_16 (
    input        Enable_In,

    input  [3:0] Encoded_Value_In,
    
    output       Data_0_Out,
    output       Data_1_Out,
    output       Data_2_Out,
    output       Data_3_Out,
    output       Data_4_Out,
    output       Data_5_Out,
    output       Data_6_Out,
    output       Data_7_Out,
    output       Data_8_Out,
    output       Data_9_Out,
    output       Data_10_Out,
    output       Data_11_Out,
    output       Data_12_Out,
    output       Data_13_Out,
    output       Data_14_Out,
    output       Data_15_Out
);



// --------------------------------------------------
// Decoder_4_16 Logic
// --------------------------------------------------
assign Data_0_Out  = Enable_In ? ((Encoded_Value_In == 4'd0)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_1_Out  = Enable_In ? ((Encoded_Value_In == 4'd1)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_2_Out  = Enable_In ? ((Encoded_Value_In == 4'd2)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_3_Out  = Enable_In ? ((Encoded_Value_In == 4'd3)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_4_Out  = Enable_In ? ((Encoded_Value_In == 4'd4)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_5_Out  = Enable_In ? ((Encoded_Value_In == 4'd5)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_6_Out  = Enable_In ? ((Encoded_Value_In == 4'd6)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_7_Out  = Enable_In ? ((Encoded_Value_In == 4'd7)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_8_Out  = Enable_In ? ((Encoded_Value_In == 4'd8)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_9_Out  = Enable_In ? ((Encoded_Value_In == 4'd9)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_10_Out = Enable_In ? ((Encoded_Value_In == 4'd10) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_11_Out = Enable_In ? ((Encoded_Value_In == 4'd11) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_12_Out = Enable_In ? ((Encoded_Value_In == 4'd12) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_13_Out = Enable_In ? ((Encoded_Value_In == 4'd13) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_14_Out = Enable_In ? ((Encoded_Value_In == 4'd14) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_15_Out = Enable_In ? ((Encoded_Value_In == 4'd15) ? 1'b1 : 1'b0) : 1'bZ;



endmodule
