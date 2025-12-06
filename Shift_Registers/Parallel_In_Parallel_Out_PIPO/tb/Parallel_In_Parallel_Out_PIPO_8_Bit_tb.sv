/*
--------------------------------------------------
Module :
--------------------------------------------------
Parallel_In_Parallel_Out_PIPO_8_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 8-Bit Parallel-In-Parallel-Out (PIPO) Shift Register Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Parallel_In_Parallel_Out_PIPO_8_Bit_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg        Clk_In               = 1'b0;
reg        Reset_In             = 1'b0;
reg        Enable_In            = 1'b0;

reg        Load_Data_Signal_In  = 1'b0;

reg  [7:0] Parallel_Data_In     = 8'b0;
wire [7:0] Parallel_Data_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire [7:0] DUT_r_Shift_Register = DUT.r_Shift_Register;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic       tb_Reset_In             = 1'b0;
logic       tb_Enable_In            = 1'b0;
logic       tb_Load_Data_Signal_In  = 1'b0;
logic [7:0] tb_Parallel_Data_In     = 8'b0;
logic [7:0] tb_Parallel_Data_Out    = 8'b0;

logic [7:0] tb_r_Shift_Register     = 8'b0;



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
// Parallel_In_Parallel_Out_PIPO_8_Bit DUT Instantiation
// --------------------------------------------------
Parallel_In_Parallel_Out_PIPO_8_Bit DUT (
    .Clk_In                 (Clk_In),
    .Reset_In               (Reset_In),
    .Enable_In              (Enable_In),

    .Load_Data_Signal_In    (Load_Data_Signal_In),

    .Parallel_Data_In       (Parallel_Data_In),
    .Parallel_Data_Out      (Parallel_Data_Out)
);



// --------------------------------------------------
// Parallel_In_Parallel_Out_PIPO_8_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Parallel_In_Parallel_Out_PIPO_8_Bit.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [7:0] f_Actual_Value, input logic [7:0] f_Expected_Value);
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
// Check the 8-Bit Parallel-In-Parallel-Out (PIPO) Shift Register
task Check_Parallel_In_Parallel_Out_PIPO_8_Bit(input logic f_Reset_In, input logic f_Enable_In, input logic f_Load_Data_Signal_In, input logic [7:0] f_Parallel_Data_In);
    begin
        Reset_In                = f_Reset_In;
        Enable_In               = f_Enable_In;
        Load_Data_Signal_In     = f_Load_Data_Signal_In;
        Parallel_Data_In        = f_Parallel_Data_In;

        tb_Reset_In             = f_Reset_In;
        tb_Enable_In            = f_Enable_In;
        tb_Load_Data_Signal_In  = f_Load_Data_Signal_In;
        tb_Parallel_Data_In     = f_Parallel_Data_In;

        if (tb_Enable_In)
            begin
                if (tb_Load_Data_Signal_In)
                    begin
                        tb_r_Shift_Register = tb_Parallel_Data_In;
                    end
                else
                    begin
                        tb_r_Shift_Register = tb_r_Shift_Register;
                    end

                tb_Parallel_Data_Out = tb_r_Shift_Register;
            end
        else
            begin
                tb_Parallel_Data_Out = 8'bZ;
            end
        
        #20;
        
        Check_Actual_vs_Expected_Value(Parallel_Data_Out, tb_Parallel_Data_Out);

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                         , $time,
            "Reset_In = %1b , "                 , Reset_In,
            "Enable_In = %1b , "                , Enable_In,
            "Load_Data_Signal_In = %1b , "      , Load_Data_Signal_In,
            "Parallel_Data_In = 0x%2h , "       , Parallel_Data_In,
            "Parallel_Data_Out = 0x%2h , "      , Parallel_Data_Out,
            "tb_Parallel_Data_Out = 0x%2h , "   , tb_Parallel_Data_Out,
            "Is_Same = %1b"                     , Is_Same
        ));
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Parallel_In_Parallel_Out_PIPO_8_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Parallel_In_Parallel_Out_PIPO_8_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Reset"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Parallel_In_Parallel_Out_PIPO_8_Bit(1'b0, 1'b1, 1'b0, $random());
        Check_Parallel_In_Parallel_Out_PIPO_8_Bit(1'b1, 1'b1, 1'b0, $random());
        Check_Parallel_In_Parallel_Out_PIPO_8_Bit(1'b0, 1'b1, 1'b0, $random());
        Check_Parallel_In_Parallel_Out_PIPO_8_Bit(1'b0, 1'b0, 1'b0, $random());
        Check_Parallel_In_Parallel_Out_PIPO_8_Bit(1'b0, 1'b1, 1'b0, $random());

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Shift Data In"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Parallel_In_Parallel_Out_PIPO_8_Bit(1'b0, 1'b1, 1'b0, $random());
        repeat (4)
            begin
                Check_Parallel_In_Parallel_Out_PIPO_8_Bit(1'b0, 1'b1, 1'b1, $random());
            end

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        repeat(20)
            begin
                Check_Parallel_In_Parallel_Out_PIPO_8_Bit(1'b0, 1'b1, $random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
