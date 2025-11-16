/*
--------------------------------------------------
Module :
--------------------------------------------------
MUX_8_1


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 8:1 Multiplexer (MUX).


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module MUX_8_1 (
    input        Enable_In,

    input        Data_0_In,
    input        Data_1_In,
    input        Data_2_In,
    input        Data_3_In,
    input        Data_4_In,
    input        Data_5_In,
    input        Data_6_In,
    input        Data_7_In,

    input  [2:0] Select_In,

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
// MUX_8_1 Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Select_In)
            3'd0    : begin MUX_Data_Selected <= Data_0_In; end
            3'd1    : begin MUX_Data_Selected <= Data_1_In; end
            3'd2    : begin MUX_Data_Selected <= Data_2_In; end
            3'd3    : begin MUX_Data_Selected <= Data_3_In; end
            3'd4    : begin MUX_Data_Selected <= Data_4_In; end
            3'd5    : begin MUX_Data_Selected <= Data_5_In; end
            3'd6    : begin MUX_Data_Selected <= Data_6_In; end
            3'd7    : begin MUX_Data_Selected <= Data_7_In; end
            default : begin MUX_Data_Selected <= 1'b0;      end
        endcase
    end



endmodule
