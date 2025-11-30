/*
--------------------------------------------------
Module :
--------------------------------------------------
SROM_Single_Port_16_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16-Bit Single Port SROM.

This implementation is for a memory region of 16-Words, with each Data Word being a 16-Bit Data.

In this implementation, Read Signal has a higher priority that the Write Signal.

The "MEM_INIT_HEX_16_Bit.hex" file contains the set of 16 Words of 16-Bit Data, which is used as the ROM contents.


====================================================================================
I/O Pins                        : Description
====================================================================================
Clk_In                          : Input Clock to the DUT
Enable_In                       : Enable the Output Signals
------------------------------  : --------------------------------------------------
Port_1_Read_Enable_In           : Read Enable Signals for the Memory Read Operations
Port_1_Address_In               : Address for the Data to be Read/Write from/to
Port_1_Read_Data_Out            : Data read from the Write Memory address
====================================================================================


Note :
--------------------------------------------------
The "(* ramstyle = "M10K" *)" declaration for the Register Array, will instantiate a Memory Block on the Quartus Prime Tool, for FPGA's with M10K Memory Blocks.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module SROM_Single_Port_16_Bit (
    input           Clk_In,
    input           Enable_In,

    input           Port_1_Read_Enable_In,
    input  [3:0]    Port_1_Address_In,
    output [15:0]   Port_1_Read_Data_Out
);



// --------------------------------------------------
// Memory
// --------------------------------------------------
// The "(* ramstyle = "M10K" *)" declaration, will instantiate a Memory Block on the Quartus Prime Tool, for FPGA's with M10K Memory Blocks.
(* ramstyle = "M10K" *) reg [15:0] SROM_MEMORY [15:0];



// --------------------------------------------------
// Memory Instantiation
// --------------------------------------------------
initial
    begin
        $readmemh("MEM_INIT_HEX_16_Bit.hex", SROM_MEMORY);
    end



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire        w_Port_1_Read_Enable;
wire [3:0]  w_Port_1_Address;
reg  [15:0] r_Port_1_Read_Data = 16'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign w_Port_1_Read_Enable     = Enable_In                             ? Port_1_Read_Enable_In  : 1'b0;
assign w_Port_1_Address         = Enable_In                             ? Port_1_Address_In      : 3'b0;
assign Port_1_Read_Data_Out     = (Enable_In && w_Port_1_Read_Enable)   ? r_Port_1_Read_Data     : 16'bZ;



// --------------------------------------------------
// SROM_Single_Port_16_Bit Logic
// --------------------------------------------------
always @ (negedge Clk_In)
    begin
        if (w_Port_1_Read_Enable)
            begin
                r_Port_1_Read_Data <= SROM_MEMORY[w_Port_1_Address];
            end
    end



endmodule
