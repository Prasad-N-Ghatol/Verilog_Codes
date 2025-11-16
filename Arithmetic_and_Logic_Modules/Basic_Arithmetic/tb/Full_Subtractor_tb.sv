/*
--------------------------------------------------
Module :
--------------------------------------------------
Full_Subtractor_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the Full Subtractor Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Full_Subtractor_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg     Data_A_In = 1'b0;
reg     Data_B_In = 1'b0;
reg     Borrow_In = 1'b0;

wire    Borrow_Out;
wire    Sum_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire DUT_Complement_A_w = DUT.Complement_A_w;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
bit tb_Data_A_In    = 1'b0;
bit tb_Data_B_In    = 1'b0;
bit tb_Borrow_In    = 1'b0;
bit tb_Borrow_Out   = 1'b0;
bit tb_Sum_Out      = 1'b0;



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
// Full_Subtractor DUT Instantiation
// --------------------------------------------------
Full_Subtractor DUT (
    .Data_A_In  (Data_A_In),
    .Data_B_In  (Data_B_In),
    .Borrow_In  (Borrow_In),

    .Borrow_Out (Borrow_Out),
    .Sum_Out    (Sum_Out)
);



// --------------------------------------------------
// Full_Subtractor VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Full_Subtractor.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [1:0] f_Actual_Value, input logic [1:0] f_Expected_Value);
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
// Check the Full Subtractor
task Check_Full_Subtractor (input logic f_Data_A_In, input logic f_Data_B_In, input logic f_Borrow_In);
    begin
        Data_A_In   = f_Data_A_In;
        Data_B_In   = f_Data_B_In;
        Borrow_In   = f_Borrow_In;

        tb_Data_A_In = f_Data_A_In;
        tb_Data_B_In = f_Data_B_In;
        tb_Borrow_In = f_Borrow_In;
        
        tb_Borrow_Out   = (~tb_Data_A_In & tb_Data_B_In) | (tb_Data_B_In & tb_Borrow_In) | (~tb_Data_A_In & tb_Borrow_In);
        tb_Sum_Out      = tb_Data_A_In ^ tb_Data_B_In ^ tb_Borrow_In;

        #20;

        Check_Actual_vs_Expected_Value({Borrow_Out, Sum_Out}, {tb_Borrow_Out, tb_Sum_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                 , $time,
            "Data_A_In = 0x%1h , "      , Data_A_In,
            "Data_B_In = 0x%1h , "      , Data_B_In,
            "Borrow_In = 0x%1b , "      , Borrow_In,
            "Borrow_Out = 0x%1b , "     , Borrow_Out,
            "Sum_Out = 0x%1h , "        , Sum_Out,
            "tb_Borrow_Out = 0x%1b , "  , tb_Borrow_Out,
            "tb_Sum_Out = 0x%1h , "     , tb_Sum_Out,
            "Is_Same = %1b"             , Is_Same
        ));
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Full_Subtractor_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Full_Subtractor - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        // All Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("All Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_Full_Subtractor(0, 0, 0);
        Check_Full_Subtractor(0, 0, 1);
        Check_Full_Subtractor(0, 1, 0);
        Check_Full_Subtractor(0, 1, 1);
        Check_Full_Subtractor(1, 0, 0);
        Check_Full_Subtractor(1, 0, 1);
        Check_Full_Subtractor(1, 1, 0);
        Check_Full_Subtractor(1, 1, 1);

        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        repeat(10)
            begin
                Check_Full_Subtractor($random(), $random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
