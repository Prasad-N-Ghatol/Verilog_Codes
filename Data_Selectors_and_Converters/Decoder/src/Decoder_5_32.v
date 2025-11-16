/*
--------------------------------------------------
Module :
--------------------------------------------------
Decoder_5_32


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 5:32 Decoder.

Data_0_Out is treated as the LSB.
Data_31_Out is treated as the MSB.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Decoder_5_32 (
    input        Enable_In,

    input  [4:0] Encoded_Value_In,
    
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
    output       Data_15_Out,
    output       Data_16_Out,
    output       Data_17_Out,
    output       Data_18_Out,
    output       Data_19_Out,
    output       Data_20_Out,
    output       Data_21_Out,
    output       Data_22_Out,
    output       Data_23_Out,
    output       Data_24_Out,
    output       Data_25_Out,
    output       Data_26_Out,
    output       Data_27_Out,
    output       Data_28_Out,
    output       Data_29_Out,
    output       Data_30_Out,
    output       Data_31_Out
);



// --------------------------------------------------
// Decoder_5_32 Logic
// --------------------------------------------------
assign Data_0_Out  = Enable_In ? ((Encoded_Value_In == 5'd0)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_1_Out  = Enable_In ? ((Encoded_Value_In == 5'd1)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_2_Out  = Enable_In ? ((Encoded_Value_In == 5'd2)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_3_Out  = Enable_In ? ((Encoded_Value_In == 5'd3)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_4_Out  = Enable_In ? ((Encoded_Value_In == 5'd4)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_5_Out  = Enable_In ? ((Encoded_Value_In == 5'd5)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_6_Out  = Enable_In ? ((Encoded_Value_In == 5'd6)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_7_Out  = Enable_In ? ((Encoded_Value_In == 5'd7)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_8_Out  = Enable_In ? ((Encoded_Value_In == 5'd8)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_9_Out  = Enable_In ? ((Encoded_Value_In == 5'd9)  ? 1'b1 : 1'b0) : 1'bZ;
assign Data_10_Out = Enable_In ? ((Encoded_Value_In == 5'd10) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_11_Out = Enable_In ? ((Encoded_Value_In == 5'd11) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_12_Out = Enable_In ? ((Encoded_Value_In == 5'd12) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_13_Out = Enable_In ? ((Encoded_Value_In == 5'd13) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_14_Out = Enable_In ? ((Encoded_Value_In == 5'd14) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_15_Out = Enable_In ? ((Encoded_Value_In == 5'd15) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_16_Out = Enable_In ? ((Encoded_Value_In == 5'd16) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_17_Out = Enable_In ? ((Encoded_Value_In == 5'd17) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_18_Out = Enable_In ? ((Encoded_Value_In == 5'd18) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_19_Out = Enable_In ? ((Encoded_Value_In == 5'd19) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_20_Out = Enable_In ? ((Encoded_Value_In == 5'd20) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_21_Out = Enable_In ? ((Encoded_Value_In == 5'd21) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_22_Out = Enable_In ? ((Encoded_Value_In == 5'd22) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_23_Out = Enable_In ? ((Encoded_Value_In == 5'd23) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_24_Out = Enable_In ? ((Encoded_Value_In == 5'd24) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_25_Out = Enable_In ? ((Encoded_Value_In == 5'd25) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_26_Out = Enable_In ? ((Encoded_Value_In == 5'd26) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_27_Out = Enable_In ? ((Encoded_Value_In == 5'd27) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_28_Out = Enable_In ? ((Encoded_Value_In == 5'd28) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_29_Out = Enable_In ? ((Encoded_Value_In == 5'd29) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_30_Out = Enable_In ? ((Encoded_Value_In == 5'd30) ? 1'b1 : 1'b0) : 1'bZ;
assign Data_31_Out = Enable_In ? ((Encoded_Value_In == 5'd31) ? 1'b1 : 1'b0) : 1'bZ;



endmodule
