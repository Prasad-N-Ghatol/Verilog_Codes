/*
--------------------------------------------------
Module :
--------------------------------------------------
MUX_2_1


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 2:1 Multiplexer (MUX).



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module MUX_2_1 (
    input  Enable_In,

    input  Data_0_In,
    input  Data_1_In,

    input  Select_In,

    output MUX_Result_Data_Out
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
// MUX_2_1 Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Select_In)
            1'd0    : begin MUX_Data_Selected <= Data_0_In; end
            1'd1    : begin MUX_Data_Selected <= Data_1_In; end
            default : begin MUX_Data_Selected <= 1'b0;      end
        endcase
    end



endmodule
