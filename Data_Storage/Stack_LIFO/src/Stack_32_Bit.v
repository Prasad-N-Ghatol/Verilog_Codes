/*
--------------------------------------------------
Module :
--------------------------------------------------
Stack_32_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 32-Bit Stack.

This implementation is for a memory region of 16-Words, with each Data Word being a 32-Bit Data.

Data Transfer on a stack is done using "Push", "Pop", "Peak" ports.

This is an Empty Descending Stack, and has a Depth of 16-Words.


====================================================================================
I/O Pins                        : Description
====================================================================================
Clk_In                          : Input Clock to the DUT
Reset_In                        : Reset the SP
Enable_In                       : Enable the Output Signals
------------------------------  : --------------------------------------------------
Push_Data_Signal_In             : Write the data on "Stack_Write_Data_In" onto the Stack
Pop_Data_Signal_In              : Read data on Stack from the "Stack_Read_Data_Out"
Peak_Data_Signal_In             : Peak at the data at the Top (Stack Pointer) of the Stack
------------------------------  : --------------------------------------------------
Stack_Empty_Signal_Out          : Signal to indicate if Stack is empty
Stack_Full_Signal_Out           : Signal to indicate if Stack is full
Stack_Overflow_Signal_Out       : Signal to indicate if Stack Overflow has occurred
Stack_Underflow_Signal_Out      : Signal to indicate if Stack Underflow has occurred
------------------------------  : --------------------------------------------------
SP_Value_Out                    : Current value of the Stack Pointer
Stack_Write_Data_In             : Data to be written to the Write Memory address
Stack_Read_Data_Out             : Data read from the Write Memory address
====================================================================================


Note :
--------------------------------------------------
The "(* ramstyle = "M10K" *)" declaration for the Register Array, will instantiate a Memory Block on the Quartus Prime Tool, for FPGA's with M10K Memory Blocks.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Stack_32_Bit (
    input           Clk_In,
    input           Reset_In,
    input           Enable_In,

    input           Push_Data_Signal_In,
    input           Pop_Data_Signal_In,
    input           Peak_Data_Signal_In,

    output          Stack_Empty_Signal_Out,
    output          Stack_Full_Signal_Out,
    output          Stack_Overflow_Signal_Out,
    output          Stack_Underflow_Signal_Out,

    output [3:0]    SP_Value_Out,
    input  [31:0]   Stack_Write_Data_In,
    output [31:0]   Stack_Read_Data_Out
);



// --------------------------------------------------
// Memory
// --------------------------------------------------
// The "(* ramstyle = "M10K" *)" declaration, will instantiate a Memory Block on the Quartus Prime Tool, for FPGA's with M10K Memory Blocks.
(* ramstyle = "M10K" *) reg [31:0] SRAM_MEMORY [15:0];



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg  [4:0] r_SP = {1'b1, 4'hF};

wire        w_Push_Data_Signal_In;
wire        w_Pop_Data_Signal_In;
wire        w_Peak_Data_Signal_In;

wire        w_Stack_Empty_Signal;
wire        w_Stack_Full_Signal;
reg         r_Stack_Overflow_Signal  = 1'b0;
reg         r_Stack_Underflow_Signal = 1'b0;

wire [3:0]  w_SP_Value_Out;
wire [31:0] w_Stack_Write_Data;
reg  [31:0] r_Stack_Read_Data = 32'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign w_Push_Data_Signal_In        = Enable_In ? Push_Data_Signal_In       : 1'b0;
assign w_Pop_Data_Signal_In         = Enable_In ? Pop_Data_Signal_In        : 1'b0;
assign w_Peak_Data_Signal_In        = Enable_In ? Peak_Data_Signal_In       : 1'b0;

assign Stack_Empty_Signal_Out       = Enable_In ? w_Stack_Empty_Signal      : 1'bZ;
assign Stack_Full_Signal_Out        = Enable_In ? w_Stack_Full_Signal       : 1'bZ;
assign Stack_Overflow_Signal_Out    = Enable_In ? r_Stack_Overflow_Signal   : 1'bZ;
assign Stack_Underflow_Signal_Out   = Enable_In ? r_Stack_Underflow_Signal  : 1'bZ;

assign SP_Value_Out                 = Enable_In ? w_SP_Value_Out            : 4'bZ;
assign w_Stack_Write_Data           = Enable_In ? Stack_Write_Data_In       : 32'b0;
assign Stack_Read_Data_Out          = Enable_In ? r_Stack_Read_Data         : 32'bZ;

assign w_SP_Value_Out = r_SP[3:0];

// Stack Full/Empty
assign w_Stack_Empty_Signal = (r_SP == {1'b1, 4'hF}) ? 1'b1 : 1'b0;
assign w_Stack_Full_Signal  = (r_SP == {1'b0, 4'hF}) ? 1'b1 : 1'b0;



// --------------------------------------------------
// Stack_32_Bit Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                r_SP                     <= {1'b1, 4'hF};
                r_Stack_Overflow_Signal  <= 1'b0;
                r_Stack_Underflow_Signal <= 1'b0;
                r_Stack_Read_Data        <= 32'b0;
            end
        else if (w_Push_Data_Signal_In)
            begin
                if (w_Stack_Full_Signal)
                    begin
                        r_SP                    <= r_SP;
                        r_Stack_Overflow_Signal <= 1'b1;
                    end
                else
                    begin
                        SRAM_MEMORY[r_SP[3:0]]  <= w_Stack_Write_Data;
                        r_SP                    <= r_SP - 1'b1;
                        r_Stack_Overflow_Signal <= 1'b0;
                    end
            end
        else if (w_Pop_Data_Signal_In)
            begin
                if (w_Stack_Empty_Signal)
                    begin
                        r_Stack_Read_Data        <= 32'b0;
                        r_SP                     <= r_SP;
                        r_Stack_Underflow_Signal <= 1'b1;
                    end
                else
                    begin
                        r_Stack_Read_Data        <= SRAM_MEMORY[r_SP[3:0] + 1'b1];
                        r_SP                     <= r_SP + 1'b1;
                        r_Stack_Underflow_Signal <= 1'b0;
                    end
            end
        else if (w_Peak_Data_Signal_In)
            begin
                if (w_Stack_Empty_Signal)
                    begin
                        r_Stack_Read_Data        <= 32'b0;
                        r_SP                     <= r_SP;
                        r_Stack_Underflow_Signal <= 1'b1;
                    end
                else
                    begin
                        r_Stack_Read_Data        <= SRAM_MEMORY[r_SP[3:0] + 1'b1];
                        r_SP                     <= r_SP;
                        r_Stack_Underflow_Signal <= 1'b0;
                    end
            end
        else
            begin
                r_SP                     <= r_SP;
                r_Stack_Overflow_Signal  <= 1'b0;
                r_Stack_Underflow_Signal <= 1'b0;
                r_Stack_Read_Data        <= r_Stack_Read_Data;
            end
    end



endmodule
