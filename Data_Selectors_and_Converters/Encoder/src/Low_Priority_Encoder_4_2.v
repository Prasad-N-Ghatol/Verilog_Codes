/*
--------------------------------------------------
Module :
--------------------------------------------------
Low_Priority_Encoder_4_2


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 4:2 Low Priority Encoder.

Data_0_In is treated as the LSB, and will have the highest priority.
Data_3_In is treated as the MSB, and will have the lowest priority.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Low_Priority_Encoder_4_2 (
    input        Enable_In,

    input        Data_0_In,
    input        Data_1_In,
    input        Data_2_In,
    input        Data_3_In,
    
    output [1:0] Encoded_Value_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg [1:0] Encoded_Value = 2'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Encoded_Value_Out = Enable_In ? Encoded_Value : 2'bZ;



// --------------------------------------------------
// Low_Priority_Encoder_4_2 Logic
// --------------------------------------------------
always @ (*)
    begin
        casex ({Data_0_In, Data_1_In, Data_2_In, Data_3_In})
            4'b1xxx : begin Encoded_Value <= 2'd3; end
            4'b01xx : begin Encoded_Value <= 2'd2; end
            4'b001x : begin Encoded_Value <= 2'd1; end
            4'b0001 : begin Encoded_Value <= 2'd0; end
            default : begin Encoded_Value <= 2'dZ; end
        endcase
    end



endmodule
