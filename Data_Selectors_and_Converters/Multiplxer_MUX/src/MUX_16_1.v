/*
--------------------------------------------------
Module :
--------------------------------------------------
MUX_16_1


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16:1 Multiplexer (MUX).


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module MUX_16_1 (
    input        Enable_In,

    input        Data_0_In,
    input        Data_1_In,
    input        Data_2_In,
    input        Data_3_In,
    input        Data_4_In,
    input        Data_5_In,
    input        Data_6_In,
    input        Data_7_In,
    input        Data_8_In,
    input        Data_9_In,
    input        Data_10_In,
    input        Data_11_In,
    input        Data_12_In,
    input        Data_13_In,
    input        Data_14_In,
    input        Data_15_In,

    input  [3:0] Select_In,

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
// MUX_16_1 Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Select_In)
            4'd0    : begin MUX_Data_Selected <= Data_0_In;  end
            4'd1    : begin MUX_Data_Selected <= Data_1_In;  end
            4'd2    : begin MUX_Data_Selected <= Data_2_In;  end
            4'd3    : begin MUX_Data_Selected <= Data_3_In;  end
            4'd4    : begin MUX_Data_Selected <= Data_4_In;  end
            4'd5    : begin MUX_Data_Selected <= Data_5_In;  end
            4'd6    : begin MUX_Data_Selected <= Data_6_In;  end
            4'd7    : begin MUX_Data_Selected <= Data_7_In;  end
            4'd8    : begin MUX_Data_Selected <= Data_8_In;  end
            4'd9    : begin MUX_Data_Selected <= Data_9_In;  end
            4'd10   : begin MUX_Data_Selected <= Data_10_In; end
            4'd11   : begin MUX_Data_Selected <= Data_11_In; end
            4'd12   : begin MUX_Data_Selected <= Data_12_In; end
            4'd13   : begin MUX_Data_Selected <= Data_13_In; end
            4'd14   : begin MUX_Data_Selected <= Data_14_In; end
            4'd15   : begin MUX_Data_Selected <= Data_15_In; end
            default : begin MUX_Data_Selected <= 1'b0;       end
        endcase
    end



endmodule
