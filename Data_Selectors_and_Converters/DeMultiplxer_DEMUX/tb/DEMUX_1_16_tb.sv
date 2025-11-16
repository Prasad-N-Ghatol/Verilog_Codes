/*
--------------------------------------------------
Module :
--------------------------------------------------
DEMUX_1_16_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the De-Multiplexer 1:16 (DEMUX) Implementation.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module DEMUX_1_16_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg        Enable_In = 1'b0;

reg        Data_In = 1'b0;

reg  [3:0] Select_In = 4'b0;

wire       DEMUX_Result_Data_0_Out;
wire       DEMUX_Result_Data_1_Out;
wire       DEMUX_Result_Data_2_Out;
wire       DEMUX_Result_Data_3_Out;
wire       DEMUX_Result_Data_4_Out;
wire       DEMUX_Result_Data_5_Out;
wire       DEMUX_Result_Data_6_Out;
wire       DEMUX_Result_Data_7_Out;
wire       DEMUX_Result_Data_8_Out;
wire       DEMUX_Result_Data_9_Out;
wire       DEMUX_Result_Data_10_Out;
wire       DEMUX_Result_Data_11_Out;
wire       DEMUX_Result_Data_12_Out;
wire       DEMUX_Result_Data_13_Out;
wire       DEMUX_Result_Data_14_Out;
wire       DEMUX_Result_Data_15_Out;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic       tb_Enable_In = 1'b0;

logic       tb_Data_In = 1'b0;

logic [3:0] tb_Select_In = 4'b0;

logic       tb_DEMUX_Result_Data_0_Out  = 1'b0;
logic       tb_DEMUX_Result_Data_1_Out  = 1'b0;
logic       tb_DEMUX_Result_Data_2_Out  = 1'b0;
logic       tb_DEMUX_Result_Data_3_Out  = 1'b0;
logic       tb_DEMUX_Result_Data_4_Out  = 1'b0;
logic       tb_DEMUX_Result_Data_5_Out  = 1'b0;
logic       tb_DEMUX_Result_Data_6_Out  = 1'b0;
logic       tb_DEMUX_Result_Data_7_Out  = 1'b0;
logic       tb_DEMUX_Result_Data_8_Out  = 1'b0;
logic       tb_DEMUX_Result_Data_9_Out  = 1'b0;
logic       tb_DEMUX_Result_Data_10_Out = 1'b0;
logic       tb_DEMUX_Result_Data_11_Out = 1'b0;
logic       tb_DEMUX_Result_Data_12_Out = 1'b0;
logic       tb_DEMUX_Result_Data_13_Out = 1'b0;
logic       tb_DEMUX_Result_Data_14_Out = 1'b0;
logic       tb_DEMUX_Result_Data_15_Out = 1'b0;


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
// DEMUX_1_16 DUT Instantiation
// --------------------------------------------------
DEMUX_1_16 DUT (
    .Enable_In                  (Enable_In),

    .Data_In                    (Data_In),
    
    .Select_In                  (Select_In),
    
    .DEMUX_Result_Data_0_Out    (DEMUX_Result_Data_0_Out),
    .DEMUX_Result_Data_1_Out    (DEMUX_Result_Data_1_Out),
    .DEMUX_Result_Data_2_Out    (DEMUX_Result_Data_2_Out),
    .DEMUX_Result_Data_3_Out    (DEMUX_Result_Data_3_Out),
    .DEMUX_Result_Data_4_Out    (DEMUX_Result_Data_4_Out),
    .DEMUX_Result_Data_5_Out    (DEMUX_Result_Data_5_Out),
    .DEMUX_Result_Data_6_Out    (DEMUX_Result_Data_6_Out),
    .DEMUX_Result_Data_7_Out    (DEMUX_Result_Data_7_Out),
    .DEMUX_Result_Data_8_Out    (DEMUX_Result_Data_8_Out),
    .DEMUX_Result_Data_9_Out    (DEMUX_Result_Data_9_Out),
    .DEMUX_Result_Data_10_Out   (DEMUX_Result_Data_10_Out),
    .DEMUX_Result_Data_11_Out   (DEMUX_Result_Data_11_Out),
    .DEMUX_Result_Data_12_Out   (DEMUX_Result_Data_12_Out),
    .DEMUX_Result_Data_13_Out   (DEMUX_Result_Data_13_Out),
    .DEMUX_Result_Data_14_Out   (DEMUX_Result_Data_14_Out),
    .DEMUX_Result_Data_15_Out   (DEMUX_Result_Data_15_Out)
);



// --------------------------------------------------
// DEMUX_1_16 VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/DEMUX_1_16.vcd");
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
// Check the DEMUX 1:16
task Check_DEMUX_1_16(input logic f_Enable_In, input logic f_Data_In, input logic [3:0] f_Select_In);
    begin
        Enable_In = f_Enable_In;
        Data_In   = f_Data_In;
        Select_In = f_Select_In;

        tb_Enable_In = f_Enable_In;
        tb_Data_In   = f_Data_In;
        tb_Select_In = f_Select_In;

        tb_DEMUX_1_16();
        
        #20;
        
        Check_Actual_vs_Expected_Value({DEMUX_Result_Data_15_Out, DEMUX_Result_Data_14_Out, DEMUX_Result_Data_13_Out, DEMUX_Result_Data_12_Out, DEMUX_Result_Data_11_Out, DEMUX_Result_Data_10_Out, DEMUX_Result_Data_9_Out, DEMUX_Result_Data_8_Out, DEMUX_Result_Data_7_Out, DEMUX_Result_Data_6_Out, DEMUX_Result_Data_5_Out, DEMUX_Result_Data_4_Out, DEMUX_Result_Data_3_Out, DEMUX_Result_Data_2_Out, DEMUX_Result_Data_1_Out, DEMUX_Result_Data_0_Out}, {tb_DEMUX_Result_Data_15_Out, tb_DEMUX_Result_Data_14_Out, tb_DEMUX_Result_Data_13_Out, tb_DEMUX_Result_Data_12_Out, tb_DEMUX_Result_Data_11_Out, tb_DEMUX_Result_Data_10_Out, tb_DEMUX_Result_Data_9_Out, tb_DEMUX_Result_Data_8_Out, tb_DEMUX_Result_Data_7_Out, tb_DEMUX_Result_Data_6_Out, tb_DEMUX_Result_Data_5_Out, tb_DEMUX_Result_Data_4_Out, tb_DEMUX_Result_Data_3_Out, tb_DEMUX_Result_Data_2_Out, tb_DEMUX_Result_Data_1_Out, tb_DEMUX_Result_Data_0_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                                                             , $time,
            "Enable_In = %1b , "                                                    , Enable_In,
            "Data_In = %1b , "                                                      , Data_In,
            "Select_In = %2d , "                                                    , Select_In,
            "{DEMUX_Result_Data_15_Out ... DEMUX_Result_Data_0_Out} = %16b , "      , {DEMUX_Result_Data_15_Out, DEMUX_Result_Data_14_Out, DEMUX_Result_Data_13_Out, DEMUX_Result_Data_12_Out, DEMUX_Result_Data_11_Out, DEMUX_Result_Data_10_Out, DEMUX_Result_Data_9_Out, DEMUX_Result_Data_8_Out, DEMUX_Result_Data_7_Out, DEMUX_Result_Data_6_Out, DEMUX_Result_Data_5_Out, DEMUX_Result_Data_4_Out, DEMUX_Result_Data_3_Out, DEMUX_Result_Data_2_Out, DEMUX_Result_Data_1_Out, DEMUX_Result_Data_0_Out},
            "{tb_DEMUX_Result_Data_15_Out ... tb_DEMUX_Result_Data_0_Out} = %16b , ", {tb_DEMUX_Result_Data_15_Out, tb_DEMUX_Result_Data_14_Out, tb_DEMUX_Result_Data_13_Out, tb_DEMUX_Result_Data_12_Out, tb_DEMUX_Result_Data_11_Out, tb_DEMUX_Result_Data_10_Out, tb_DEMUX_Result_Data_9_Out, tb_DEMUX_Result_Data_8_Out, tb_DEMUX_Result_Data_7_Out, tb_DEMUX_Result_Data_6_Out, tb_DEMUX_Result_Data_5_Out, tb_DEMUX_Result_Data_4_Out, tb_DEMUX_Result_Data_3_Out, tb_DEMUX_Result_Data_2_Out, tb_DEMUX_Result_Data_1_Out, tb_DEMUX_Result_Data_0_Out},
            "Is_Same = %1b"                                                         , Is_Same
        ));
    end
endtask

// Testbench DEMUX_1_16
task tb_DEMUX_1_16();
    begin
        tb_DEMUX_Result_Data_0_Out  = tb_Enable_In ? ((tb_Select_In == 4'd0)  ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_1_Out  = tb_Enable_In ? ((tb_Select_In == 4'd1)  ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_2_Out  = tb_Enable_In ? ((tb_Select_In == 4'd2)  ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_3_Out  = tb_Enable_In ? ((tb_Select_In == 4'd3)  ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_4_Out  = tb_Enable_In ? ((tb_Select_In == 4'd4)  ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_5_Out  = tb_Enable_In ? ((tb_Select_In == 4'd5)  ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_6_Out  = tb_Enable_In ? ((tb_Select_In == 4'd6)  ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_7_Out  = tb_Enable_In ? ((tb_Select_In == 4'd7)  ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_8_Out  = tb_Enable_In ? ((tb_Select_In == 4'd8)  ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_9_Out  = tb_Enable_In ? ((tb_Select_In == 4'd9)  ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_10_Out = tb_Enable_In ? ((tb_Select_In == 4'd10) ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_11_Out = tb_Enable_In ? ((tb_Select_In == 4'd11) ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_12_Out = tb_Enable_In ? ((tb_Select_In == 4'd12) ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_13_Out = tb_Enable_In ? ((tb_Select_In == 4'd13) ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_14_Out = tb_Enable_In ? ((tb_Select_In == 4'd14) ? tb_Data_In : 1'b0) : 1'bZ;
        tb_DEMUX_Result_Data_15_Out = tb_Enable_In ? ((tb_Select_In == 4'd15) ? tb_Data_In : 1'b0) : 1'bZ;
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/DEMUX_1_16_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("DEMUX_1_16 - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        // Few Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Few Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd0);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd0);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd1);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd1);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd2);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd2);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd3);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd3);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd4);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd4);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd5);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd5);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd6);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd6);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd7);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd7);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd8);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd8);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd9);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd9);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd10);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd10);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd11);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd11);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd12);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd12);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd13);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd13);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd14);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd14);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_DEMUX_1_16(1'b0, $random(), $random());
        Check_DEMUX_1_16(1'b1, 1'b0, 4'd15);
        Check_DEMUX_1_16(1'b1, 1'b1, 4'd15);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        repeat(20)
            begin
                Check_DEMUX_1_16($random(), $random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
