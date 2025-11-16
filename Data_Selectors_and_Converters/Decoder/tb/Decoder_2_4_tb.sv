/*
--------------------------------------------------
Module :
--------------------------------------------------
Decoder_2_4_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 2:4 Decoder Implementation.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Decoder_2_4_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg        Enable_In = 1'b0;

reg  [1:0] Encoded_Value_In = 2'b0;

wire       Data_0_Out;
wire       Data_1_Out;
wire       Data_2_Out;
wire       Data_3_Out;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic       tb_Enable_In        = 1'b0;

logic [1:0] tb_Encoded_Value_In = 2'b0;

logic       tb_Data_0_Out       = 1'b0;
logic       tb_Data_1_Out       = 1'b0;
logic       tb_Data_2_Out       = 1'b0;
logic       tb_Data_3_Out       = 1'b0;


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
// Decoder_2_4 DUT Instantiation
// --------------------------------------------------
Decoder_2_4 DUT (
    .Enable_In          (Enable_In),
    
    .Encoded_Value_In   (Encoded_Value_In),
    
    .Data_0_Out         (Data_0_Out),
    .Data_1_Out         (Data_1_Out),
    .Data_2_Out         (Data_2_Out),
    .Data_3_Out         (Data_3_Out)
);



// --------------------------------------------------
// Decoder_2_4 VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Decoder_2_4.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [3:0] f_Actual_Value, input logic [3:0] f_Expected_Value);
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
// Check the 2:4 Decoder
task Check_Decoder_2_4(input logic f_Enable_In, input logic [1:0] f_Encoded_Value_In);
    begin
        Enable_In           = f_Enable_In;
        Encoded_Value_In    = f_Encoded_Value_In;
        
        tb_Enable_In        = f_Enable_In;
        tb_Encoded_Value_In = f_Encoded_Value_In;

        tb_Decoder_2_4();
        
        #20;
        
        Check_Actual_vs_Expected_Value({Data_3_Out, Data_2_Out, Data_1_Out, Data_0_Out}, {tb_Data_3_Out, tb_Data_2_Out, tb_Data_1_Out, tb_Data_0_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                                 , $time,
            "Enable_In = 0x%1b , "                      , Enable_In,
            "Encoded_Value_In = 0x%1h , "               , Encoded_Value_In,
            "{Data_3_Out ... Data_0_Out} = %4b , "      , {Data_3_Out, Data_2_Out, Data_1_Out, Data_0_Out},
            "{tb_Data_3_Out ... tb_Data_0_Out} = %4b , ", {tb_Data_3_Out, tb_Data_2_Out, tb_Data_1_Out, tb_Data_0_Out},
            "Is_Same = %1b"                             , Is_Same
        ));
    end
endtask

// Testbench Decoder_2_4
task tb_Decoder_2_4();
    begin
        tb_Data_0_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 2'd0) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_1_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 2'd1) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_2_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 2'd2) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_3_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 2'd3) ? 1'b1 : 1'b0) : 1'bZ;
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Decoder_2_4_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Decoder_2_4 - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        // Few Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Few Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_Decoder_2_4(1'b0, $random());
        Check_Decoder_2_4(1'b1, 2'd0);
        Check_Decoder_2_4(1'b1, 2'd1);
        Check_Decoder_2_4(1'b1, 2'd2);
        Check_Decoder_2_4(1'b1, 2'd3);
        
        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        repeat(20)
            begin
                Check_Decoder_2_4($random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
