/*
--------------------------------------------------
Module :
--------------------------------------------------
Decade_Counter_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the Decade Counter Implementation.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Decade_Counter_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg        Clk_In                           = 1'b0;
reg        Reset_In                         = 1'b0;
reg        Enable_In                        = 1'b0;

reg        Start_Counter_Command_In         = 1'b0;
reg        Stop_Counter_Command_In          = 1'b0;
reg        Load_Counter_Value_Command_In    = 1'b0;

reg  [3:0] Preload_Counter_Value_In         = 4'b0;

wire       Counter_Running_Flag_Out;
wire       Counter_Rollover_Flag_Out;
wire [3:0] Counter_Count_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire       DUT_r_Counter_Running    = DUT.r_Counter_Running;
wire       DUT_r_Counter_Rollover   = DUT.r_Counter_Rollover;

wire [3:0] DUT_r_Counter_Value      = DUT.r_Counter_Value;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic       tb_Reset_In                         = 1'b0;
logic       tb_Enable_In                        = 1'b0;

logic       tb_Start_Counter_Command_In         = 1'b0;
logic       tb_Stop_Counter_Command_In          = 1'b0;
logic       tb_Load_Counter_Value_Command_In    = 1'b0;

logic [3:0] tb_Preload_Counter_Value_In         = 4'b0;

logic       tb_Counter_Running_Flag_Out;
logic       tb_Counter_Rollover_Flag_Out;
logic [3:0] tb_Counter_Count_Out;

logic       tb_Counter_Rollover_Flag            = 1'b0;
logic       tb_Counter_Running_Flag             = 1'b0;
logic [3:0] tb_Counter_Count                    = 4'b0;

logic [3:0] tb_Counter_Load_Value               = 4'b0;



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
// Decade_Counter DUT Instantiation
// --------------------------------------------------
Decade_Counter DUT (
    .Clk_In                         (Clk_In),
    .Reset_In                       (Reset_In),
    .Enable_In                      (Enable_In),

    .Start_Counter_Command_In       (Start_Counter_Command_In),
    .Stop_Counter_Command_In        (Stop_Counter_Command_In),
    .Load_Counter_Value_Command_In  (Load_Counter_Value_Command_In),

    .Preload_Counter_Value_In       (Preload_Counter_Value_In),

    .Counter_Running_Flag_Out       (Counter_Running_Flag_Out),
    .Counter_Rollover_Flag_Out      (Counter_Rollover_Flag_Out),
    .Counter_Count_Out              (Counter_Count_Out)
);



// --------------------------------------------------
// Decade_Counter VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Decade_Counter.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [5:0] f_Actual_Value, input logic [5:0] f_Expected_Value);
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
// Set the Decade Counter Input Values
task Set_Decade_Counter(input logic f_Reset_In, input logic f_Enable_In, input logic f_Start_Counter_Command_In, input logic f_Stop_Counter_Command_In, input logic f_Load_Counter_Value_Command_In, input logic [3:0] f_Preload_Counter_Value_In);
    begin
        #10;

        Reset_In                        <= f_Reset_In;
        Enable_In                       <= f_Enable_In;
        Start_Counter_Command_In        <= f_Start_Counter_Command_In;
        Stop_Counter_Command_In         <= f_Stop_Counter_Command_In;
        Load_Counter_Value_Command_In   <= f_Load_Counter_Value_Command_In;
        Preload_Counter_Value_In        <= f_Preload_Counter_Value_In;

        tb_Reset_In                         <= f_Reset_In;
        tb_Enable_In                        <= f_Enable_In;
        tb_Start_Counter_Command_In         <= f_Start_Counter_Command_In;
        tb_Stop_Counter_Command_In          <= f_Stop_Counter_Command_In;
        tb_Load_Counter_Value_Command_In    <= f_Load_Counter_Value_Command_In;
        tb_Preload_Counter_Value_In         <= f_Preload_Counter_Value_In;

        #10;
    end
endtask

// Check the Decade Counter
task Check_Decade_Counter();
    begin
        Check_Actual_vs_Expected_Value({Counter_Running_Flag_Out, Counter_Rollover_Flag_Out, Counter_Count_Out}, {tb_Counter_Running_Flag_Out, tb_Counter_Rollover_Flag_Out, tb_Counter_Count_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                                 , $time,
            "Reset_In = 0x%1b , "                       , Reset_In,
            "Enable_In = 0x%1b , "                      , Enable_In,
            "Start_Counter_Command_In = 0x%1b , "       , Start_Counter_Command_In,
            "Stop_Counter_Command_In = 0x%1b , "        , Stop_Counter_Command_In,
            "Load_Counter_Value_Command_In = 0x%1b , "  , Load_Counter_Value_Command_In,
            "Preload_Counter_Value_In = 0x%1h , "       , Preload_Counter_Value_In,
            "Counter_Running_Flag_Out = 0x%1b , "       , Counter_Running_Flag_Out,
            "Counter_Rollover_Flag_Out = 0x%1b , "      , Counter_Rollover_Flag_Out,
            "Counter_Count_Out = 0x%1h , "              , Counter_Count_Out,
            "tb_Counter_Running_Flag_Out = 0x%1b , "    , tb_Counter_Running_Flag_Out,
            "tb_Counter_Rollover_Flag_Out = 0x%1b , "   , tb_Counter_Rollover_Flag_Out,
            "tb_Counter_Count_Out = 0x%1h , "           , tb_Counter_Count_Out,
            "Is_Same = %1b"                             , Is_Same
        ));
    end
endtask



// --------------------------------------------------
// Other Logic
// --------------------------------------------------
always @ (negedge Clk_In or posedge tb_Reset_In)
    begin
        if (tb_Reset_In)
            begin
                tb_Counter_Running_Flag <= 1'b0;
            end
        else if (tb_Start_Counter_Command_In)
            begin
                tb_Counter_Running_Flag <= 1'b1;
            end
        else if (tb_Stop_Counter_Command_In)
            begin
                tb_Counter_Running_Flag <= 1'b0;
            end
        else
            begin
                tb_Counter_Running_Flag <= tb_Counter_Running_Flag;
            end
    end

// Testbench Decade_Counter
always @ (negedge Clk_In or posedge tb_Reset_In)
    begin
        if (tb_Reset_In)
            begin
                tb_Counter_Count            <= 4'b0;
                tb_Counter_Rollover_Flag    <= 1'b0;
            end
        else if ((tb_Counter_Running_Flag == 1'b0) && (tb_Load_Counter_Value_Command_In == 1'b1))
            begin
                tb_Counter_Count            <= ((tb_Preload_Counter_Value_In > 4'd9) ? 4'd9 : tb_Preload_Counter_Value_In);
                tb_Counter_Rollover_Flag    <= 1'b0;
            end
        else if (tb_Counter_Running_Flag)
            begin
                if (tb_Counter_Count >= 4'd9)
                    begin
                        tb_Counter_Count            <= 4'b0;
                        tb_Counter_Rollover_Flag    <= 1'b1;
                    end
                else
                    begin
                        tb_Counter_Count            <= tb_Counter_Count + 1'b1;
                        tb_Counter_Rollover_Flag    <= 1'b0;
                    end
            end
        else
            begin
                tb_Counter_Count            <= tb_Counter_Count;
                tb_Counter_Rollover_Flag    <= 1'b0;
            end
    end


assign tb_Counter_Count_Out         = tb_Enable_In ? tb_Counter_Count           : 4'bZ;
assign tb_Counter_Rollover_Flag_Out = tb_Enable_In ? tb_Counter_Rollover_Flag   : 1'bZ;
assign tb_Counter_Running_Flag_Out  = tb_Enable_In ? tb_Counter_Running_Flag    : 1'bZ;



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        forever
            begin
                #20;
                Check_Decade_Counter();
            end
    end

initial
    begin
        Open_File("../../Transcript/Decade_Counter_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Decade_Counter - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        tb_Counter_Load_Value = $random();

        Write_To_File_And_Display($sformatf("Default State - With Enable ON"));
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Reset the Counter - With Enable ON"));
        Set_Decade_Counter(1'b1, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Enable the Counter - Enable OFF then ON"));
        Set_Decade_Counter(1'b0, 1'b0, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Start the Counter"));
        Set_Decade_Counter(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, tb_Counter_Load_Value);
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #300; // 15 Clock Cycles

        Write_To_File_And_Display($sformatf("Stop the Counter"));
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, tb_Counter_Load_Value);
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Reset the Counter - With Enable ON"));
        Set_Decade_Counter(1'b1, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Load the Counter"));
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, tb_Counter_Load_Value);
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);

        Write_To_File_And_Display($sformatf("Start the Counter"));
        Set_Decade_Counter(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, tb_Counter_Load_Value);
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #300; // 15 Clock Cycles

        Write_To_File_And_Display($sformatf("Stop the Counter"));
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, tb_Counter_Load_Value);
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #40; // 2 Clock Cycles

        tb_Counter_Load_Value = $random();
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Load the Counter"));
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, tb_Counter_Load_Value);
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);

        Write_To_File_And_Display($sformatf("Start the Counter"));
        Set_Decade_Counter(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, tb_Counter_Load_Value);
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #60; // 3 Clock Cycles
        Set_Decade_Counter(1'b0, 1'b0, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #60; // 3 Clock Cycles
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #180; // 9 Clock Cycles

        Write_To_File_And_Display($sformatf("Stop the Counter"));
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, tb_Counter_Load_Value);
        Set_Decade_Counter(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, tb_Counter_Load_Value);
        #40; // 2 Clock Cycles

        Display_Results();
        Close_File();
        $stop;
    end




endmodule
