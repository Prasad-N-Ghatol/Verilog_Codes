/*
--------------------------------------------------
Module :
--------------------------------------------------
Parallel_In_Serial_Out_PISO_16_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16-Bit Parallel-In-Serial-Out (PISO) Shift Register.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Parallel_In_Serial_Out_PISO_16_Bit (
    input         Clk_In,
    input         Reset_In,
    input         Enable_In,

    input         Load_Data_Signal_In,
    input         Shift_Data_Signal_In,

    input  [15:0] Parallel_Data_In,
    output        Serial_Data_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg  [15:0] r_Shift_Register = 16'b0;

wire        w_Load_Data_Signal_In;
wire        w_Shift_Data_Signal_In;
wire [15:0] w_Parallel_Data_In;
wire        w_Serial_Data_Out;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign w_Load_Data_Signal_In  = Enable_In ? Load_Data_Signal_In  : 1'b0;
assign w_Shift_Data_Signal_In = Enable_In ? Shift_Data_Signal_In : 1'b0;

assign w_Parallel_Data_In     = Enable_In ? Parallel_Data_In     : 16'b0;
assign Serial_Data_Out        = Enable_In ? w_Serial_Data_Out    : 1'bZ;

assign w_Serial_Data_Out      = r_Shift_Register[15];



// --------------------------------------------------
// Parallel_In_Serial_Out_PISO_16_Bit Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                r_Shift_Register <= 16'b0;
            end
        else if (w_Load_Data_Signal_In)
            begin
                r_Shift_Register <= w_Parallel_Data_In;
            end
        else if (w_Shift_Data_Signal_In)
            begin
                r_Shift_Register <= {r_Shift_Register[14:0], 1'b0};
            end
        else
            begin
                r_Shift_Register <= r_Shift_Register;
            end
    end



endmodule
