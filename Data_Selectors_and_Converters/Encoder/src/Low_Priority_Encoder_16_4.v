/*
--------------------------------------------------
Module :
--------------------------------------------------
Low_Priority_Encoder_16_4


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16:4 Low Priority Encoder.

Data_0_In is treated as the LSB, and will have the highest priority.
Data_15_In is treated as the MSB, and will have the lowest priority.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Low_Priority_Encoder_16_4 (
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
    
    output [3:0] Encoded_Value_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg [3:0] Encoded_Value = 4'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Encoded_Value_Out = Enable_In ? Encoded_Value : 4'bZ;



// --------------------------------------------------
// Low_Priority_Encoder_16_4 Logic
// --------------------------------------------------
always @ (*)
    begin
        casex ({Data_0_In, Data_1_In, Data_2_In, Data_3_In, Data_4_In, Data_5_In, Data_6_In, Data_7_In, Data_8_In, Data_9_In, Data_10_In, Data_11_In, Data_12_In, Data_13_In, Data_14_In, Data_15_In})
            16'b1xxxxxxxxxxxxxxx : begin Encoded_Value <= 4'd15; end
            16'b01xxxxxxxxxxxxxx : begin Encoded_Value <= 4'd14; end
            16'b001xxxxxxxxxxxxx : begin Encoded_Value <= 4'd13; end
            16'b0001xxxxxxxxxxxx : begin Encoded_Value <= 4'd12; end
            16'b00001xxxxxxxxxxx : begin Encoded_Value <= 4'd11; end
            16'b000001xxxxxxxxxx : begin Encoded_Value <= 4'd10; end
            16'b0000001xxxxxxxxx : begin Encoded_Value <= 4'd9;  end
            16'b00000001xxxxxxxx : begin Encoded_Value <= 4'd8;  end
            16'b000000001xxxxxxx : begin Encoded_Value <= 4'd7;  end
            16'b0000000001xxxxxx : begin Encoded_Value <= 4'd6;  end
            16'b00000000001xxxxx : begin Encoded_Value <= 4'd5;  end
            16'b000000000001xxxx : begin Encoded_Value <= 4'd4;  end
            16'b0000000000001xxx : begin Encoded_Value <= 4'd3;  end
            16'b00000000000001xx : begin Encoded_Value <= 4'd2;  end
            16'b000000000000001x : begin Encoded_Value <= 4'd1;  end
            16'b0000000000000001 : begin Encoded_Value <= 4'd0;  end
            default              : begin Encoded_Value <= 4'dZ;  end
        endcase
    end



endmodule
