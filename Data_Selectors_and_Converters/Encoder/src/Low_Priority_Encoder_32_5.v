/*
--------------------------------------------------
Module :
--------------------------------------------------
Low_Priority_Encoder_32_5


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 32:5 Low Priority Encoder.

Data_0_In is treated as the LSB, and will have the highest priority.
Data_31_In is treated as the MSB, and will have the lowest priority.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Low_Priority_Encoder_32_5 (
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
    
    output [4:0] Encoded_Value_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg [4:0] Encoded_Value = 5'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Encoded_Value_Out = Enable_In ? Encoded_Value : 5'bZ;



// --------------------------------------------------
// Low_Priority_Encoder_32_5 Logic
// --------------------------------------------------
always @ (*)
    begin
        casex ({Data_0_In, Data_1_In, Data_2_In, Data_3_In, Data_4_In, Data_5_In, Data_6_In, Data_7_In, Data_8_In, Data_9_In, Data_10_In, Data_11_In, Data_12_In, Data_13_In, Data_14_In, Data_15_In, Data_16_In, Data_17_In, Data_18_In, Data_19_In, Data_20_In, Data_21_In, Data_22_In, Data_23_In, Data_24_In, Data_25_In, Data_26_In, Data_27_In, Data_28_In, Data_29_In, Data_30_In, Data_31_In})
            32'b1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd31;    end
            32'b01xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd30;    end
            32'b001xxxxxxxxxxxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd29;    end
            32'b0001xxxxxxxxxxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd28;    end
            32'b00001xxxxxxxxxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd27;    end
            32'b000001xxxxxxxxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd26;    end
            32'b0000001xxxxxxxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd25;    end
            32'b00000001xxxxxxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd24;    end
            32'b000000001xxxxxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd23;    end
            32'b0000000001xxxxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd22;    end
            32'b00000000001xxxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd21;    end
            32'b000000000001xxxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd20;    end
            32'b0000000000001xxxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd19;    end
            32'b00000000000001xxxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd18;    end
            32'b000000000000001xxxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd17;    end
            32'b0000000000000001xxxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd16;    end
            32'b00000000000000001xxxxxxxxxxxxxxx : begin Encoded_Value <= 5'd15;    end
            32'b000000000000000001xxxxxxxxxxxxxx : begin Encoded_Value <= 5'd14;    end
            32'b0000000000000000001xxxxxxxxxxxxx : begin Encoded_Value <= 5'd13;    end
            32'b00000000000000000001xxxxxxxxxxxx : begin Encoded_Value <= 5'd12;    end
            32'b000000000000000000001xxxxxxxxxxx : begin Encoded_Value <= 5'd11;    end
            32'b0000000000000000000001xxxxxxxxxx : begin Encoded_Value <= 5'd10;    end
            32'b00000000000000000000001xxxxxxxxx : begin Encoded_Value <= 5'd9;     end
            32'b000000000000000000000001xxxxxxxx : begin Encoded_Value <= 5'd8;     end
            32'b0000000000000000000000001xxxxxxx : begin Encoded_Value <= 5'd7;     end
            32'b00000000000000000000000001xxxxxx : begin Encoded_Value <= 5'd6;     end
            32'b000000000000000000000000001xxxxx : begin Encoded_Value <= 5'd5;     end
            32'b0000000000000000000000000001xxxx : begin Encoded_Value <= 5'd4;     end
            32'b00000000000000000000000000001xxx : begin Encoded_Value <= 5'd3;     end
            32'b000000000000000000000000000001xx : begin Encoded_Value <= 5'd2;     end
            32'b0000000000000000000000000000001x : begin Encoded_Value <= 5'd1;     end
            32'b00000000000000000000000000000001 : begin Encoded_Value <= 5'd0;     end
            default                              : begin Encoded_Value <= 5'dZ;     end
        endcase
    end



endmodule
