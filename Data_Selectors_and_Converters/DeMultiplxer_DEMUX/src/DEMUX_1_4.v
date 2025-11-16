/*
--------------------------------------------------
Module :
--------------------------------------------------
DEMUX_1_4


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a De-Multiplexer 1:4 (DEMUX).



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module DEMUX_1_4 (
    input        Enable_In,

    input        Data_In,

    input  [1:0] Select_In,

    output       DEMUX_Result_Data_0_Out,
    output       DEMUX_Result_Data_1_Out,
    output       DEMUX_Result_Data_2_Out,
    output       DEMUX_Result_Data_3_Out
);



// --------------------------------------------------
// DEMUX_1_4 Logic
// --------------------------------------------------
assign DEMUX_Result_Data_0_Out = Enable_In ? ((Select_In == 2'd0) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_1_Out = Enable_In ? ((Select_In == 2'd1) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_2_Out = Enable_In ? ((Select_In == 2'd2) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_3_Out = Enable_In ? ((Select_In == 2'd3) ? Data_In : 1'b0) : 1'bZ;



endmodule
