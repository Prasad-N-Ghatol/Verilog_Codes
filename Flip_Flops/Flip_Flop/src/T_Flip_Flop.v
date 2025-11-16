/*
--------------------------------------------------
Module :
--------------------------------------------------
T_Flip_Flop


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a T Flip Flop.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module T_Flip_Flop (
    input  Clk_In,
    input  Reset_In,

    input  T_In,
    output Q_Out,
    output Qb_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg T_FF_Q = 1'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Q_Out  = T_FF_Q;
assign Qb_Out = ~T_FF_Q;



// --------------------------------------------------
// T_Flip_Flop Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                T_FF_Q <= 1'b0;
            end
        else if (T_In)
            begin
                T_FF_Q <= ~T_FF_Q;
            end
        else
            begin
                T_FF_Q <= T_FF_Q;
            end
    end



endmodule
