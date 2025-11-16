/*
--------------------------------------------------
Module :
--------------------------------------------------
MOD_Counter_4_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 4-Bit MOD Counter.


====================================================================================
I/O Pins                        : Description
====================================================================================
Clk_In                          : Input Clock to the DUT 
Reset_In                        : Resets the DUT
Enable_In                       : Enable the Output Signals
------------------------------  : --------------------------------------------------
Start_Counter_Command_In        : Start the Counter
Stop_Counter_Command_In         : Stop the Counter
Load_Counter_Value_Command_In   : Load the counter with the "Preload_Counter_Value_In" value, can only load the value if counter is stopped
------------------------------  : --------------------------------------------------
Preload_Counter_Value_In        : The Preload Value to be loaded into the counter
MOD_Value_In                    : The MOD Value of the counter
------------------------------  : --------------------------------------------------
Counter_Running_Flag_Out        : Flag to indicate whether the counter is running or not
Counter_Rollover_Flag_Out       : Flag to indicate that the counter has rolled-over the MOD value
Counter_Count_Out               : Counter value
====================================================================================



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module MOD_Counter_4_Bit (
    input        Clk_In,
    input        Reset_In,
    input        Enable_In,

    input        Start_Counter_Command_In,
    input        Stop_Counter_Command_In,
    input        Load_Counter_Value_Command_In,

    input  [3:0] Preload_Counter_Value_In,
    input  [3:0] MOD_Value_In,

    output       Counter_Running_Flag_Out,
    output       Counter_Rollover_Flag_Out,
    output [3:0] Counter_Count_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg        r_Counter_Running = 1'b0;
reg        r_Counter_Rollover = 1'b0;

reg  [3:0] r_Counter_Value = 4'b0;

wire [3:0] w_Preload_Counter_Count;
wire [3:0] w_Adjusted_MOD_Value;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Counter_Count_Out         = Enable_In ? r_Counter_Value    : 4'bZ;

assign Counter_Running_Flag_Out  = Enable_In ? r_Counter_Running  : 1'bZ;
assign Counter_Rollover_Flag_Out = Enable_In ? r_Counter_Rollover : 1'bZ;

assign w_Adjusted_MOD_Value    = MOD_Value_In - 1'b1;
assign w_Preload_Counter_Count = (Preload_Counter_Value_In > w_Adjusted_MOD_Value) ? w_Adjusted_MOD_Value : Preload_Counter_Value_In;



// --------------------------------------------------
// Other Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                r_Counter_Running <= 1'b0;
            end
        else if (Start_Counter_Command_In)
            begin
                r_Counter_Running <= 1'b1;
            end
        else if (Stop_Counter_Command_In)
            begin
                r_Counter_Running <= 1'b0;
            end
        else
            begin
                r_Counter_Running <= r_Counter_Running;
            end
    end



// --------------------------------------------------
// MOD_Counter_4_Bit Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                r_Counter_Value    <= 4'b0;
                r_Counter_Rollover <= 1'b0;
            end
        else if ((r_Counter_Running == 1'b0) && (Load_Counter_Value_Command_In == 1'b1))
            begin
                r_Counter_Value    <= w_Preload_Counter_Count;
                r_Counter_Rollover <= 1'b0;
            end
        else if (r_Counter_Running)
            begin
                if (r_Counter_Value >= w_Adjusted_MOD_Value)
                    begin
                        r_Counter_Value    <= 4'b0;
                        r_Counter_Rollover <= 1'b1;
                    end
                else
                    begin
                        r_Counter_Value    <= r_Counter_Value + 1'b1;
                        r_Counter_Rollover <= 1'b0;
                    end
            end
        else
            begin
                r_Counter_Value    <= r_Counter_Value;
                r_Counter_Rollover <= 1'b0;
            end
    end



endmodule
