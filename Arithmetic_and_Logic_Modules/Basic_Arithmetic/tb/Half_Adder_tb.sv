/*
--------------------------------------------------
Module :
--------------------------------------------------
Half_Adder_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the Half Adder Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Half_Adder_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg     Data_A_In = 1'b0;
reg     Data_B_In = 1'b0;

wire    Carry_Out;
wire    Sum_Out;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic tb_Data_A_In  = 1'b0;
logic tb_Data_B_In  = 1'b0;
logic tb_Carry_Out  = 1'b0;
logic tb_Sum_Out    = 1'b0;



// --------------------------------------------------
// Testbench Checks
// --------------------------------------------------
// Check
logic Is_Same = 1'b0;

// Check Values
integer Passed_Checks = 0;
integer Failed_Checks = 0;
integer Total_Checks = 0;



// --------------------------------------------------
// Half_Adder DUT Instantiation
// --------------------------------------------------
Half_Adder DUT (
    .Data_A_In  (Data_A_In),
    .Data_B_In  (Data_B_In),

    .Carry_Out  (Carry_Out),
    .Sum_Out    (Sum_Out)
);



// --------------------------------------------------
// Half_Adder VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Half_Adder.vcd");
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
// Check the Half Adder
task Check_Half_Adder (input logic f_Data_A_In, input logic f_Data_B_In);
    begin
        Data_A_In   = f_Data_A_In;
        Data_B_In   = f_Data_B_In;

        tb_Data_A_In = f_Data_A_In;
        tb_Data_B_In = f_Data_B_In;
        
        tb_Carry_Out    = tb_Data_A_In & tb_Data_B_In;
        tb_Sum_Out      = tb_Data_A_In ^ tb_Data_B_In;

        #20;

        Check_Actual_vs_Expected_Value({Carry_Out, Sum_Out}, {tb_Carry_Out, tb_Sum_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                 , $time,
            "Data_A_In = 0x%1h , "      , Data_A_In,
            "Data_B_In = 0x%1h , "      , Data_B_In,
            "Carry_Out = 0x%1b , "      , Carry_Out,
            "Sum_Out = 0x%1h , "        , Sum_Out,
            "tb_Carry_Out = 0x%1b , "   , tb_Carry_Out,
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
        Open_File("../../Transcript/Half_Adder_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Half_Adder - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        // All Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("All Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_Half_Adder(0, 0);
        Check_Half_Adder(0, 1);
        Check_Half_Adder(1, 0);
        Check_Half_Adder(1, 1);

        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        repeat(10)
            begin
                Check_Half_Adder($random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
