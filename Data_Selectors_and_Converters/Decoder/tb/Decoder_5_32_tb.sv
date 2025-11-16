/*
--------------------------------------------------
Module :
--------------------------------------------------
Decoder_5_32_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 5:32 Decoder Implementation.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Decoder_5_32_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg        Enable_In = 1'b0;

reg  [4:0] Encoded_Value_In = 5'b0;

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
wire       Data_16_Out;
wire       Data_17_Out;
wire       Data_18_Out;
wire       Data_19_Out;
wire       Data_20_Out;
wire       Data_21_Out;
wire       Data_22_Out;
wire       Data_23_Out;
wire       Data_24_Out;
wire       Data_25_Out;
wire       Data_26_Out;
wire       Data_27_Out;
wire       Data_28_Out;
wire       Data_29_Out;
wire       Data_30_Out;
wire       Data_31_Out;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic       tb_Enable_In        = 1'b0;

logic [4:0] tb_Encoded_Value_In = 5'b0;

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
logic       tb_Data_16_Out      = 1'b0;
logic       tb_Data_17_Out      = 1'b0;
logic       tb_Data_18_Out      = 1'b0;
logic       tb_Data_19_Out      = 1'b0;
logic       tb_Data_20_Out      = 1'b0;
logic       tb_Data_21_Out      = 1'b0;
logic       tb_Data_22_Out      = 1'b0;
logic       tb_Data_23_Out      = 1'b0;
logic       tb_Data_24_Out      = 1'b0;
logic       tb_Data_25_Out      = 1'b0;
logic       tb_Data_26_Out      = 1'b0;
logic       tb_Data_27_Out      = 1'b0;
logic       tb_Data_28_Out      = 1'b0;
logic       tb_Data_29_Out      = 1'b0;
logic       tb_Data_30_Out      = 1'b0;
logic       tb_Data_31_Out      = 1'b0;


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
// Decoder_5_32 DUT Instantiation
// --------------------------------------------------
Decoder_5_32 DUT (
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
    .Data_15_Out        (Data_15_Out),
    .Data_16_Out        (Data_16_Out),
    .Data_17_Out        (Data_17_Out),
    .Data_18_Out        (Data_18_Out),
    .Data_19_Out        (Data_19_Out),
    .Data_20_Out        (Data_20_Out),
    .Data_21_Out        (Data_21_Out),
    .Data_22_Out        (Data_22_Out),
    .Data_23_Out        (Data_23_Out),
    .Data_24_Out        (Data_24_Out),
    .Data_25_Out        (Data_25_Out),
    .Data_26_Out        (Data_26_Out),
    .Data_27_Out        (Data_27_Out),
    .Data_28_Out        (Data_28_Out),
    .Data_29_Out        (Data_29_Out),
    .Data_30_Out        (Data_30_Out),
    .Data_31_Out        (Data_31_Out)
);



// --------------------------------------------------
// Decoder_5_32 VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Decoder_5_32.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [31:0] f_Actual_Value, input logic [31:0] f_Expected_Value);
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
// Check the 5:32 Decoder
task Check_Decoder_5_32(input logic f_Enable_In, input logic [4:0] f_Encoded_Value_In);
    begin
        Enable_In           = f_Enable_In;
        Encoded_Value_In    = f_Encoded_Value_In;
        
        tb_Enable_In        = f_Enable_In;
        tb_Encoded_Value_In = f_Encoded_Value_In;

        tb_Decoder_5_32();
        
        #20;
        
        Check_Actual_vs_Expected_Value({Data_31_Out, Data_30_Out, Data_29_Out, Data_28_Out, Data_27_Out, Data_26_Out, Data_25_Out, Data_24_Out, Data_23_Out, Data_22_Out, Data_21_Out, Data_20_Out, Data_19_Out, Data_18_Out, Data_17_Out, Data_16_Out, Data_15_Out, Data_14_Out, Data_13_Out, Data_12_Out, Data_11_Out, Data_10_Out, Data_9_Out, Data_8_Out, Data_7_Out, Data_6_Out, Data_5_Out, Data_4_Out, Data_3_Out, Data_2_Out, Data_1_Out, Data_0_Out}, {tb_Data_31_Out, tb_Data_30_Out, tb_Data_29_Out, tb_Data_28_Out, tb_Data_27_Out, tb_Data_26_Out, tb_Data_25_Out, tb_Data_24_Out, tb_Data_23_Out, tb_Data_22_Out, tb_Data_21_Out, tb_Data_20_Out, tb_Data_19_Out, tb_Data_18_Out, tb_Data_17_Out, tb_Data_16_Out, tb_Data_15_Out, tb_Data_14_Out, tb_Data_13_Out, tb_Data_12_Out, tb_Data_11_Out, tb_Data_10_Out, tb_Data_9_Out, tb_Data_8_Out, tb_Data_7_Out, tb_Data_6_Out, tb_Data_5_Out, tb_Data_4_Out, tb_Data_3_Out, tb_Data_2_Out, tb_Data_1_Out, tb_Data_0_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                                   , $time,
            "Enable_In = 0x%1b , "                        , Enable_In,
            "Encoded_Value_In = 0x%1h , "                 , Encoded_Value_In,
            "{Data_31_Out ... Data_0_Out} = %32b , "      , {Data_31_Out, Data_30_Out, Data_29_Out, Data_28_Out, Data_27_Out, Data_26_Out, Data_25_Out, Data_24_Out, Data_23_Out, Data_22_Out, Data_21_Out, Data_20_Out, Data_19_Out, Data_18_Out, Data_17_Out, Data_16_Out, Data_15_Out, Data_14_Out, Data_13_Out, Data_12_Out, Data_11_Out, Data_10_Out, Data_9_Out, Data_8_Out, Data_7_Out, Data_6_Out, Data_5_Out, Data_4_Out, Data_3_Out, Data_2_Out, Data_1_Out, Data_0_Out},
            "{tb_Data_31_Out ... tb_Data_0_Out} = %32b , ", {tb_Data_31_Out, tb_Data_30_Out, tb_Data_29_Out, tb_Data_28_Out, tb_Data_27_Out, tb_Data_26_Out, tb_Data_25_Out, tb_Data_24_Out, tb_Data_23_Out, tb_Data_22_Out, tb_Data_21_Out, tb_Data_20_Out, tb_Data_19_Out, tb_Data_18_Out, tb_Data_17_Out, tb_Data_16_Out, tb_Data_15_Out, tb_Data_14_Out, tb_Data_13_Out, tb_Data_12_Out, tb_Data_11_Out, tb_Data_10_Out, tb_Data_9_Out, tb_Data_8_Out, tb_Data_7_Out, tb_Data_6_Out, tb_Data_5_Out, tb_Data_4_Out, tb_Data_3_Out, tb_Data_2_Out, tb_Data_1_Out, tb_Data_0_Out},
            "Is_Same = %1b"                               , Is_Same
        ));
    end
endtask

// Testbench Decoder_5_32
task tb_Decoder_5_32();
    begin
        tb_Data_0_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd0)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_1_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd1)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_2_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd2)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_3_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd3)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_4_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd4)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_5_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd5)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_6_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd6)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_7_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd7)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_8_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd8)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_9_Out  = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd9)  ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_10_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd10) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_11_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd11) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_12_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd12) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_13_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd13) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_14_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd14) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_15_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd15) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_16_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd16) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_17_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd17) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_18_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd18) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_19_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd19) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_20_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd20) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_21_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd21) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_22_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd22) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_23_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd23) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_24_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd24) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_25_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd25) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_26_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd26) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_27_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd27) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_28_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd28) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_29_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd29) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_30_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd30) ? 1'b1 : 1'b0) : 1'bZ;
        tb_Data_31_Out = tb_Enable_In ? ((tb_Encoded_Value_In == 5'd31) ? 1'b1 : 1'b0) : 1'bZ;
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Decoder_5_32_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Decoder_5_32 - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        // Few Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Few Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_Decoder_5_32(1'b0, $random());
        Check_Decoder_5_32(1'b1, 5'd0);
        Check_Decoder_5_32(1'b1, 5'd1);
        Check_Decoder_5_32(1'b1, 5'd2);
        Check_Decoder_5_32(1'b1, 5'd3);
        Check_Decoder_5_32(1'b1, 5'd4);
        Check_Decoder_5_32(1'b1, 5'd5);
        Check_Decoder_5_32(1'b1, 5'd6);
        Check_Decoder_5_32(1'b1, 5'd7);
        Check_Decoder_5_32(1'b1, 5'd8);
        Check_Decoder_5_32(1'b1, 5'd9);
        Check_Decoder_5_32(1'b1, 5'd10);
        Check_Decoder_5_32(1'b1, 5'd11);
        Check_Decoder_5_32(1'b1, 5'd12);
        Check_Decoder_5_32(1'b1, 5'd13);
        Check_Decoder_5_32(1'b1, 5'd14);
        Check_Decoder_5_32(1'b1, 5'd15);
        Check_Decoder_5_32(1'b1, 5'd16);
        Check_Decoder_5_32(1'b1, 5'd17);
        Check_Decoder_5_32(1'b1, 5'd18);
        Check_Decoder_5_32(1'b1, 5'd19);
        Check_Decoder_5_32(1'b1, 5'd20);
        Check_Decoder_5_32(1'b1, 5'd21);
        Check_Decoder_5_32(1'b1, 5'd22);
        Check_Decoder_5_32(1'b1, 5'd23);
        Check_Decoder_5_32(1'b1, 5'd24);
        Check_Decoder_5_32(1'b1, 5'd25);
        Check_Decoder_5_32(1'b1, 5'd26);
        Check_Decoder_5_32(1'b1, 5'd27);
        Check_Decoder_5_32(1'b1, 5'd28);
        Check_Decoder_5_32(1'b1, 5'd29);
        Check_Decoder_5_32(1'b1, 5'd30);
        Check_Decoder_5_32(1'b1, 5'd31);
        
        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        repeat(20)
            begin
                Check_Decoder_5_32($random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
