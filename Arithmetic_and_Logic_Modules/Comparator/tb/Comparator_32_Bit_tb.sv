/*
--------------------------------------------------
Module :
--------------------------------------------------
Comparator_32_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the Comparator 32-Bit Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Comparator_32_Bit_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg         Enable_In = 1'b0;

reg  [31:0] Data_A_In = 32'b0;
reg  [31:0] Data_B_In = 32'b0;

wire        A_gt_B_Out;
wire        A_eq_B_Out;
wire        A_lt_B_Out;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic        tb_Enable_In  = 1'b0;

logic [31:0] tb_Data_A_In = 32'b0;
logic [31:0] tb_Data_B_In = 32'b0;

logic        tb_A_gt_B_Out = 1'b0;
logic        tb_A_eq_B_Out = 1'b0;
logic        tb_A_lt_B_Out = 1'b0;



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
// Comparator_32_Bit DUT Instantiation
// --------------------------------------------------
Comparator_32_Bit DUT (
    .Enable_In  (Enable_In),

    .Data_A_In  (Data_A_In),
    .Data_B_In  (Data_B_In),

    .A_gt_B_Out (A_gt_B_Out),
    .A_eq_B_Out (A_eq_B_Out),
    .A_lt_B_Out (A_lt_B_Out)
);



// --------------------------------------------------
// Comparator_32_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Comparator_32_Bit.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [2:0] f_Actual_Value, input logic [2:0] f_Expected_Value);
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
// Check Comparison
task Check_Comparison(input logic f_Enable_In, input logic [31:0] f_Data_A_In, input logic [31:0] f_Data_B_In);
    begin
        Enable_In = f_Enable_In;
        Data_A_In = f_Data_A_In;
        Data_B_In = f_Data_B_In;

        tb_Enable_In = f_Enable_In;
        tb_Data_A_In = f_Data_A_In;
        tb_Data_B_In = f_Data_B_In;

        tb_A_gt_B_Out = tb_Enable_In ? ((tb_Data_A_In  > tb_Data_B_In) ? 1'b1 : 1'b0) : 1'bZ;
        tb_A_eq_B_Out = tb_Enable_In ? ((tb_Data_A_In == tb_Data_B_In) ? 1'b1 : 1'b0) : 1'bZ;
        tb_A_lt_B_Out = tb_Enable_In ? ((tb_Data_A_In  < tb_Data_B_In) ? 1'b1 : 1'b0) : 1'bZ;

        #20;

        Check_Actual_vs_Expected_Value({A_gt_B_Out, A_eq_B_Out, A_lt_B_Out}, {tb_A_gt_B_Out, tb_A_eq_B_Out, tb_A_lt_B_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "               , $time,
            "Enable_In = 0x%1b , "    , Enable_In,
            "Data_A_In = 0x%8h , "    , Data_A_In,
            "Data_B_In = 0x%8h , "    , Data_B_In,
            "A_gt_B_Out = 0x%1b , "   , A_gt_B_Out,
            "A_eq_B_Out = 0x%1b , "   , A_eq_B_Out,
            "A_lt_B_Out = 0x%1b , "   , A_lt_B_Out,
            "tb_A_gt_B_Out = 0x%1b , ", tb_A_gt_B_Out,
            "tb_A_eq_B_Out = 0x%1b , ", tb_A_eq_B_Out,
            "tb_A_lt_B_Out = 0x%1b , ", tb_A_lt_B_Out,
            "Is_Same = %1b"           , Is_Same
        ));
    end
endtask


// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Comparator_32_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Comparator_32_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Basic Comparison"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_Comparison(1'b0, $random(), $random());
        Check_Comparison(1'b1, 32'h00000001, 32'h00000000); // >
        Check_Comparison(1'b1, 32'h00000000, 32'h00000000); // =
        Check_Comparison(1'b1, 32'hFFFFFFFF, 32'hFFFFFFFF); // =
        Check_Comparison(1'b1, 32'h00000000, 32'h00000001); // <

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        repeat(10)
            begin
                Check_Comparison($random(), $random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
