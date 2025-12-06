/*
--------------------------------------------------
Module :
--------------------------------------------------
Serial_In_Parallel_Out_SIPO_4_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 4-Bit Serial-In-Parallel-Out (SIPO) Shift Register.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Serial_In_Parallel_Out_SIPO_4_Bit (
    input        Clk_In,
    input        Reset_In,
    input        Enable_In,

    input        Shift_Data_Signal_In,

    input        Serial_Data_In,
    output [3:0] Parallel_Data_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg  [3:0]  r_Shift_Register = 4'b0;

wire        w_Shift_Data_Signal_In;
wire        w_Serial_Data_In;
wire [3:0]  w_Parallel_Data_Out;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign w_Shift_Data_Signal_In   = Enable_In ? Shift_Data_Signal_In : 1'b0;

assign w_Serial_Data_In         = Enable_In ? Serial_Data_In       : 1'b0;
assign Parallel_Data_Out        = Enable_In ? w_Parallel_Data_Out  : 4'bZ;

assign w_Parallel_Data_Out      = r_Shift_Register;



// --------------------------------------------------
// Serial_In_Parallel_Out_SIPO_4_Bit Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                r_Shift_Register <= 4'b0;
            end
        else if (w_Shift_Data_Signal_In)
            begin
                r_Shift_Register <= {r_Shift_Register[2:0], w_Serial_Data_In};
            end
        else
            begin
                r_Shift_Register <= r_Shift_Register;
            end
    end



endmodule
