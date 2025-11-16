/*
--------------------------------------------------
Module :
--------------------------------------------------
DEMUX_1_2


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a De-Multiplexer 1:2 (DEMUX).



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module DEMUX_1_2 (
    input  Enable_In,

    input  Data_In,

    input  Select_In,

    output DEMUX_Result_Data_0_Out,
    output DEMUX_Result_Data_1_Out
);



// --------------------------------------------------
// DEMUX_1_2 Logic
// --------------------------------------------------
assign DEMUX_Result_Data_0_Out = Enable_In ? ((Select_In == 1'd0) ? Data_In : 1'b0) : 1'bZ;
assign DEMUX_Result_Data_1_Out = Enable_In ? ((Select_In == 1'd1) ? Data_In : 1'b0) : 1'bZ;



endmodule
