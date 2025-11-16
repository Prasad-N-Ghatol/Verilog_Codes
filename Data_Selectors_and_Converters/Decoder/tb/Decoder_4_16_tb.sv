/*
--------------------------------------------------
Module :
--------------------------------------------------
Decoder_4_16_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 4:16 Decoder Implementation.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Decoder_4_16_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg        Enable_In = 1'b0;

reg  [3:0] Encoded_Value_In = 4'b0;

wire       Data_0_Out;
wire       Data_1_Out;
wire       Data_2_Out;
wire       Data_3_Out;
wire       Data_4_Out;
wire       Data_5_Out;
wire       Data_6_Out;
wire       Data_7_Out;
wire       Data_8_Out;
wire       Data_9_Out;
wire       Data_10_Out;
wire       Data_11_Out;
wire       Data_12_Out;
wire       Data_13_Out;
wire       Data_14_Out;
wire       Data_15_Out;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic       tb_Enable_In        = 1'b0;

logic [3:0] tb_Encoded_Value_In = 4'b0;

logic       tb_Data_0_Out       = 1'b0;
logic       tb_Data_1_Out       = 1'b0;
logic       tb_Data_2_Out       = 1'b0;
logic       tb_Data_3_Out       = 1'b0;
logic       tb_Data_4_Out       = 1'b0;
logic       tb_Data_5_Out       = 1'b0;
logic       tb_Data_6_Out       = 1'b0;
logic       tb_Data_7_Out       = 1'b0;
logic       tb_Data_8_Out       = 1'b0;
logic       tb_Data_9_Out       = 1'b0;
logic       tb_Data_10_Out      = 1'b0;
logic       tb_Data_11_Out      = 1'b0;
logic       tb_Data_12_Out      = 1'b0;
logic       tb_Data_13_Out      = 1'b0;
logic       tb_Data_14_Out      = 1'b0;
logic       tb_Data_15_Out      = 1'b0;


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
// Decoder_4_16 DUT Instantiation
// --------------------------------------------------
Decoder_4_16 DUT (
    .Enable_In          (Enable_In),
    
    .Encoded_Value_In   (Encoded_Value_In),
    
    .Data_0_Out         (Data_0_Out),
    .Data_1_Out         (Data_1_Out),
    .Data_2_Out         (Data_2_Out),
    .Data_3_Out         (Data_3_Out),
    .Data_4_Out         (Data_4_Out),
    .Data_5_Out         (Data_5_Out),
    .Data_6_Out         (Data_6_Out),
    .Data_7_Out         (Data_7_Out),
    .Data_8_Out         (Data_8_Out),
    .Data_9_Out         (Data_9_Out),
    .Data_10_Out        (Data_10_Out),
    .Data_11_Out        (Data_11_Out),
    .Data_12_Out        (Data_12_Out),
    .Data_13_Out        (Data_13_Out),
    .Data_14_Out        (Data_14_Out),
    .Data_15_Out        (Data_15_Out)
);



// --------------------------------------------------
// Decoder_4_16 VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Decoder_4_16.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [15:0] f_Actual_Value, input logic [15:0] f_Expected_Value);
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
// Check the 4:16 Decoder
task Check_Decoder_4_16(input logic f_Enable_In, input logic [3:0] f_Encoded_Value_In);
    begin
        Enable_In           = f_Enable_In;
        Encoded_Value_In    = f_Encoded_Value_In;
        
        tb_Enable_In        = f_Enable_In;
        tb_Encoded_Value_In = f_Encoded_Value_In;

        tb_Decoder_4_16();
        
        #20;
        
        Check_Actual_vs_Expected_Value({Data_15_Out, Data_14_Out, Data_13_Out, Data_12_Out, Data_11_Out, Data_10_Out, Data_9_Out, Data_8_Out, Data_7_Out, Data_6_Out, Data_5_Out, Data_4_Out, Data_3_Out, Data_2_Out, Data_1_Out, Data_0_Out}, {tb_Data_15_Out, tb_Data_14_Out, tb_Data_13_Out, tb_Data_12_Out, tb_Data_11_Out, tb_Data_10_Out, tb_Data_9_Out, tb_Data_8_Out, tb_Data_7_Out, tb_Data_6_Out, tb_Data_5_Out, tb_Data_4_Out, tb_Data_3_Out, tb_Data_2_Out, tb_Data_1_Out, tb_Data_0_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                                   , $time,
            "Enable_In = 0x%1b , "                        , Enable_In,
            "Encoded_Value_In = 0x%1h , "                 , Encoded_Value_In,
            "{Data_15_Out ... Data_0_Out} = %16b , "      , {Data_15_Out, Data_14_Out, Data_13_Out, Data_12_Out, Data_11_Out, Data_10_Out, Data_9_Out, Data_8_Out, Data_7_Out, Data_6_Out, Data_5_Out, Data_4_Out, Data_3_Out, Data_2_Out, Data_1_Out, Data_0_Out},
            "{tb_Data_15_Out ... tb_Data_0_Out} = %16b , ", {tb_Data_15_Out, tb_Data_14_Out, tb_Data_13_Out, tb_Data_12_Out, tb_Data_11_Out, tb_Data_10_Out, tb_Data_9_Out, tb_Data_8_Out, tb_Data_7_Out, tb_Data_6_Out, tb_Data_5_Out, tb_Data_4_Out, tb_Data_3_Out, tb_Data_2_Out, tb_Data_1_Out, tb_Data_0_Out},
            "Is_Same = %1b"                               , Is_Same
        ));
    end
endtask

// Testbench Decoder_4_16
task tb_Decoder_4_16();
    begin
        tb_Data_0_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd0)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_1_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd1)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_2_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd2)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_3_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd3)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_4_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd4)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_5_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd5)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_6_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd6)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_7_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd7)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_8_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd8)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_9_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd9)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_10_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd10) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_11_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd11) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_12_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd12) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_13_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd13) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_14_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd14) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_15_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 4'd15) ? 1'b1 : 1'b0) : 1'bZ;
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Decoder_4_16_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Decoder_4_16 - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        // Few Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Few Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_Decoder_4_16(1'b0, $random());
        Check_Decoder_4_16(1'b1, 4'd0);
        Check_Decoder_4_16(1'b1, 4'd1);
        Check_Decoder_4_16(1'b1, 4'd2);
        Check_Decoder_4_16(1'b1, 4'd3);
        Check_Decoder_4_16(1'b1, 4'd4);
        Check_Decoder_4_16(1'b1, 4'd5);
        Check_Decoder_4_16(1'b1, 4'd6);
        Check_Decoder_4_16(1'b1, 4'd7);
        Check_Decoder_4_16(1'b1, 4'd8);
        Check_Decoder_4_16(1'b1, 4'd9);
        Check_Decoder_4_16(1'b1, 4'd10);
        Check_Decoder_4_16(1'b1, 4'd11);
        Check_Decoder_4_16(1'b1, 4'd12);
        Check_Decoder_4_16(1'b1, 4'd13);
        Check_Decoder_4_16(1'b1, 4'd14);
        Check_Decoder_4_16(1'b1, 4'd15);
        
        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        repeat(20)
            begin
                Check_Decoder_4_16($random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
