/*
--------------------------------------------------
Module :
--------------------------------------------------
Ring_Counter_16_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 16-Bit Ring Counter Implementation.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Ring_Counter_16_Bit_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg         Clk_In                           = 1'b0;
reg         Reset_In                         = 1'b0;
reg         Enable_In                        = 1'b0;

reg         Start_Counter_Command_In         = 1'b0;
reg         Stop_Counter_Command_In          = 1'b0;

wire        Counter_Running_Flag_Out;
wire [15:0] Counter_Count_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire        DUT_r_Counter_Running    = DUT.r_Counter_Running;

wire [15:0] DUT_r_Counter_Value      = DUT.r_Counter_Value;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic        tb_Reset_In                         = 1'b0;
logic        tb_Enable_In                        = 1'b0;

logic        tb_Start_Counter_Command_In         = 1'b0;
logic        tb_Stop_Counter_Command_In          = 1'b0;

logic        tb_Counter_Running_Flag_Out;
logic [15:0] tb_Counter_Count_Out;

logic        tb_Counter_Running_Flag             = 1'b0;
logic [15:0] tb_Counter_Count                    = 16'b1;



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
// Ring_Counter_16_Bit DUT Instantiation
// --------------------------------------------------
Ring_Counter_16_Bit DUT (
    .Clk_In                         (Clk_In),
    .Reset_In                       (Reset_In),
    .Enable_In                      (Enable_In),

    .Start_Counter_Command_In       (Start_Counter_Command_In),
    .Stop_Counter_Command_In        (Stop_Counter_Command_In),

    .Counter_Running_Flag_Out       (Counter_Running_Flag_Out),
    .Counter_Count_Out              (Counter_Count_Out)
);



// --------------------------------------------------
// Ring_Counter_16_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Ring_Counter_16_Bit.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [16:0] f_Actual_Value, input logic [16:0] f_Expected_Value);
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
// Set the 16-Bit Ring Counter Input Values
task Set_Ring_Counter_16_Bit(input logic f_Reset_In, input logic f_Enable_In, input logic f_Start_Counter_Command_In, input logic f_Stop_Counter_Command_In);
    begin
        #10;

        Reset_In                        <= f_Reset_In;
        Enable_In                       <= f_Enable_In;
        Start_Counter_Command_In        <= f_Start_Counter_Command_In;
        Stop_Counter_Command_In         <= f_Stop_Counter_Command_In;

        tb_Reset_In                         <= f_Reset_In;
        tb_Enable_In                        <= f_Enable_In;
        tb_Start_Counter_Command_In         <= f_Start_Counter_Command_In;
        tb_Stop_Counter_Command_In          <= f_Stop_Counter_Command_In;

        #10;
    end
endtask

// Check the 16-Bit Ring Counter
task Check_Ring_Counter_16_Bit();
    begin
        Check_Actual_vs_Expected_Value({Counter_Running_Flag_Out, Counter_Count_Out}, {tb_Counter_Running_Flag_Out, tb_Counter_Count_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                                 , $time,
            "Reset_In = 0x%1b , "                       , Reset_In,
            "Enable_In = 0x%1b , "                      , Enable_In,
            "Start_Counter_Command_In = 0x%1b , "       , Start_Counter_Command_In,
            "Stop_Counter_Command_In = 0x%1b , "        , Stop_Counter_Command_In,
            "Counter_Running_Flag_Out = 0x%1b , "       , Counter_Running_Flag_Out,
            "Counter_Count_Out = 0x%4h , "              , Counter_Count_Out,
            "tb_Counter_Running_Flag_Out = 0x%1b , "    , tb_Counter_Running_Flag_Out,
            "tb_Counter_Count_Out = 0x%4h , "           , tb_Counter_Count_Out,
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

// Testbench Ring_Counter_16_Bit
always @ (negedge Clk_In or posedge tb_Reset_In)
    begin
        if (tb_Reset_In)
            begin
                tb_Counter_Count <= 16'b1;
            end
        else if (tb_Counter_Running_Flag)
            begin
                tb_Counter_Count <= {tb_Counter_Count[14:0], tb_Counter_Count[15]};
            end
        else
            begin
                tb_Counter_Count <= tb_Counter_Count;
            end
    end


assign tb_Counter_Count_Out         = tb_Enable_In ? tb_Counter_Count           : 16'bZ;
assign tb_Counter_Running_Flag_Out  = tb_Enable_In ? tb_Counter_Running_Flag    : 1'bZ;



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        forever
            begin
                #20;
                Check_Ring_Counter_16_Bit();
            end
    end

initial
    begin
        Open_File("../../Transcript/Ring_Counter_16_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Ring_Counter_16_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("Default State - With Enable ON"));
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b0, 1'b0);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Reset the Counter - With Enable ON"));
        Set_Ring_Counter_16_Bit(1'b1, 1'b1, 1'b0, 1'b0);
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b0, 1'b0);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Enable the Counter - Enable OFF then ON"));
        Set_Ring_Counter_16_Bit(1'b0, 1'b0, 1'b0, 1'b0);
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b0, 1'b0);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Start the Counter"));
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b1, 1'b0);
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b0, 1'b0);
        #300; // 15 Clock Cycles

        Write_To_File_And_Display($sformatf("Stop the Counter"));
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b0, 1'b1);
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b0, 1'b0);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Reset the Counter - With Enable ON"));
        Set_Ring_Counter_16_Bit(1'b1, 1'b1, 1'b0, 1'b0);
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b0, 1'b0);
        #40; // 2 Clock Cycles

        Write_To_File_And_Display($sformatf("Start the Counter"));
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b1, 1'b0);
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b0, 1'b0);
        #300; // 15 Clock Cycles

        Write_To_File_And_Display($sformatf("Stop the Counter"));
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b0, 1'b1);
        Set_Ring_Counter_16_Bit(1'b0, 1'b1, 1'b0, 1'b0);
        #40; // 2 Clock Cycles

        Display_Results();
        Close_File();
        $stop;
    end




endmodule
