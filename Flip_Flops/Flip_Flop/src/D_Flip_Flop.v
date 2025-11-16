/*
--------------------------------------------------
Module :
--------------------------------------------------
D_Flip_Flop


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a D Flip Flop.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module D_Flip_Flop (
    input  Clk_In,
    input  Reset_In,

    input  D_In,
    output Q_Out,
    output Qb_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg D_FF_Q = 1'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Q_Out  = D_FF_Q;
assign Qb_Out = ~D_FF_Q;



// --------------------------------------------------
// D_Flip_Flop Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                D_FF_Q <= 1'b0;
            end
        else
            begin
                D_FF_Q <= D_In;
            end
    end



endmodule
