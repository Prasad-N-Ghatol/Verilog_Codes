/*
--------------------------------------------------
Module :
--------------------------------------------------
Ring_Counter_8_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 8-Bit Ring Counter.


====================================================================================
I/O Pins                        : Description
====================================================================================
Clk_In                          : Input Clock to the DUT 
Reset_In                        : Resets the DUT
Enable_In                       : Enable the Output Signals
------------------------------  : --------------------------------------------------
Start_Counter_Command_In        : Start the Counter
Stop_Counter_Command_In         : Stop the Counter
------------------------------  : --------------------------------------------------
Counter_Running_Flag_Out        : Flag to indicate whether the counter is running or not
Counter_Count_Out               : Counter value
====================================================================================



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Ring_Counter_8_Bit (
    input        Clk_In,
    input        Reset_In,
    input        Enable_In,

    input        Start_Counter_Command_In,
    input        Stop_Counter_Command_In,

    output       Counter_Running_Flag_Out,
    output [7:0] Counter_Count_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg        r_Counter_Running = 1'b0;

reg  [7:0] r_Counter_Value = 8'b1;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Counter_Count_Out         = Enable_In ? r_Counter_Value    : 8'bZ;

assign Counter_Running_Flag_Out  = Enable_In ? r_Counter_Running  : 1'bZ;



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
// Ring_Counter_8_Bit Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                r_Counter_Value <= 8'b1;
            end
        else if (r_Counter_Running)
            begin
                r_Counter_Value <= {r_Counter_Value[6:0], r_Counter_Value[7]};
            end
        else
            begin
                r_Counter_Value <= r_Counter_Value;
            end
    end



endmodule
