/*
--------------------------------------------------
Module :
--------------------------------------------------
Timer_32_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 32-Bit Timer Implementation.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Timer_32_Bit_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg         Clk_In                           = 1'b0;
reg         Reset_In                         = 1'b0;
reg         Enable_In                        = 1'b0;

reg         Start_Timer_Command_In           = 1'b0;
reg         Stop_Timer_Command_In            = 1'b0;
reg         Timer_Periodic_Oneshotb_Mode_In  = 1'b0;

reg  [31:0] Preload_Timer_Value_In           = 32'b0;

wire        Timer_Running_Flag_Out;
wire        Timer_Rollover_Flag_Out;
wire [31:0] Timer_Count_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire        DUT_r_Timer_Running    = DUT.r_Timer_Running;
wire        DUT_r_Timer_Rollover   = DUT.r_Timer_Rollover;

wire [31:0] DUT_r_Timer_Value      = DUT.r_Timer_Value;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic        tb_Reset_In                         = 1'b0;
logic        tb_Enable_In                        = 1'b0;

logic        tb_Start_Timer_Command_In           = 1'b0;
logic        tb_Stop_Timer_Command_In            = 1'b0;
logic        tb_Timer_Periodic_Oneshotb_Mode_In  = 1'b0;

logic [31:0] tb_Preload_Timer_Value_In           = 32'b0;

logic        tb_Timer_Running_Flag_Out;
logic        tb_Timer_Rollover_Flag_Out;
logic [31:0] tb_Timer_Count_Out;

logic        tb_Timer_Rollover_Flag              = 1'b0;
logic        tb_Timer_Running_Flag               = 1'b0;
logic [31:0] tb_Timer_Count                      = 32'b0;

logic        tb_Load_Timer                       = 1'b0;
logic [31:0] tb_Timer_Preload_Value              = 32'b0;



// --------------------------------------------------
// Testbench Checks
// --------------------------------------------------
// Check
bit Is_Same = 1'b0;

// Check Values
integer Passed_Checks = 0;
integer Failed_Checks = 0;
integer Total_Checks = 0;



// --------------------------------------------------
// Timer_32_Bit DUT Instantiation
// --------------------------------------------------
Timer_32_Bit DUT (
    .Clk_In                             (Clk_In),
    .Reset_In                           (Reset_In),
    .Enable_In                          (Enable_In),

    .Start_Timer_Command_In             (Start_Timer_Command_In),
    .Stop_Timer_Command_In              (Stop_Timer_Command_In),
    .Timer_Periodic_Oneshotb_Mode_In    (Timer_Periodic_Oneshotb_Mode_In),

    .Preload_Timer_Value_In             (Preload_Timer_Value_In),

    .Timer_Running_Flag_Out             (Timer_Running_Flag_Out),
    .Timer_Rollover_Flag_Out            (Timer_Rollover_Flag_Out),
    .Timer_Count_Out                    (Timer_Count_Out)
);



// --------------------------------------------------
// Timer_32_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Timer_32_Bit.vcd");
        $dumpvars;
    end



// --------------------------------------------------
// Time and Clock Initialization
// --------------------------------------------------
initial
    begin
        $timeformat(-9, 3, " ns", 16);
    end

initial
    begin
        Clk_In = 1'b0;

        forever
            begin
                #10;
                Clk_In = ~Clk_In;
            end
    end



// --------------------------------------------------
// File Handling
// --------------------------------------------------
// Transcript File Descriptor
static integer fd = 0;

// Open a File
task Open_File(string filename);
    fd = $fopen(filename, "w");
endtask

// Write data to the file and display it on the transcript
task Write_To_File_And_Display(string message);
    $fdisplay(fd, message);

    $display("%s", message);
endtask

// Close the file
task Close_File();
    $fclose(fd);
endtask



// --------------------------------------------------
// Testbench Check Tasks
// --------------------------------------------------
// Check if the f_Actual_Value is same as the f_Expected_Value
task Check_Actual_vs_Expected_Value (input logic [33:0] f_Actual_Value, input logic [33:0] f_Expected_Value);
    begin
        if (f_Actual_Value === f_Expected_Value)
            begin
                Is_Same = 1'b1;
                Passed_Checks = Passed_Checks + 1;
            end
        else
            begin
                Is_Same = 1'b0;
                Failed_Checks = Failed_Checks + 1;
            end
        
        Total_Checks = Total_Checks + 1;
    end
endtask

// Display the Test Results
task Display_Results();
    begin
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------"));
        Write_To_File_And_Display($sformatf("Test Results :"));
        Write_To_File_And_Display($sformatf("--------------------------------------------------"));
        Write_To_File_And_Display($sformatf("Passed_Checks = %d", Passed_Checks));
        Write_To_File_And_Display($sformatf("Failed_Checks = %d", Failed_Checks));
        Write_To_File_And_Display($sformatf("Total_Checks  = %d", Total_Checks));
        Write_To_File_And_Display($sformatf("--------------------------------------------------\n"));
    end
endtask



// --------------------------------------------------
// Tasks and Functions
// --------------------------------------------------
// Set the 32-Bit Timer Input Values
task Set_Timer_32_Bit(input logic f_Reset_In, input logic f_Enable_In, input logic f_Start_Timer_Command_In, input logic f_Stop_Timer_Command_In, input logic f_Timer_Periodic_Oneshotb_Mode_In, input logic [31:0] f_Preload_Timer_Value_In);
    begin
        #10;

        Reset_In                        <= f_Reset_In;
        Enable_In                       <= f_Enable_In;
        Start_Timer_Command_In          <= f_Start_Timer_Command_In;
        Stop_Timer_Command_In           <= f_Stop_Timer_Command_In;
        Timer_Periodic_Oneshotb_Mode_In <= f_Timer_Periodic_Oneshotb_Mode_In;
        Preload_Timer_Value_In          <= f_Preload_Timer_Value_In;

        tb_Reset_In                         <= f_Reset_In;
        tb_Enable_In                        <= f_Enable_In;
        tb_Start_Timer_Command_In           <= f_Start_Timer_Command_In;
        tb_Stop_Timer_Command_In            <= f_Stop_Timer_Command_In;
        tb_Timer_Periodic_Oneshotb_Mode_In  <= f_Timer_Periodic_Oneshotb_Mode_In;
        tb_Preload_Timer_Value_In           <= f_Preload_Timer_Value_In;

        #10;
    end
endtask

// Check the 32-Bit Timer
task Check_Timer_32_Bit();
    begin
        Check_Actual_vs_Expected_Value({Timer_Running_Flag_Out, Timer_Rollover_Flag_Out, Timer_Count_Out}, {tb_Timer_Running_Flag_Out, tb_Timer_Rollover_Flag_Out, tb_Timer_Count_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                                     , $time,
            "Reset_In = 0x%1b , "                           , Reset_In,
            "Enable_In = 0x%1b , "                          , Enable_In,
            "Start_Timer_Command_In = 0x%1b , "             , Start_Timer_Command_In,
            "Stop_Timer_Command_In = 0x%1b , "              , Stop_Timer_Command_In,
            "Timer_Periodic_Oneshotb_Mode_In = 0x%1b , "    , Timer_Periodic_Oneshotb_Mode_In,
            "Preload_Timer_Value_In = 0x%8h , "             , Preload_Timer_Value_In,
            "Timer_Running_Flag_Out = 0x%1b , "             , Timer_Running_Flag_Out,
            "Timer_Rollover_Flag_Out = 0x%1b , "            , Timer_Rollover_Flag_Out,
            "Timer_Count_Out = 0x%8h , "                    , Timer_Count_Out,
            "tb_Timer_Running_Flag_Out = 0x%1b , "          , tb_Timer_Running_Flag_Out,
            "tb_Timer_Rollover_Flag_Out = 0x%1b , "         , tb_Timer_Rollover_Flag_Out,
            "tb_Timer_Count_Out = 0x%8h , "                 , tb_Timer_Count_Out,
            "Is_Same = %1b"                                 , Is_Same
        ));
    end
endtask



// --------------------------------------------------
// Other Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge Reset_In)
    begin
        if (Reset_In)
            begin
                tb_Timer_Running_Flag  <= 1'b0;
                tb_Timer_Rollover_Flag <= 1'b0;
                tb_Timer_Count         <= 32'b0;
            end
        else if (!tb_Timer_Running_Flag && tb_Start_Timer_Command_In)
            begin
                tb_Timer_Running_Flag  <= 1'b1;
                tb_Timer_Rollover_Flag <= 1'b0;
                tb_Timer_Count         <= tb_Preload_Timer_Value_In;
            end
        else if (tb_Stop_Timer_Command_In)
            begin
                tb_Timer_Running_Flag  <= 1'b0;
                tb_Timer_Rollover_Flag <= 1'b0;
                tb_Timer_Count         <= 32'b0;
            end
        else if (tb_Timer_Running_Flag)
            begin
                if (tb_Timer_Count == 32'b0)
                    begin
                        tb_Timer_Rollover_Flag <= 1'b1;
                        
                        if (tb_Timer_Periodic_Oneshotb_Mode_In)
                            begin
                                tb_Timer_Running_Flag <= tb_Timer_Running_Flag;
                                tb_Timer_Count        <= tb_Preload_Timer_Value_In;
                            end
                        else
                            begin
                                tb_Timer_Running_Flag <= 1'b0;
                                tb_Timer_Count        <= 32'b0;
                            end
                    end
                else
                    begin
                        tb_Timer_Running_Flag  <= tb_Timer_Running_Flag;
                        tb_Timer_Rollover_Flag <= 1'b0;
                        tb_Timer_Count         <= tb_Timer_Count - 1'b1;
                    end
            end
        else
            begin
                tb_Timer_Rollover_Flag <= 1'b0;
                tb_Timer_Running_Flag  <= 1'b0;
                tb_Timer_Count         <= 32'b0;
            end
    end

assign tb_Timer_Count_Out         = tb_Enable_In ? tb_Timer_Count           : 32'bZ;
assign tb_Timer_Rollover_Flag_Out = tb_Enable_In ? tb_Timer_Rollover_Flag   : 1'bZ;
assign tb_Timer_Running_Flag_Out  = tb_Enable_In ? tb_Timer_Running_Flag    : 1'bZ;



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        forever
            begin
                #20;
                Check_Timer_32_Bit();
            end
    end

initial
    begin
        Open_File("../../Transcript/Timer_32_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Timer_32_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        tb_Timer_Preload_Value = 32'd5;

        Write_To_File_And_Display($sformatf("Default State - With Enable ON"));
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Reset the Timer - With Enable ON - Periodic Mode"));
        Set_Timer_32_Bit(1'b1, 1'b1, 1'b0, 1'b0, 1'b1, tb_Timer_Preload_Value);
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, tb_Timer_Preload_Value);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Enable the Timer - Enable OFF then ON - Periodic Mode"));
        Set_Timer_32_Bit(1'b0, 1'b0, 1'b0, 1'b0, 1'b1, tb_Timer_Preload_Value);
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, tb_Timer_Preload_Value);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Start the Timer - Periodic Mode"));
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b1, tb_Timer_Preload_Value);
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, tb_Timer_Preload_Value);
        #300; // 15 Clock Cycles

        Write_To_File_And_Display($sformatf("Stop the Timer - Periodic Mode"));
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b1, tb_Timer_Preload_Value);
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, tb_Timer_Preload_Value);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Reset the Timer - With Enable ON - One-Shot Mode"));
        Set_Timer_32_Bit(1'b1, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Load the Timer - One-Shot Mode"));
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);

        Write_To_File_And_Display($sformatf("Start the Timer - One-Shot Mode"));
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, tb_Timer_Preload_Value);
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);
        #300; // 15 Clock Cycles

        Write_To_File_And_Display($sformatf("Stop the Timer - One-Shot Mode"));
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, tb_Timer_Preload_Value);
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);
        #40; // 2 Clock Cycles

        tb_Timer_Preload_Value = 32'd15;
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Load the Timer - One-Shot Mode"));
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);

        Write_To_File_And_Display($sformatf("Start the Timer - One-Shot Mode"));
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, tb_Timer_Preload_Value);
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);
        #60; // 3 Clock Cycles
        Set_Timer_32_Bit(1'b0, 1'b0, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);
        #60; // 3 Clock Cycles
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);
        #180; // 9 Clock Cycles

        Write_To_File_And_Display($sformatf("Stop the Timer - One-Shot Mode"));
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, tb_Timer_Preload_Value);
        Set_Timer_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Timer_Preload_Value);
        #40; // 2 Clock Cycles

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
