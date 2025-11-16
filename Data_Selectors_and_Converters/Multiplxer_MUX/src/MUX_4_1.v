/*
--------------------------------------------------
Module :
--------------------------------------------------
MUX_4_1


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 4:1 Multiplexer (MUX).


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module MUX_4_1 (
    input        Enable_In,

    input        Data_0_In,
    input        Data_1_In,
    input        Data_2_In,
    input        Data_3_In,

    input  [1:0] Select_In,

    output       MUX_Result_Data_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg MUX_Data_Selected = 1'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign MUX_Result_Data_Out = Enable_In ? MUX_Data_Selected : 1'bZ;



// --------------------------------------------------
// MUX_4_1 Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Select_In)
            2'd0    : begin MUX_Data_Selected <= Data_0_In; end
            2'd1    : begin MUX_Data_Selected <= Data_1_In; end
            2'd2    : begin MUX_Data_Selected <= Data_2_In; end
            2'd3    : begin MUX_Data_Selected <= Data_3_In; end
            default : begin MUX_Data_Selected <= 1'b0;      end
        endcase
    end



endmodule
