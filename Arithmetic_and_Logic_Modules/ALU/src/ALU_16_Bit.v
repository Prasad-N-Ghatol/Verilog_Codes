/*
--------------------------------------------------
Module :
--------------------------------------------------
ALU_16_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16-Bit ALU.

This ALU operates on two 16-Bit Words (Data_A and Data_B),
and the result is a 16-Bit Word (Result) along with a Carry_Out.

The operations are divided into 2 categories, with 8 operations in each category.
The supported categories and operations are:

1) Arithmetic Operations:
    4'h0 : A + 1
    4'h1 : A - 1
    4'h2 : A + B
    4'h3 : A - B
    4'h4 : B - A
    4'h5 : A * B
    4'h6 : A / B
    4'h7 : A % B

2) Logical Operations:
    4'h8 : A AND B
    4'h9 : A OR B
    4'hA : NOT A
    4'hB : NOT B
    4'hC : A NAND B
    4'hD : A NOR B
    4'hE : A XOR B
    4'hF : A XNOR B


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module ALU_16_Bit (
    input         Enable_In,

    input  [3:0]  ALU_Operation_Select_In,

    input  [15:0] Data_A_In,
    input  [15:0] Data_B_In,

    output [15:0] Result_Out,
    output        Carry_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg [16:0] ALU_Results = 17'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Result_Out = Enable_In ? ALU_Results[15:0] : 16'bZ;
assign Carry_Out  = Enable_In ? ALU_Results[16]   : 1'bZ;



// --------------------------------------------------
// ALU_16_Bit Logic
// --------------------------------------------------
always @ (*)
    begin
        case (ALU_Operation_Select_In)
            // Arithmetic Operations
            4'h0    : begin ALU_Results <= Data_A_In + 1'b1;            end // A + 1
            4'h1    : begin ALU_Results <= Data_A_In - 1'b1;            end // A - 1
            4'h2    : begin ALU_Results <= Data_A_In + Data_B_In;       end // A + B
            4'h3    : begin ALU_Results <= Data_A_In - Data_B_In;       end // A - B
            4'h4    : begin ALU_Results <= Data_B_In - Data_A_In;       end // B - A
            4'h5    : begin ALU_Results <= Data_A_In * Data_B_In;       end // A * B
            4'h6    : begin ALU_Results <= Data_A_In / Data_B_In;       end // A / B
            4'h7    : begin ALU_Results <= Data_A_In % Data_B_In;       end // A % B

            // Logical Operations
            4'h8    : begin ALU_Results <= Data_A_In & Data_B_In;       end // A AND B
            4'h9    : begin ALU_Results <= Data_A_In | Data_B_In;       end // A OR B
            4'hA    : begin ALU_Results <= ~Data_A_In;                  end // NOT A
            4'hB    : begin ALU_Results <= ~Data_B_In;                  end // NOT B
            4'hC    : begin ALU_Results <= ~(Data_A_In & Data_B_In);    end // A NAND B
            4'hD    : begin ALU_Results <= ~(Data_A_In | Data_B_In);    end // A NOR B
            4'hE    : begin ALU_Results <= Data_A_In ^ Data_B_In;       end // A XOR B
            4'hF    : begin ALU_Results <= ~(Data_A_In ^ Data_B_In);    end // A XNOR B

            default : begin ALU_Results <= 17'b0;                       end
        endcase
    end



endmodule
