/*
--------------------------------------------------
Module :
--------------------------------------------------
High_Priority_Encoder_32_5_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 32:5 High Priority Encoder Implementation.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module High_Priority_Encoder_32_5_tb ();



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

wire [4:0] Encoded_Value_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire [4:0] DUT_Encoded_Value = DUT.Encoded_Value;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic       tb_Enable_In           = 1'b0;

logic       tb_Data_0_In           = 1'b0;
logic       tb_Data_1_In           = 1'b0;
logic       tb_Data_2_In           = 1'b0;
logic       tb_Data_3_In           = 1'b0;
logic       tb_Data_4_In           = 1'b0;
logic       tb_Data_5_In           = 1'b0;
logic       tb_Data_6_In           = 1'b0;
logic       tb_Data_7_In           = 1'b0;
logic       tb_Data_8_In           = 1'b0;
logic       tb_Data_9_In           = 1'b0;
logic       tb_Data_10_In          = 1'b0;
logic       tb_Data_11_In          = 1'b0;
logic       tb_Data_12_In          = 1'b0;
logic       tb_Data_13_In          = 1'b0;
logic       tb_Data_14_In          = 1'b0;
logic       tb_Data_15_In          = 1'b0;
logic       tb_Data_16_In          = 1'b0;
logic       tb_Data_17_In          = 1'b0;
logic       tb_Data_18_In          = 1'b0;
logic       tb_Data_19_In          = 1'b0;
logic       tb_Data_20_In          = 1'b0;
logic       tb_Data_21_In          = 1'b0;
logic       tb_Data_22_In          = 1'b0;
logic       tb_Data_23_In          = 1'b0;
logic       tb_Data_24_In          = 1'b0;
logic       tb_Data_25_In          = 1'b0;
logic       tb_Data_26_In          = 1'b0;
logic       tb_Data_27_In          = 1'b0;
logic       tb_Data_28_In          = 1'b0;
logic       tb_Data_29_In          = 1'b0;
logic       tb_Data_30_In          = 1'b0;
logic       tb_Data_31_In          = 1'b0;

logic [4:0] tb_Encoded_Value_Out   = 5'b0;



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
// High_Priority_Encoder_32_5 DUT Instantiation
// --------------------------------------------------
High_Priority_Encoder_32_5 DUT (
    .Enable_In          (Enable_In),

    .Data_0_In          (Data_0_In),
    .Data_1_In          (Data_1_In),
    .Data_2_In          (Data_2_In),
    .Data_3_In          (Data_3_In),
    .Data_4_In          (Data_4_In),
    .Data_5_In          (Data_5_In),
    .Data_6_In          (Data_6_In),
    .Data_7_In          (Data_7_In),
    .Data_8_In          (Data_8_In),
    .Data_9_In          (Data_9_In),
    .Data_10_In         (Data_10_In),
    .Data_11_In         (Data_11_In),
    .Data_12_In         (Data_12_In),
    .Data_13_In         (Data_13_In),
    .Data_14_In         (Data_14_In),
    .Data_15_In         (Data_15_In),
    .Data_16_In         (Data_16_In),
    .Data_17_In         (Data_17_In),
    .Data_18_In         (Data_18_In),
    .Data_19_In         (Data_19_In),
    .Data_20_In         (Data_20_In),
    .Data_21_In         (Data_21_In),
    .Data_22_In         (Data_22_In),
    .Data_23_In         (Data_23_In),
    .Data_24_In         (Data_24_In),
    .Data_25_In         (Data_25_In),
    .Data_26_In         (Data_26_In),
    .Data_27_In         (Data_27_In),
    .Data_28_In         (Data_28_In),
    .Data_29_In         (Data_29_In),
    .Data_30_In         (Data_30_In),
    .Data_31_In         (Data_31_In),

    .Encoded_Value_Out  (Encoded_Value_Out)
);



// --------------------------------------------------
// High_Priority_Encoder_32_5 VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/High_Priority_Encoder_32_5.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [4:0] f_Actual_Value, input logic [4:0] f_Expected_Value);
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
// Check the 32:5 High Priority Encoder
task Check_High_Priority_Encoder_32_5(input logic f_Enable_In, input logic [31:0] f_Data_In);
    begin
        Enable_In   = f_Enable_In;
        Data_0_In   = f_Data_In[0];
        Data_1_In   = f_Data_In[1];
        Data_2_In   = f_Data_In[2];
        Data_3_In   = f_Data_In[3];
        Data_4_In   = f_Data_In[4];
        Data_5_In   = f_Data_In[5];
        Data_6_In   = f_Data_In[6];
        Data_7_In   = f_Data_In[7];
        Data_8_In   = f_Data_In[8];
        Data_9_In   = f_Data_In[9];
        Data_10_In  = f_Data_In[10];
        Data_11_In  = f_Data_In[11];
        Data_12_In  = f_Data_In[12];
        Data_13_In  = f_Data_In[13];
        Data_14_In  = f_Data_In[14];
        Data_15_In  = f_Data_In[15];
        Data_16_In  = f_Data_In[16];
        Data_17_In  = f_Data_In[17];
        Data_18_In  = f_Data_In[18];
        Data_19_In  = f_Data_In[19];
        Data_20_In  = f_Data_In[20];
        Data_21_In  = f_Data_In[21];
        Data_22_In  = f_Data_In[22];
        Data_23_In  = f_Data_In[23];
        Data_24_In  = f_Data_In[24];
        Data_25_In  = f_Data_In[25];
        Data_26_In  = f_Data_In[26];
        Data_27_In  = f_Data_In[27];
        Data_28_In  = f_Data_In[28];
        Data_29_In  = f_Data_In[29];
        Data_30_In  = f_Data_In[30];
        Data_31_In  = f_Data_In[31];
        
        tb_Enable_In    = f_Enable_In;
        tb_Data_0_In    = f_Data_In[0];
        tb_Data_1_In    = f_Data_In[1];
        tb_Data_2_In    = f_Data_In[2];
        tb_Data_3_In    = f_Data_In[3];
        tb_Data_4_In    = f_Data_In[4];
        tb_Data_5_In    = f_Data_In[5];
        tb_Data_6_In    = f_Data_In[6];
        tb_Data_7_In    = f_Data_In[7];
        tb_Data_8_In    = f_Data_In[8];
        tb_Data_9_In    = f_Data_In[9];
        tb_Data_10_In   = f_Data_In[10];
        tb_Data_11_In   = f_Data_In[11];
        tb_Data_12_In   = f_Data_In[12];
        tb_Data_13_In   = f_Data_In[13];
        tb_Data_14_In   = f_Data_In[14];
        tb_Data_15_In   = f_Data_In[15];
        tb_Data_16_In   = f_Data_In[16];
        tb_Data_17_In   = f_Data_In[17];
        tb_Data_18_In   = f_Data_In[18];
        tb_Data_19_In   = f_Data_In[19];
        tb_Data_20_In   = f_Data_In[20];
        tb_Data_21_In   = f_Data_In[21];
        tb_Data_22_In   = f_Data_In[22];
        tb_Data_23_In   = f_Data_In[23];
        tb_Data_24_In   = f_Data_In[24];
        tb_Data_25_In   = f_Data_In[25];
        tb_Data_26_In   = f_Data_In[26];
        tb_Data_27_In   = f_Data_In[27];
        tb_Data_28_In   = f_Data_In[28];
        tb_Data_29_In   = f_Data_In[29];
        tb_Data_30_In   = f_Data_In[30];
        tb_Data_31_In   = f_Data_In[31];

        if (tb_Enable_In)
            begin
                tb_High_Priority_Encoder_32_5();
            end
        else
            begin
                tb_Encoded_Value_Out = 5'bZ;
            end
        
        #20;
        
        Check_Actual_vs_Expected_Value(Encoded_Value_Out, tb_Encoded_Value_Out);

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                           , $time,
            "Enable_In = 0x%1b , "                , Enable_In,
            "{Data_31_In ... Data_0_In} = %32b , ", {Data_31_In, Data_30_In, Data_29_In, Data_28_In, Data_27_In, Data_26_In, Data_25_In, Data_24_In, Data_23_In, Data_22_In, Data_21_In, Data_20_In, Data_19_In, Data_18_In, Data_17_In, Data_16_In, Data_15_In, Data_14_In, Data_13_In, Data_12_In, Data_11_In, Data_10_In, Data_9_In, Data_8_In, Data_7_In, Data_6_In, Data_5_In, Data_4_In, Data_3_In, Data_2_In, Data_1_In, Data_0_In},
            "Encoded_Value_Out = 0x%2h , "        , Encoded_Value_Out,
            "tb_Encoded_Value_Out = 0x%2h , "     , tb_Encoded_Value_Out,
            "Is_Same = %1b"                       , Is_Same
        ));
    end
endtask

// Testbench High_Priority_Encoder_32_5
task tb_High_Priority_Encoder_32_5();
    begin
        casex ({tb_Data_31_In, tb_Data_30_In, tb_Data_29_In, tb_Data_28_In, tb_Data_27_In, tb_Data_26_In, tb_Data_25_In, tb_Data_24_In, tb_Data_23_In, tb_Data_22_In, tb_Data_21_In, tb_Data_20_In, tb_Data_19_In, tb_Data_18_In, tb_Data_17_In, tb_Data_16_In, tb_Data_15_In, tb_Data_14_In, tb_Data_13_In, tb_Data_12_In, tb_Data_11_In, tb_Data_10_In, tb_Data_9_In, tb_Data_8_In, tb_Data_7_In, tb_Data_6_In, tb_Data_5_In, tb_Data_4_In, tb_Data_3_In, tb_Data_2_In, tb_Data_1_In, tb_Data_0_In})
            32'b1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd31; end
            32'b01xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd30; end
            32'b001xxxxxxxxxxxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd29; end
            32'b0001xxxxxxxxxxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd28; end
            32'b00001xxxxxxxxxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd27; end
            32'b000001xxxxxxxxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd26; end
            32'b0000001xxxxxxxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd25; end
            32'b00000001xxxxxxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd24; end
            32'b000000001xxxxxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd23; end
            32'b0000000001xxxxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd22; end
            32'b00000000001xxxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd21; end
            32'b000000000001xxxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd20; end
            32'b0000000000001xxxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd19; end
            32'b00000000000001xxxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd18; end
            32'b000000000000001xxxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd17; end
            32'b0000000000000001xxxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd16; end
            32'b00000000000000001xxxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd15; end
            32'b000000000000000001xxxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd14; end
            32'b0000000000000000001xxxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd13; end
            32'b00000000000000000001xxxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd12; end
            32'b000000000000000000001xxxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd11; end
            32'b0000000000000000000001xxxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd10; end
            32'b00000000000000000000001xxxxxxxxx : begin tb_Encoded_Value_Out <= 5'd9;  end
            32'b000000000000000000000001xxxxxxxx : begin tb_Encoded_Value_Out <= 5'd8;  end
            32'b0000000000000000000000001xxxxxxx : begin tb_Encoded_Value_Out <= 5'd7;  end
            32'b00000000000000000000000001xxxxxx : begin tb_Encoded_Value_Out <= 5'd6;  end
            32'b000000000000000000000000001xxxxx : begin tb_Encoded_Value_Out <= 5'd5;  end
            32'b0000000000000000000000000001xxxx : begin tb_Encoded_Value_Out <= 5'd4;  end
            32'b00000000000000000000000000001xxx : begin tb_Encoded_Value_Out <= 5'd3;  end
            32'b000000000000000000000000000001xx : begin tb_Encoded_Value_Out <= 5'd2;  end
            32'b0000000000000000000000000000001x : begin tb_Encoded_Value_Out <= 5'd1;  end
            32'b00000000000000000000000000000001 : begin tb_Encoded_Value_Out <= 5'd0;  end
            default                              : begin tb_Encoded_Value_Out <= 5'dZ;  end
        endcase
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/High_Priority_Encoder_32_5_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("High_Priority_Encoder_32_5 - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        // Few Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Few Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_High_Priority_Encoder_32_5(1'b0, $random());
        Check_High_Priority_Encoder_32_5(1'b1, 0 << 0);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 0);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 1);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 2);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 3);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 4);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 5);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 6);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 7);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 8);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 9);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 10);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 11);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 12);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 13);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 14);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 15);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 16);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 17);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 18);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 19);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 20);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 21);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 22);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 23);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 24);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 25);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 26);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 27);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 28);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 29);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 30);
        Check_High_Priority_Encoder_32_5(1'b1, 1 << 31);
        
        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        repeat(20)
            begin
                Check_High_Priority_Encoder_32_5($random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
