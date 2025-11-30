/*
--------------------------------------------------
Module :
--------------------------------------------------
SRAM_Dual_Port_8_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 8-Bit Dual Port SRAM.

This implementation is for a memory region of 16-Words, with each Data Word being a 8-Bit Data.

In this implementation, Read Signal has a higher priority that the Write Signal.


====================================================================================
I/O Pins                        : Description
====================================================================================
Clk_In                          : Input Clock to the DUT
Enable_In                       : Enable the Output Signals
------------------------------  : --------------------------------------------------
Port_1_Write_Enable_In          : Port 1 - Write Enable Signals for the Memory Write Operations
Port_1_Read_Enable_In           : Port 1 - Read Enable Signals for the Memory Read Operations
Port_1_Address_In               : Port 1 - Address for the Data to be Read/Write from/to
Port_1_Write_Data_In            : Port 1 - Data to be written to the Write Memory address
Port_1_Read_Data_Out            : Port 1 - Data read from the Write Memory address
------------------------------  : --------------------------------------------------
Port_2_Write_Enable_In          : Port 2 - Write Enable Signals for the Memory Write Operations
Port_2_Read_Enable_In           : Port 2 - Read Enable Signals for the Memory Read Operations
Port_2_Address_In               : Port 2 - Address for the Data to be Read/Write from/to
Port_2_Write_Data_In            : Port 2 - Data to be written to the Write Memory address
Port_2_Read_Data_Out            : Port 2 - Data read from the Write Memory address
====================================================================================


Note :
--------------------------------------------------
The "(* ramstyle = "M10K" *)" declaration for the Register Array, will instantiate a Memory Block on the Quartus Prime Tool, for FPGA's with M10K Memory Blocks.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module SRAM_Dual_Port_8_Bit (
    input           Clk_In,
    input           Enable_In,

    input           Port_1_Write_Enable_In,
    input           Port_1_Read_Enable_In,
    input  [3:0]    Port_1_Address_In,
    input  [7:0]    Port_1_Write_Data_In,
    output [7:0]    Port_1_Read_Data_Out,

    input           Port_2_Write_Enable_In,
    input           Port_2_Read_Enable_In,
    input  [3:0]    Port_2_Address_In,
    input  [7:0]    Port_2_Write_Data_In,
    output [7:0]    Port_2_Read_Data_Out
);



// --------------------------------------------------
// Memory
// --------------------------------------------------
// The "(* ramstyle = "M10K" *)" declaration, will instantiate a Memory Block on the Quartus Prime Tool, for FPGA's with M10K Memory Blocks.
(* ramstyle = "M10K" *) reg [7:0] SRAM_MEMORY [15:0];



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
wire       w_Port_1_Write_Enable;
wire       w_Port_1_Read_Enable;
wire [3:0] w_Port_1_Address;
wire [7:0] w_Port_1_Write_Data;
reg  [7:0] r_Port_1_Read_Data = 8'b0;

wire       w_Port_2_Write_Enable;
wire       w_Port_2_Read_Enable;
wire [3:0] w_Port_2_Address;
wire [7:0] w_Port_2_Write_Data;
reg  [7:0] r_Port_2_Read_Data = 8'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign w_Port_1_Write_Enable    = Enable_In                             ? Port_1_Write_Enable_In : 1'b0;
assign w_Port_1_Read_Enable     = Enable_In                             ? Port_1_Read_Enable_In  : 1'b0;
assign w_Port_1_Address         = Enable_In                             ? Port_1_Address_In      : 4'b0;
assign w_Port_1_Write_Data      = Enable_In                             ? Port_1_Write_Data_In   : 8'b0;
assign Port_1_Read_Data_Out     = (Enable_In && w_Port_1_Read_Enable)   ? r_Port_1_Read_Data     : 8'bZ;

assign w_Port_2_Write_Enable    = Enable_In                             ? Port_2_Write_Enable_In : 1'b0;
assign w_Port_2_Read_Enable     = Enable_In                             ? Port_2_Read_Enable_In  : 1'b0;
assign w_Port_2_Address         = Enable_In                             ? Port_2_Address_In      : 4'b0;
assign w_Port_2_Write_Data      = Enable_In                             ? Port_2_Write_Data_In   : 8'b0;
assign Port_2_Read_Data_Out     = (Enable_In && w_Port_2_Read_Enable)   ? r_Port_2_Read_Data     : 8'bZ;



// --------------------------------------------------
// SRAM_Dual_Port_8_Bit Logic
// --------------------------------------------------
always @ (negedge Clk_In)
    begin
        // Port 1
        if (w_Port_1_Read_Enable)
            begin
                r_Port_1_Read_Data <= SRAM_MEMORY[w_Port_1_Address];
            end
        else if (w_Port_1_Write_Enable)
            begin
                SRAM_MEMORY[w_Port_1_Address] <= w_Port_1_Write_Data;
            end

        // Port 2
        if (w_Port_2_Read_Enable)
            begin
                r_Port_2_Read_Data <= SRAM_MEMORY[w_Port_2_Address];
            end
        else if (w_Port_2_Write_Enable)
            begin
                SRAM_MEMORY[w_Port_2_Address] <= w_Port_2_Write_Data;
            end
    end



endmodule
