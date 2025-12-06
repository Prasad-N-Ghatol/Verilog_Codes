/*
--------------------------------------------------
Module :
--------------------------------------------------
Universal_Shift_Register_USR_4_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 4-Bit Parallel-In-Parallel-Out (PIPO) Shift Register.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Universal_Shift_Register_USR_4_Bit (
    input        Clk_In,
    input        Reset_In,
    input        Enable_In,

    input  [1:0] USR_Operation_Select_In,

    input        Serial_Left_Side_Data_In,
    input        Serial_Right_Side_Data_In,

    output       Serial_Left_Side_Data_Out,
    output       Serial_Right_Side_Data_Out,

    input  [3:0] Parallel_Data_In,
    output [3:0] Parallel_Data_Out
);



// --------------------------------------------------
// Constants
// --------------------------------------------------
localparam [1:0]    NO_OPERATIONS       = 2'h0,
                    SHIFT_DATA_LEFT     = 2'h1,
                    SHIFT_DATA_RIGHT    = 2'h2,
                    LOAD_PARALLEL_DATA  = 2'h3;



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg  [3:0]  r_Shift_Register = 4'b0;

wire [1:0]  w_USR_Operation_Select_In;

wire        w_Serial_Left_Side_Data_In;
wire        w_Serial_Right_Side_Data_In;

wire        w_Serial_Left_Side_Data_Out;
wire        w_Serial_Right_Side_Data_Out;

wire [3:0]  w_Parallel_Data_In;
wire [3:0]  w_Parallel_Data_Out;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign w_USR_Operation_Select_In    = Enable_In ? USR_Operation_Select_In   : 2'b0;
assign w_Serial_Left_Side_Data_In   = Enable_In ? Serial_Left_Side_Data_In  : 1'b0;
assign w_Serial_Right_Side_Data_In  = Enable_In ? Serial_Right_Side_Data_In : 1'b0;
assign w_Parallel_Data_In           = Enable_In ? Parallel_Data_In          : 4'b0;

assign Serial_Left_Side_Data_Out  = Enable_In ? w_Serial_Left_Side_Data_Out   : 1'bZ;
assign Serial_Right_Side_Data_Out = Enable_In ? w_Serial_Right_Side_Data_Out  : 1'bZ;
assign Parallel_Data_Out          = Enable_In ? w_Parallel_Data_Out           : 4'bZ;

assign w_Serial_Left_Side_Data_Out  = r_Shift_Register[3];
assign w_Serial_Right_Side_Data_Out = r_Shift_Register[0];
assign w_Parallel_Data_Out          = r_Shift_Register;



// --------------------------------------------------
// Universal_Shift_Register_USR_4_Bit Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                r_Shift_Register <= 4'b0;
            end
        else
            begin
                case (w_USR_Operation_Select_In)
                    NO_OPERATIONS       : // 2'h0
                        begin
                            r_Shift_Register <= r_Shift_Register;
                        end
                    SHIFT_DATA_LEFT     : // 2'h1
                        begin
                            r_Shift_Register <= {r_Shift_Register[2:0], w_Serial_Right_Side_Data_In};
                        end
                    SHIFT_DATA_RIGHT    : // 2'h2
                        begin
                            r_Shift_Register <= {w_Serial_Left_Side_Data_In, r_Shift_Register[3:1]};
                        end
                    LOAD_PARALLEL_DATA  : // 2'h3
                        begin
                            r_Shift_Register <= w_Parallel_Data_In;
                        end
                    default :
                        begin
                            r_Shift_Register <= r_Shift_Register;
                        end
                endcase
            end
    end



endmodule
