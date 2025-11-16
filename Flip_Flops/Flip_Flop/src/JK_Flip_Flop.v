/*
--------------------------------------------------
Module :
--------------------------------------------------
JK_Flip_Flop


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a JK Flip Flop.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module JK_Flip_Flop (
    input  Clk_In,
    input  Reset_In,

    input  J_In,
    input  K_In,
    output Q_Out,
    output Qb_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg JK_FF_Q = 1'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Q_Out  = JK_FF_Q;
assign Qb_Out = ~JK_FF_Q;



// --------------------------------------------------
// JK_Flip_Flop Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                JK_FF_Q <= 1'b0;
            end
        else
            begin
                case ({J_In, K_In})
                    2'b00   : begin JK_FF_Q <= JK_FF_Q;  end
                    2'b01   : begin JK_FF_Q <= 1'b0;     end
                    2'b10   : begin JK_FF_Q <= 1'b1;     end
                    2'b11   : begin JK_FF_Q <= ~JK_FF_Q; end
                    default : begin JK_FF_Q <= 1'b0;     end
                endcase
            end
    end



endmodule
