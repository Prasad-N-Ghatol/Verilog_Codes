/*
--------------------------------------------------
Module :
--------------------------------------------------
DEMUX_1_32


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a De-Multiplexer 1:32 (DEMUX).



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module DEMUX_1_32 (
    input        Enable_In,

    input        Data_In,

    input  [4:0] Select_In,

    output       DEMUX_Result_Data_0_Out,
    output       DEMUX_Result_Data_1_Out,
    output       DEMUX_Result_Data_2_Out,
    output       DEMUX_Result_Data_3_Out,
    output       DEMUX_Result_Data_4_Out,
    output       DEMUX_Result_Data_5_Out,
    output       DEMUX_Result_Data_6_Out,
    output       DEMUX_Result_Data_7_Out,
    output       DEMUX_Result_Data_8_Out,
    output       DEMUX_Result_Data_9_Out,
    output       DEMUX_Result_Data_10_Out,
    output       DEMUX_Result_Data_11_Out,
    output       DEMUX_Result_Data_12_Out,
    output       DEMUX_Result_Data_13_Out,
    output       DEMUX_Result_Data_14_Out,
    output       DEMUX_Result_Data_15_Out,
    output       DEMUX_Result_Data_16_Out,
    output       DEMUX_Result_Data_17_Out,
    output       DEMUX_Result_Data_18_Out,
    output       DEMUX_Result_Data_19_Out,
    output       DEMUX_Result_Data_20_Out,
    output       DEMUX_Result_Data_21_Out,
    output       DEMUX_Result_Data_22_Out,
    output       DEMUX_Result_Data_23_Out,
    output       DEMUX_Result_Data_24_Out,
    output       DEMUX_Result_Data_25_Out,
    output       DEMUX_Result_Data_26_Out,
    output       DEMUX_Result_Data_27_Out,
    output       DEMUX_Result_Data_28_Out,
    output       DEMUX_Result_Data_29_Out,
    output       DEMUX_Result_Data_30_Out,
    output       DEMUX_Result_Data_31_Out
);



// --------------------------------------------------
// DEMUX_1_32 Logic
// --------------------------------------------------
assign DEMUX_Result_Data_0_Out  = Enable_In ? ((Select_In == 5'd0)  ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_1_Out  = Enable_In ? ((Select_In == 5'd1)  ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_2_Out  = Enable_In ? ((Select_In == 5'd2)  ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_3_Out  = Enable_In ? ((Select_In == 5'd3)  ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_4_Out  = Enable_In ? ((Select_In == 5'd4)  ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_5_Out  = Enable_In ? ((Select_In == 5'd5)  ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_6_Out  = Enable_In ? ((Select_In == 5'd6)  ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_7_Out  = Enable_In ? ((Select_In == 5'd7)  ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_8_Out  = Enable_In ? ((Select_In == 5'd8)  ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_9_Out  = Enable_In ? ((Select_In == 5'd9)  ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_10_Out = Enable_In ? ((Select_In == 5'd10) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_11_Out = Enable_In ? ((Select_In == 5'd11) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_12_Out = Enable_In ? ((Select_In == 5'd12) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_13_Out = Enable_In ? ((Select_In == 5'd13) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_14_Out = Enable_In ? ((Select_In == 5'd14) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_15_Out = Enable_In ? ((Select_In == 5'd15) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_16_Out = Enable_In ? ((Select_In == 5'd16) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_17_Out = Enable_In ? ((Select_In == 5'd17) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_18_Out = Enable_In ? ((Select_In == 5'd18) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_19_Out = Enable_In ? ((Select_In == 5'd19) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_20_Out = Enable_In ? ((Select_In == 5'd20) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_21_Out = Enable_In ? ((Select_In == 5'd21) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_22_Out = Enable_In ? ((Select_In == 5'd22) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_23_Out = Enable_In ? ((Select_In == 5'd23) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_24_Out = Enable_In ? ((Select_In == 5'd24) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_25_Out = Enable_In ? ((Select_In == 5'd25) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_26_Out = Enable_In ? ((Select_In == 5'd26) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_27_Out = Enable_In ? ((Select_In == 5'd27) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_28_Out = Enable_In ? ((Select_In == 5'd28) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_29_Out = Enable_In ? ((Select_In == 5'd29) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_30_Out = Enable_In ? ((Select_In == 5'd30) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_31_Out = Enable_In ? ((Select_In == 5'd31) ? Data_In : 1'b0) : 1'bZ;



endmodule
