/*
--------------------------------------------------
Module :
--------------------------------------------------
Timer_16_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16-Bit Timer.


====================================================================================
I/O Pins                        : Description
====================================================================================
Clk_In                          : Input Clock to the DUT 
Reset_In                        : Resets the DUT
Enable_In                       : Enable the Output Signals
------------------------------  : --------------------------------------------------
Start_Timer_Command_In          : Start the Timer
Stop_Timer_Command_In           : Stop the Timer
Timer_Periodic_Oneshotb_Mode_In : Operate the Timer in Periodic(1) / One-Shot(0) Mode, 
------------------------------  : --------------------------------------------------
Preload_Timer_Value_In          : The Preload Value to be loaded into the timer
------------------------------  : --------------------------------------------------
Timer_Running_Flag_Out          : Flag to indicate whether the timer is running or not
Timer_Rollover_Flag_Out         : Flag to indicate that the timer has rolled-over the MOD value
Timer_Count_Out                 : Timer value
====================================================================================



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Timer_16_Bit (
    input         Clk_In,
    input         Reset_In,
    input         Enable_In,

    input         Start_Timer_Command_In,
    input         Stop_Timer_Command_In,
    input         Timer_Periodic_Oneshotb_Mode_In,

    input  [15:0] Preload_Timer_Value_In,

    output        Timer_Running_Flag_Out,
    output        Timer_Rollover_Flag_Out,
    output [15:0] Timer_Count_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg         r_Timer_Running  = 1'b0;
reg         r_Timer_Rollover = 1'b0;

reg  [15:0] r_Timer_Value = 16'b0;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Timer_Count_Out         = Enable_In ? r_Timer_Value    : 16'bZ;

assign Timer_Running_Flag_Out  = Enable_In ? r_Timer_Running  : 1'bZ;
assign Timer_Rollover_Flag_Out = Enable_In ? r_Timer_Rollover : 1'bZ;



// --------------------------------------------------
// Timer_16_Bit Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                r_Timer_Running  <= 1'b0;
                r_Timer_Rollover <= 1'b0;
                r_Timer_Value    <= 16'b0;
            end
        else if (!r_Timer_Running && Start_Timer_Command_In)
            begin
                r_Timer_Running  <= 1'b1;
                r_Timer_Rollover <= 1'b0;
                r_Timer_Value    <= Preload_Timer_Value_In;
            end
        else if (Stop_Timer_Command_In)
            begin
                r_Timer_Running  <= 1'b0;
                r_Timer_Rollover <= 1'b0;
                r_Timer_Value    <= 16'b0;
            end
        else if (r_Timer_Running)
            begin
                if (r_Timer_Value == 16'b0)
                    begin
                        r_Timer_Rollover <= 1'b1;
                        
                        if (Timer_Periodic_Oneshotb_Mode_In)
                            begin
                                r_Timer_Running <= r_Timer_Running;
                                r_Timer_Value   <= Preload_Timer_Value_In;
                            end
                        else
                            begin
                                r_Timer_Running <= 1'b0;
                                r_Timer_Value   <= 16'b0;
                            end
                    end
                else
                    begin
                        r_Timer_Running  <= r_Timer_Running;
                        r_Timer_Rollover <= 1'b0;
                        r_Timer_Value    <= r_Timer_Value - 1'b1;
                    end
            end
        else
            begin
                r_Timer_Rollover <= 1'b0;
                r_Timer_Running  <= 1'b0;
                r_Timer_Value    <= 16'b0;
            end
    end



endmodule
