/*
--------------------------------------------------
Module :
--------------------------------------------------
Unsigned_Array_Multiplier_2_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 2-Bit Unsigned Array Multiplier Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Unsigned_Array_Multiplier_2_Bit_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg        Enable_In = 1'b0;

reg  [1:0] Data_A_In = 2'b0;
reg  [1:0] Data_B_In = 2'b0;

wire [3:0] Multiplied_Result_Out;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic       tb_Enable_In             = 1'b0;

logic [1:0] tb_Data_A_In             = 2'b0;
logic [1:0] tb_Data_B_In             = 2'b0;

logic [3:0] tb_Multiplied_Result_Out = 4'b0;



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
// Unsigned_Array_Multiplier_2_Bit DUT Instantiation
// --------------------------------------------------
Unsigned_Array_Multiplier_2_Bit DUT (
    .Enable_In              (Enable_In),

    .Data_A_In              (Data_A_In),
    .Data_B_In              (Data_B_In),

    .Multiplied_Result_Out  (Multiplied_Result_Out)
);



// --------------------------------------------------
// Unsigned_Array_Multiplier_2_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Unsigned_Array_Multiplier_2_Bit.vcd");
        $dumpvars;
    end



// --------------------------------------------------
// Time and Clock Initialization
// --------------------------------------------------
initial
    begin
        $timeformat(-9, 3, " ns", 16);
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
task Check_Actual_vs_Expected_Value (input logic f_Actual_Value, input logic f_Expected_Value);
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
// Check the Multiplier
task Check_Multiplier(input logic f_Enable_In, input logic [1:0] f_Data_A_In, input logic [1:0] f_Data_B_In);
    begin
        Enable_In   = f_Enable_In;
        Data_A_In   = f_Data_A_In;
        Data_B_In   = f_Data_B_In;
        
        tb_Enable_In   = f_Enable_In;
        tb_Data_A_In   = f_Data_A_In;
        tb_Data_B_In   = f_Data_B_In;
        
        if (tb_Enable_In)
            begin
                tb_Multiplied_Result_Out = tb_Data_A_In * tb_Data_B_In;
            end
        else
            begin
                tb_Multiplied_Result_Out = 4'bZ;
            end

        #20;

        Check_Actual_vs_Expected_Value(Multiplied_Result_Out, tb_Multiplied_Result_Out);

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                             , $time,
            "Enable_In = 0x%1b , "                  , Enable_In,
            "Data_A_In = 0x%1h , "                  , Data_A_In,
            "Data_B_In = 0x%1h , "                  , Data_B_In,
            "Multiplied_Result_Out = 0x%1h , "      , Multiplied_Result_Out,
            "tb_Multiplied_Result_Out = 0x%1h , "   , tb_Multiplied_Result_Out,
            "Is_Same = %1b"                         , Is_Same
        ));
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Unsigned_Array_Multiplier_2_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Unsigned_Array_Multiplier_2_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("A Few Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_Multiplier(1'b0, $random(), $random());
        Check_Multiplier(1'b1, $random(), $random());

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        repeat(20)
            begin
                Check_Multiplier($random(), $random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
