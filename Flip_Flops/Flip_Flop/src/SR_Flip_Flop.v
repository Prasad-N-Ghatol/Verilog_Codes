/*
--------------------------------------------------
Module :
--------------------------------------------------
SR_Flip_Flop


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a SR Flip Flop.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module SR_Flip_Flop (
    input  Clk_In,
    input  Reset_In,

    input  S_In,
    input  R_In,
    output Q_Out,
    output Qb_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg SR_FF_Q = 1'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Q_Out  = SR_FF_Q;
assign Qb_Out = ~SR_FF_Q;



// --------------------------------------------------
// SR_Flip_Flop Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                SR_FF_Q <= 1'b0;
            end
        else
            begin
                case ({S_In, R_In})
                    2'b00   : begin SR_FF_Q <= SR_FF_Q; end
                    2'b01   : begin SR_FF_Q <= 1'b0;    end
                    2'b10   : begin SR_FF_Q <= 1'b1;    end
                    2'b11   : begin SR_FF_Q <= 1'bX;    end
                    default : begin SR_FF_Q <= 1'b0;    end
                endcase
            end
    end



endmodule
