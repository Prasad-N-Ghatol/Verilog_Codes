/*
--------------------------------------------------
Module :
--------------------------------------------------
MUX_32_1


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 32:1 Multiplexer (MUX).


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module MUX_32_1 (
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
    input        Data_16_In,
    input        Data_17_In,
    input        Data_18_In,
    input        Data_19_In,
    input        Data_20_In,
    input        Data_21_In,
    input        Data_22_In,
    input        Data_23_In,
    input        Data_24_In,
    input        Data_25_In,
    input        Data_26_In,
    input        Data_27_In,
    input        Data_28_In,
    input        Data_29_In,
    input        Data_30_In,
    input        Data_31_In,

    input  [4:0] Select_In,

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
// MUX_32_1 Logic
// --------------------------------------------------
always @ (*)
    begin
        case (Select_In)
            5'd0    : begin MUX_Data_Selected <= Data_0_In;  end
            5'd1    : begin MUX_Data_Selected <= Data_1_In;  end
            5'd2    : begin MUX_Data_Selected <= Data_2_In;  end
            5'd3    : begin MUX_Data_Selected <= Data_3_In;  end
            5'd4    : begin MUX_Data_Selected <= Data_4_In;  end
            5'd5    : begin MUX_Data_Selected <= Data_5_In;  end
            5'd6    : begin MUX_Data_Selected <= Data_6_In;  end
            5'd7    : begin MUX_Data_Selected <= Data_7_In;  end
            5'd8    : begin MUX_Data_Selected <= Data_8_In;  end
            5'd9    : begin MUX_Data_Selected <= Data_9_In;  end
            5'd10   : begin MUX_Data_Selected <= Data_10_In; end
            5'd11   : begin MUX_Data_Selected <= Data_11_In; end
            5'd12   : begin MUX_Data_Selected <= Data_12_In; end
            5'd13   : begin MUX_Data_Selected <= Data_13_In; end
            5'd14   : begin MUX_Data_Selected <= Data_14_In; end
            5'd15   : begin MUX_Data_Selected <= Data_15_In; end
            5'd16   : begin MUX_Data_Selected <= Data_16_In; end
            5'd17   : begin MUX_Data_Selected <= Data_17_In; end
            5'd18   : begin MUX_Data_Selected <= Data_18_In; end
            5'd19   : begin MUX_Data_Selected <= Data_19_In; end
            5'd20   : begin MUX_Data_Selected <= Data_20_In; end
            5'd21   : begin MUX_Data_Selected <= Data_21_In; end
            5'd22   : begin MUX_Data_Selected <= Data_22_In; end
            5'd23   : begin MUX_Data_Selected <= Data_23_In; end
            5'd24   : begin MUX_Data_Selected <= Data_24_In; end
            5'd25   : begin MUX_Data_Selected <= Data_25_In; end
            5'd26   : begin MUX_Data_Selected <= Data_26_In; end
            5'd27   : begin MUX_Data_Selected <= Data_27_In; end
            5'd28   : begin MUX_Data_Selected <= Data_28_In; end
            5'd29   : begin MUX_Data_Selected <= Data_29_In; end
            5'd30   : begin MUX_Data_Selected <= Data_30_In; end
            5'd31   : begin MUX_Data_Selected <= Data_31_In; end
            default : begin MUX_Data_Selected <= 1'b0;       end
        endcase
    end



endmodule
