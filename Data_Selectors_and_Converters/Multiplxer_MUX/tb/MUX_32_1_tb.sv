/*
--------------------------------------------------
Module :
--------------------------------------------------
MUX_32_1_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 32:1 Multiplexer (MUX) Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module MUX_32_1_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg        Enable_In = 1'b0;

reg        Data_0_In    = 1'b0;
reg        Data_1_In    = 1'b0;
reg        Data_2_In    = 1'b0;
reg        Data_3_In    = 1'b0;
reg        Data_4_In    = 1'b0;
reg        Data_5_In    = 1'b0;
reg        Data_6_In    = 1'b0;
reg        Data_7_In    = 1'b0;
reg        Data_8_In    = 1'b0;
reg        Data_9_In    = 1'b0;
reg        Data_10_In   = 1'b0;
reg        Data_11_In   = 1'b0;
reg        Data_12_In   = 1'b0;
reg        Data_13_In   = 1'b0;
reg        Data_14_In   = 1'b0;
reg        Data_15_In   = 1'b0;
reg        Data_16_In   = 1'b0;
reg        Data_17_In   = 1'b0;
reg        Data_18_In   = 1'b0;
reg        Data_19_In   = 1'b0;
reg        Data_20_In   = 1'b0;
reg        Data_21_In   = 1'b0;
reg        Data_22_In   = 1'b0;
reg        Data_23_In   = 1'b0;
reg        Data_24_In   = 1'b0;
reg        Data_25_In   = 1'b0;
reg        Data_26_In   = 1'b0;
reg        Data_27_In   = 1'b0;
reg        Data_28_In   = 1'b0;
reg        Data_29_In   = 1'b0;
reg        Data_30_In   = 1'b0;
reg        Data_31_In   = 1'b0;

reg  [4:0] Select_In = 5'b0;

wire       MUX_Result_Data_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire DUT_MUX_Data_Selected = DUT.MUX_Data_Selected;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic       tb_Enable_In              = 1'b0;

logic       tb_Data_0_In              = 1'b0;
logic       tb_Data_1_In              = 1'b0;
logic       tb_Data_2_In              = 1'b0;
logic       tb_Data_3_In              = 1'b0;
logic       tb_Data_4_In              = 1'b0;
logic       tb_Data_5_In              = 1'b0;
logic       tb_Data_6_In              = 1'b0;
logic       tb_Data_7_In              = 1'b0;
logic       tb_Data_8_In              = 1'b0;
logic       tb_Data_9_In              = 1'b0;
logic       tb_Data_10_In             = 1'b0;
logic       tb_Data_11_In             = 1'b0;
logic       tb_Data_12_In             = 1'b0;
logic       tb_Data_13_In             = 1'b0;
logic       tb_Data_14_In             = 1'b0;
logic       tb_Data_15_In             = 1'b0;
logic       tb_Data_16_In             = 1'b0;
logic       tb_Data_17_In             = 1'b0;
logic       tb_Data_18_In             = 1'b0;
logic       tb_Data_19_In             = 1'b0;
logic       tb_Data_20_In             = 1'b0;
logic       tb_Data_21_In             = 1'b0;
logic       tb_Data_22_In             = 1'b0;
logic       tb_Data_23_In             = 1'b0;
logic       tb_Data_24_In             = 1'b0;
logic       tb_Data_25_In             = 1'b0;
logic       tb_Data_26_In             = 1'b0;
logic       tb_Data_27_In             = 1'b0;
logic       tb_Data_28_In             = 1'b0;
logic       tb_Data_29_In             = 1'b0;
logic       tb_Data_30_In             = 1'b0;
logic       tb_Data_31_In             = 1'b0;

logic [4:0] tb_Select_In              = 5'b0;

logic       tb_MUX_Result_Data_Out    = 1'b0;



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
// MUX_32_1 DUT Instantiation
// --------------------------------------------------
MUX_32_1 DUT (
    .Enable_In              (Enable_In),

    .Data_0_In              (Data_0_In),
    .Data_1_In              (Data_1_In),
    .Data_2_In              (Data_2_In),
    .Data_3_In              (Data_3_In),
    .Data_4_In              (Data_4_In),
    .Data_5_In              (Data_5_In),
    .Data_6_In              (Data_6_In),
    .Data_7_In              (Data_7_In),
    .Data_8_In              (Data_8_In),
    .Data_9_In              (Data_9_In),
    .Data_10_In             (Data_10_In),
    .Data_11_In             (Data_11_In),
    .Data_12_In             (Data_12_In),
    .Data_13_In             (Data_13_In),
    .Data_14_In             (Data_14_In),
    .Data_15_In             (Data_15_In),
    .Data_16_In             (Data_16_In),
    .Data_17_In             (Data_17_In),
    .Data_18_In             (Data_18_In),
    .Data_19_In             (Data_19_In),
    .Data_20_In             (Data_20_In),
    .Data_21_In             (Data_21_In),
    .Data_22_In             (Data_22_In),
    .Data_23_In             (Data_23_In),
    .Data_24_In             (Data_24_In),
    .Data_25_In             (Data_25_In),
    .Data_26_In             (Data_26_In),
    .Data_27_In             (Data_27_In),
    .Data_28_In             (Data_28_In),
    .Data_29_In             (Data_29_In),
    .Data_30_In             (Data_30_In),
    .Data_31_In             (Data_31_In),

    .Select_In              (Select_In),

    .MUX_Result_Data_Out    (MUX_Result_Data_Out)
);



// --------------------------------------------------
// MUX_32_1 VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/MUX_32_1.vcd");
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
// Check the 32:1 MUX
task Check_MUX_32_1(input logic f_Enable_In, input logic [31:0] f_Data_In, input logic [4:0] f_Select_In);
    begin
        Enable_In  = f_Enable_In;
        Data_0_In  = f_Data_In[0];
        Data_1_In  = f_Data_In[1];
        Data_2_In  = f_Data_In[2];
        Data_3_In  = f_Data_In[3];
        Data_4_In  = f_Data_In[4];
        Data_5_In  = f_Data_In[5];
        Data_6_In  = f_Data_In[6];
        Data_7_In  = f_Data_In[7];
        Data_8_In  = f_Data_In[8];
        Data_9_In  = f_Data_In[9];
        Data_10_In = f_Data_In[10];
        Data_11_In = f_Data_In[11];
        Data_12_In = f_Data_In[12];
        Data_13_In = f_Data_In[13];
        Data_14_In = f_Data_In[14];
        Data_15_In = f_Data_In[15];
        Data_16_In = f_Data_In[16];
        Data_17_In = f_Data_In[17];
        Data_18_In = f_Data_In[18];
        Data_19_In = f_Data_In[19];
        Data_20_In = f_Data_In[20];
        Data_21_In = f_Data_In[21];
        Data_22_In = f_Data_In[22];
        Data_23_In = f_Data_In[23];
        Data_24_In = f_Data_In[24];
        Data_25_In = f_Data_In[25];
        Data_26_In = f_Data_In[26];
        Data_27_In = f_Data_In[27];
        Data_28_In = f_Data_In[28];
        Data_29_In = f_Data_In[29];
        Data_30_In = f_Data_In[30];
        Data_31_In = f_Data_In[31];
        Select_In  = f_Select_In;
        
        tb_Enable_In  = f_Enable_In;
        tb_Data_0_In  = f_Data_In[0];
        tb_Data_1_In  = f_Data_In[1];
        tb_Data_2_In  = f_Data_In[2];
        tb_Data_3_In  = f_Data_In[3];
        tb_Data_4_In  = f_Data_In[4];
        tb_Data_5_In  = f_Data_In[5];
        tb_Data_6_In  = f_Data_In[6];
        tb_Data_7_In  = f_Data_In[7];
        tb_Data_8_In  = f_Data_In[8];
        tb_Data_9_In  = f_Data_In[9];
        tb_Data_10_In = f_Data_In[10];
        tb_Data_11_In = f_Data_In[11];
        tb_Data_12_In = f_Data_In[12];
        tb_Data_13_In = f_Data_In[13];
        tb_Data_14_In = f_Data_In[14];
        tb_Data_15_In = f_Data_In[15];
        tb_Data_16_In = f_Data_In[16];
        tb_Data_17_In = f_Data_In[17];
        tb_Data_18_In = f_Data_In[18];
        tb_Data_19_In = f_Data_In[19];
        tb_Data_20_In = f_Data_In[20];
        tb_Data_21_In = f_Data_In[21];
        tb_Data_22_In = f_Data_In[22];
        tb_Data_23_In = f_Data_In[23];
        tb_Data_24_In = f_Data_In[24];
        tb_Data_25_In = f_Data_In[25];
        tb_Data_26_In = f_Data_In[26];
        tb_Data_27_In = f_Data_In[27];
        tb_Data_28_In = f_Data_In[28];
        tb_Data_29_In = f_Data_In[29];
        tb_Data_30_In = f_Data_In[30];
        tb_Data_31_In = f_Data_In[31];
        tb_Select_In  = f_Select_In;

        if (tb_Enable_In)
            begin
                tb_MUX_32_1();
            end
        else
            begin
                tb_MUX_Result_Data_Out = 1'bZ;
            end
        
        #20;
        
        Check_Actual_vs_Expected_Value(MUX_Result_Data_Out, tb_MUX_Result_Data_Out);

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                           , $time,
            "Enable_In = 0x%1b, "                 , Enable_In,
            "{Data_31_In ... Data_0_In} = %32b , ", {Data_31_In, Data_30_In, Data_29_In, Data_28_In, Data_27_In, Data_26_In, Data_25_In, Data_24_In, Data_23_In, Data_22_In, Data_21_In, Data_20_In, Data_19_In, Data_18_In, Data_17_In, Data_16_In, Data_15_In, Data_14_In, Data_13_In, Data_12_In, Data_11_In, Data_10_In, Data_9_In, Data_8_In, Data_7_In, Data_6_In, Data_5_In, Data_4_In, Data_3_In, Data_2_In, Data_1_In, Data_0_In},
            "Select_In = %2d , "                  , Select_In,
            "MUX_Result_Data_Out = 0x%1b , "      , MUX_Result_Data_Out,
            "tb_MUX_Result_Data_Out = 0x%1b , "   , tb_MUX_Result_Data_Out,
            "Is_Same = %1b"                       , Is_Same
        ));
    end
endtask

// Testbench MUX_32_1
task tb_MUX_32_1();
    begin
        case (tb_Select_In)
            5'd0    : begin tb_MUX_Result_Data_Out = tb_Data_0_In;  end
            5'd1    : begin tb_MUX_Result_Data_Out = tb_Data_1_In;  end
            5'd2    : begin tb_MUX_Result_Data_Out = tb_Data_2_In;  end
            5'd3    : begin tb_MUX_Result_Data_Out = tb_Data_3_In;  end
            5'd4    : begin tb_MUX_Result_Data_Out = tb_Data_4_In;  end
            5'd5    : begin tb_MUX_Result_Data_Out = tb_Data_5_In;  end
            5'd6    : begin tb_MUX_Result_Data_Out = tb_Data_6_In;  end
            5'd7    : begin tb_MUX_Result_Data_Out = tb_Data_7_In;  end
            5'd8    : begin tb_MUX_Result_Data_Out = tb_Data_8_In;  end
            5'd9    : begin tb_MUX_Result_Data_Out = tb_Data_9_In;  end
            5'd10   : begin tb_MUX_Result_Data_Out = tb_Data_10_In; end
            5'd11   : begin tb_MUX_Result_Data_Out = tb_Data_11_In; end
            5'd12   : begin tb_MUX_Result_Data_Out = tb_Data_12_In; end
            5'd13   : begin tb_MUX_Result_Data_Out = tb_Data_13_In; end
            5'd14   : begin tb_MUX_Result_Data_Out = tb_Data_14_In; end
            5'd15   : begin tb_MUX_Result_Data_Out = tb_Data_15_In; end
            5'd16   : begin tb_MUX_Result_Data_Out = tb_Data_16_In; end
            5'd17   : begin tb_MUX_Result_Data_Out = tb_Data_17_In; end
            5'd18   : begin tb_MUX_Result_Data_Out = tb_Data_18_In; end
            5'd19   : begin tb_MUX_Result_Data_Out = tb_Data_19_In; end
            5'd20   : begin tb_MUX_Result_Data_Out = tb_Data_20_In; end
            5'd21   : begin tb_MUX_Result_Data_Out = tb_Data_21_In; end
            5'd22   : begin tb_MUX_Result_Data_Out = tb_Data_22_In; end
            5'd23   : begin tb_MUX_Result_Data_Out = tb_Data_23_In; end
            5'd24   : begin tb_MUX_Result_Data_Out = tb_Data_24_In; end
            5'd25   : begin tb_MUX_Result_Data_Out = tb_Data_25_In; end
            5'd26   : begin tb_MUX_Result_Data_Out = tb_Data_26_In; end
            5'd27   : begin tb_MUX_Result_Data_Out = tb_Data_27_In; end
            5'd28   : begin tb_MUX_Result_Data_Out = tb_Data_28_In; end
            5'd29   : begin tb_MUX_Result_Data_Out = tb_Data_29_In; end
            5'd30   : begin tb_MUX_Result_Data_Out = tb_Data_30_In; end
            5'd31   : begin tb_MUX_Result_Data_Out = tb_Data_31_In; end
            default : begin tb_MUX_Result_Data_Out = 1'b0;  end
        endcase
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/MUX_32_1_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("MUX_32_1 - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        // Few Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Few Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 0), 5'd0);
        Check_MUX_32_1(1'b1, ~(1 << 0), 5'd0);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 1), 5'd1);
        Check_MUX_32_1(1'b1, ~(1 << 1), 5'd1);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 2), 5'd2);
        Check_MUX_32_1(1'b1, ~(1 << 2), 5'd2);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 3), 5'd3);
        Check_MUX_32_1(1'b1, ~(1 << 3), 5'd3);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 4), 5'd4);
        Check_MUX_32_1(1'b1, ~(1 << 4), 5'd4);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 5), 5'd5);
        Check_MUX_32_1(1'b1, ~(1 << 5), 5'd5);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 6), 5'd6);
        Check_MUX_32_1(1'b1, ~(1 << 6), 5'd6);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 7), 5'd7);
        Check_MUX_32_1(1'b1, ~(1 << 7), 5'd7);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 8), 5'd8);
        Check_MUX_32_1(1'b1, ~(1 << 8), 5'd8);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 9), 5'd9);
        Check_MUX_32_1(1'b1, ~(1 << 9), 5'd9);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 10), 5'd10);
        Check_MUX_32_1(1'b1, ~(1 << 10), 5'd10);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 11), 5'd11);
        Check_MUX_32_1(1'b1, ~(1 << 11), 5'd11);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 12), 5'd12);
        Check_MUX_32_1(1'b1, ~(1 << 12), 5'd12);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 13), 5'd13);
        Check_MUX_32_1(1'b1, ~(1 << 13), 5'd13);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 14), 5'd14);
        Check_MUX_32_1(1'b1, ~(1 << 14), 5'd14);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 15), 5'd15);
        Check_MUX_32_1(1'b1, ~(1 << 15), 5'd15);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 16), 5'd16);
        Check_MUX_32_1(1'b1, ~(1 << 16), 5'd16);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 17), 5'd17);
        Check_MUX_32_1(1'b1, ~(1 << 17), 5'd17);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 18), 5'd18);
        Check_MUX_32_1(1'b1, ~(1 << 18), 5'd18);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 19), 5'd19);
        Check_MUX_32_1(1'b1, ~(1 << 19), 5'd19);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 20), 5'd20);
        Check_MUX_32_1(1'b1, ~(1 << 20), 5'd20);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 21), 5'd21);
        Check_MUX_32_1(1'b1, ~(1 << 21), 5'd21);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 22), 5'd22);
        Check_MUX_32_1(1'b1, ~(1 << 22), 5'd22);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 23), 5'd23);
        Check_MUX_32_1(1'b1, ~(1 << 23), 5'd23);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 24), 5'd24);
        Check_MUX_32_1(1'b1, ~(1 << 24), 5'd24);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 25), 5'd25);
        Check_MUX_32_1(1'b1, ~(1 << 25), 5'd25);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 26), 5'd26);
        Check_MUX_32_1(1'b1, ~(1 << 26), 5'd26);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 27), 5'd27);
        Check_MUX_32_1(1'b1, ~(1 << 27), 5'd27);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 28), 5'd28);
        Check_MUX_32_1(1'b1, ~(1 << 28), 5'd28);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 29), 5'd29);
        Check_MUX_32_1(1'b1, ~(1 << 29), 5'd29);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 30), 5'd30);
        Check_MUX_32_1(1'b1, ~(1 << 30), 5'd30);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_32_1(1'b0, $random(), $random());
        Check_MUX_32_1(1'b1,  (1 << 31), 5'd31);
        Check_MUX_32_1(1'b1, ~(1 << 31), 5'd31);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        repeat(10)
            begin
                Check_MUX_32_1($random(), $random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
