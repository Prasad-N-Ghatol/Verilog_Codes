/*
--------------------------------------------------
Module :
--------------------------------------------------
High_Priority_Encoder_8_3


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 8:3 High Priority Encoder.

Data_0_In is treated as the LSB, and will have the lowest priority.
Data_7_In is treated as the MSB, and will have the highest priority.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module High_Priority_Encoder_8_3 (
    input        Enable_In,

    input        Data_0_In,
    input        Data_1_In,
    input        Data_2_In,
    input        Data_3_In,
    input        Data_4_In,
    input        Data_5_In,
    input        Data_6_In,
    input        Data_7_In,
    
    output [2:0] Encoded_Value_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg [2:0] Encoded_Value = 3'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Encoded_Value_Out = Enable_In ? Encoded_Value : 3'bZ;



// --------------------------------------------------
// High_Priority_Encoder_8_3 Logic
// --------------------------------------------------
always @ (*)
    begin
        casex ({Data_7_In, Data_6_In, Data_5_In, Data_4_In, Data_3_In, Data_2_In, Data_1_In, Data_0_In})
            8'b1xxxxxxx : begin Encoded_Value <= 3'd7; end
            8'b01xxxxxx : begin Encoded_Value <= 3'd6; end
            8'b001xxxxx : begin Encoded_Value <= 3'd5; end
            8'b0001xxxx : begin Encoded_Value <= 3'd4; end
            8'b00001xxx : begin Encoded_Value <= 3'd3; end
            8'b000001xx : begin Encoded_Value <= 3'd2; end
            8'b0000001x : begin Encoded_Value <= 3'd1; end
            8'b00000001 : begin Encoded_Value <= 3'd0; end
            default     : begin Encoded_Value <= 3'dZ; end
        endcase
    end



endmodule
