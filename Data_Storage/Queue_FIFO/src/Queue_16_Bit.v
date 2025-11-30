/*
--------------------------------------------------
Module :
--------------------------------------------------
Queue_16_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16-Bit Queue.

This implementation is for a memory region of 16-Words, with each Data Word being a 16-Bit Data.

Data Transfer on a queue is done using "Enqueue", "Dequeue", "Peak" ports.


====================================================================================
I/O Pins                        : Description
====================================================================================
Clk_In                          : Input Clock to the DUT
Reset_In                        : Reset the Pointers
Enable_In                       : Enable the Output Signals
------------------------------  : --------------------------------------------------
Enqueue_Data_Signal_In          : Write the data on "Queue_Write_Data_In" onto the Queue
Dequeue_Data_Signal_In          : Read data on Queue from the "Queue_Read_Data_Out"
Peak_Data_Signal_In             : Peak at the data at the Top (Queue Pointer) of the Queue
------------------------------  : --------------------------------------------------
Queue_Empty_Signal_Out          : Signal to indicate if Queue is empty
Queue_Full_Signal_Out           : Signal to indicate if Queue is full
Queue_Overflow_Signal_Out       : Signal to indicate if Queue Overflow has occurred
Queue_Underflow_Signal_Out      : Signal to indicate if Queue Underflow has occurred
------------------------------  : --------------------------------------------------
Front_Pointer_Out               : Current value of the Front Pointer of Queue
Rear_Pointer_Out                : Current value of the Rear Pointer of Queue
Queue_Write_Data_In             : Data to be written to the Write Memory address
Queue_Read_Data_Out             : Data read from the Write Memory address
====================================================================================


Note :
--------------------------------------------------
The "(* ramstyle = "M10K" *)" declaration for the Register Array, will instantiate a Memory Block on the Quartus Prime Tool, for FPGA's with M10K Memory Blocks.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Queue_16_Bit (
    input           Clk_In,
    input           Reset_In,
    input           Enable_In,

    input           Enqueue_Data_Signal_In,
    input           Dequeue_Data_Signal_In,
    input           Peak_Data_Signal_In,

    output          Queue_Empty_Signal_Out,
    output          Queue_Full_Signal_Out,
    output          Queue_Overflow_Signal_Out,
    output          Queue_Underflow_Signal_Out,

    output [3:0]    Front_Pointer_Out,
    output [3:0]    Rear_Pointer_Out,
    input  [15:0]   Queue_Write_Data_In,
    output [15:0]   Queue_Read_Data_Out
);



// --------------------------------------------------
// Memory
// --------------------------------------------------
// The "(* ramstyle = "M10K" *)" declaration, will instantiate a Memory Block on the Quartus Prime Tool, for FPGA's with M10K Memory Blocks.
(* ramstyle = "M10K" *) reg [15:0] SRAM_MEMORY [15:0];



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg  [4:0] r_Front_Pointer = {1'b0, 4'h0};
reg  [4:0] r_Rear_Pointer  = {1'b0, 4'h0};

wire        w_Enqueue_Data_Signal_In;
wire        w_Dequeue_Data_Signal_In;
wire        w_Peak_Data_Signal_In;

reg         w_Queue_Empty_Signal = 1'b0;
reg         w_Queue_Full_Signal  = 1'b0;
reg         r_Queue_Overflow_Signal  = 1'b0;
reg         r_Queue_Underflow_Signal = 1'b0;

wire [3:0]  w_Front_Pointer_Out;
wire [3:0]  w_Rear_Pointer_Out;
wire [15:0] w_Queue_Write_Data;
reg  [15:0] r_Queue_Read_Data = 16'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign w_Enqueue_Data_Signal_In     = Enable_In ? Enqueue_Data_Signal_In    : 1'b0;
assign w_Dequeue_Data_Signal_In     = Enable_In ? Dequeue_Data_Signal_In    : 1'b0;
assign w_Peak_Data_Signal_In        = Enable_In ? Peak_Data_Signal_In       : 1'b0;

assign Queue_Empty_Signal_Out       = Enable_In ? w_Queue_Empty_Signal      : 1'bZ;
assign Queue_Full_Signal_Out        = Enable_In ? w_Queue_Full_Signal       : 1'bZ;
assign Queue_Overflow_Signal_Out    = Enable_In ? r_Queue_Overflow_Signal   : 1'bZ;
assign Queue_Underflow_Signal_Out   = Enable_In ? r_Queue_Underflow_Signal  : 1'bZ;

assign Front_Pointer_Out            = Enable_In ? w_Front_Pointer_Out       : 4'bZ;
assign Rear_Pointer_Out             = Enable_In ? w_Rear_Pointer_Out        : 4'bZ;
assign w_Queue_Write_Data           = Enable_In ? Queue_Write_Data_In       : 16'b0;
assign Queue_Read_Data_Out          = Enable_In ? r_Queue_Read_Data         : 16'bZ;

assign w_Front_Pointer_Out = r_Front_Pointer[3:0];
assign w_Rear_Pointer_Out  = r_Rear_Pointer[3:0];



// --------------------------------------------------
// Other Logic
// --------------------------------------------------
// Queue Full/Empty
always @ (*)
    begin
        if (w_Front_Pointer_Out == w_Rear_Pointer_Out)
            begin
                if (r_Front_Pointer[4] == r_Rear_Pointer[4])
                    begin
                        w_Queue_Empty_Signal <= 1'b1;
                        w_Queue_Full_Signal  <= 1'b0;
                    end
                else
                    begin
                        w_Queue_Empty_Signal <= 1'b0;
                        w_Queue_Full_Signal  <= 1'b1;
                    end
            end
        else
            begin
                w_Queue_Empty_Signal <= 1'b0;
                w_Queue_Full_Signal  <= 1'b0;
            end
    end



// --------------------------------------------------
// Queue_16_Bit Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                r_Front_Pointer          <= {1'b0, 4'h0};
                r_Rear_Pointer           <= {1'b0, 4'h0};
                r_Queue_Overflow_Signal  <= 1'b0;
                r_Queue_Underflow_Signal <= 1'b0;
                r_Queue_Read_Data        <= 16'b0;
            end
        else if (w_Enqueue_Data_Signal_In)
            begin
                if (w_Queue_Full_Signal)
                    begin
                        r_Front_Pointer          <= r_Front_Pointer;
                        r_Queue_Overflow_Signal  <= 1'b1;
                    end
                else
                    begin
                        SRAM_MEMORY[r_Front_Pointer[3:0]]   <= w_Queue_Write_Data;
                        r_Front_Pointer                     <= r_Front_Pointer + 1'b1;
                        r_Queue_Overflow_Signal             <= 1'b0;
                    end
            end
        else if (w_Dequeue_Data_Signal_In)
            begin
                if (w_Queue_Empty_Signal)
                    begin
                        r_Queue_Read_Data        <= 16'b0;
                        r_Rear_Pointer           <= r_Rear_Pointer;
                        r_Queue_Underflow_Signal <= 1'b1;
                    end
                else
                    begin
                        r_Queue_Read_Data        <= SRAM_MEMORY[r_Rear_Pointer[3:0]];
                        r_Rear_Pointer           <= r_Rear_Pointer + 1'b1;
                        r_Queue_Underflow_Signal <= 1'b0;
                    end
            end
        else if (w_Peak_Data_Signal_In)
            begin
                if (w_Queue_Empty_Signal)
                    begin
                        r_Queue_Read_Data        <= 16'b0;
                        r_Rear_Pointer           <= r_Rear_Pointer;
                        r_Queue_Underflow_Signal <= 1'b1;
                    end
                else
                    begin
                        r_Queue_Read_Data        <= SRAM_MEMORY[r_Rear_Pointer[3:0]];
                        r_Rear_Pointer           <= r_Rear_Pointer;
                        r_Queue_Underflow_Signal <= 1'b0;
                    end
            end
        else
            begin
                r_Front_Pointer          <= r_Front_Pointer;
                r_Rear_Pointer           <= r_Rear_Pointer;
                r_Queue_Overflow_Signal  <= 1'b0;
                r_Queue_Underflow_Signal <= 1'b0;
                r_Queue_Read_Data        <= r_Queue_Read_Data;
            end
    end



endmodule
