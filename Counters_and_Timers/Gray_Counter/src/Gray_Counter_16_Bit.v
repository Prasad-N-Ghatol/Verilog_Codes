/*
--------------------------------------------------
Module :
--------------------------------------------------
Gray_Counter_16_Bit


--------------------------------------------------
Description :
--------------------------------------------------
This is a verilog code, to implement a 16-Bit MOD Gray Counter.


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
Counter_Gray_Count_Out          : Counter Gray value
====================================================================================



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
module Gray_Counter_16_Bit (
    input         Clk_In,
    input         Reset_In,
    input         Enable_In,

    input         Start_Counter_Command_In,
    input         Stop_Counter_Command_In,
    input         Load_Counter_Value_Command_In,

    input  [15:0] Preload_Counter_Value_In,
    input  [15:0] MOD_Value_In,

    output        Counter_Running_Flag_Out,
    output        Counter_Rollover_Flag_Out,
    output [15:0] Counter_Gray_Count_Out
);



// --------------------------------------------------
// Wires and Regs
// --------------------------------------------------
reg         r_Counter_Running  = 1'b0;
reg         r_Counter_Rollover = 1'b0;

reg  [15:0] r_Counter_Value = 16'b0;

wire [15:0] w_Counter_Gray_Count;
wire [15:0] w_Preload_Counter_Count;
wire [15:0] w_Adjusted_MOD_Value;



// --------------------------------------------------
// Assignments
// --------------------------------------------------
assign Counter_Gray_Count_Out    = Enable_In ? w_Counter_Gray_Count : 16'bZ;
assign Counter_Running_Flag_Out  = Enable_In ? r_Counter_Running    : 1'bZ;
assign Counter_Rollover_Flag_Out = Enable_In ? r_Counter_Rollover   : 1'bZ;

assign w_Adjusted_MOD_Value    = MOD_Value_In - 1'b1;
assign w_Preload_Counter_Count = (Preload_Counter_Value_In > w_Adjusted_MOD_Value) ? w_Adjusted_MOD_Value : Preload_Counter_Value_In;



// --------------------------------------------------
// Other Logic
// --------------------------------------------------
// Binary to Gray Converter 16-Bit
assign w_Counter_Gray_Count[15] = r_Counter_Value[15];
assign w_Counter_Gray_Count[14] = r_Counter_Value[14] ^ r_Counter_Value[15];
assign w_Counter_Gray_Count[13] = r_Counter_Value[13] ^ r_Counter_Value[14];
assign w_Counter_Gray_Count[12] = r_Counter_Value[12] ^ r_Counter_Value[13];
assign w_Counter_Gray_Count[11] = r_Counter_Value[11] ^ r_Counter_Value[12];
assign w_Counter_Gray_Count[10] = r_Counter_Value[10] ^ r_Counter_Value[11];
assign w_Counter_Gray_Count[9]  = r_Counter_Value[9]  ^ r_Counter_Value[10];
assign w_Counter_Gray_Count[8]  = r_Counter_Value[8]  ^ r_Counter_Value[9];
assign w_Counter_Gray_Count[7]  = r_Counter_Value[7]  ^ r_Counter_Value[8];
assign w_Counter_Gray_Count[6]  = r_Counter_Value[6]  ^ r_Counter_Value[7];
assign w_Counter_Gray_Count[5]  = r_Counter_Value[5]  ^ r_Counter_Value[6];
assign w_Counter_Gray_Count[4]  = r_Counter_Value[4]  ^ r_Counter_Value[5];
assign w_Counter_Gray_Count[3]  = r_Counter_Value[3]  ^ r_Counter_Value[4];
assign w_Counter_Gray_Count[2]  = r_Counter_Value[2]  ^ r_Counter_Value[3];
assign w_Counter_Gray_Count[1]  = r_Counter_Value[1]  ^ r_Counter_Value[2];
assign w_Counter_Gray_Count[0]  = r_Counter_Value[0]  ^ r_Counter_Value[1];


// Counter Run Command
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
// Gray_Counter_16_Bit Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                r_Counter_Value    <= 16'b0;
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
                        r_Counter_Value    <= 16'b0;
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
