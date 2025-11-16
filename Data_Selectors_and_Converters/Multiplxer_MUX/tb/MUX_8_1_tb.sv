/*
--------------------------------------------------
Module :
--------------------------------------------------
MUX_8_1_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 8:1 Multiplexer (MUX) Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module MUX_8_1_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg        Enable_In = 1'b0;

reg        Data_0_In = 1'b0;
reg        Data_1_In = 1'b0;
reg        Data_2_In = 1'b0;
reg        Data_3_In = 1'b0;
reg        Data_4_In = 1'b0;
reg        Data_5_In = 1'b0;
reg        Data_6_In = 1'b0;
reg        Data_7_In = 1'b0;

reg  [2:0] Select_In = 3'b0;

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

logic [2:0] tb_Select_In              = 3'b0;

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
// MUX_8_1 DUT Instantiation
// --------------------------------------------------
MUX_8_1 DUT (
    .Enable_In              (Enable_In),

    .Data_0_In              (Data_0_In),
    .Data_1_In              (Data_1_In),
    .Data_2_In              (Data_2_In),
    .Data_3_In              (Data_3_In),
    .Data_4_In              (Data_4_In),
    .Data_5_In              (Data_5_In),
    .Data_6_In              (Data_6_In),
    .Data_7_In              (Data_7_In),

    .Select_In              (Select_In),

    .MUX_Result_Data_Out    (MUX_Result_Data_Out)
);



// --------------------------------------------------
// MUX_8_1 VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/MUX_8_1.vcd");
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
// Check the 8:1 MUX
task Check_MUX_8_1(input logic f_Enable_In, input logic [7:0] f_Data_In, input logic [2:0] f_Select_In);
    begin
        Enable_In = f_Enable_In;
        Data_0_In = f_Data_In[0];
        Data_1_In = f_Data_In[1];
        Data_2_In = f_Data_In[2];
        Data_3_In = f_Data_In[3];
        Data_4_In = f_Data_In[4];
        Data_5_In = f_Data_In[5];
        Data_6_In = f_Data_In[6];
        Data_7_In = f_Data_In[7];
        Select_In = f_Select_In;
        
        tb_Enable_In = f_Enable_In;
        tb_Data_0_In = f_Data_In[0];
        tb_Data_1_In = f_Data_In[1];
        tb_Data_2_In = f_Data_In[2];
        tb_Data_3_In = f_Data_In[3];
        tb_Data_4_In = f_Data_In[4];
        tb_Data_5_In = f_Data_In[5];
        tb_Data_6_In = f_Data_In[6];
        tb_Data_7_In = f_Data_In[7];
        tb_Select_In = f_Select_In;

        if (tb_Enable_In)
            begin
                tb_MUX_8_1();
            end
        else
            begin
                tb_MUX_Result_Data_Out = 1'bZ;
            end
        
        #20;
        
        Check_Actual_vs_Expected_Value(MUX_Result_Data_Out, tb_MUX_Result_Data_Out);

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                         , $time,
            "Enable_In = 0x%1b, "               , Enable_In,
            "{Data_7_In ... Data_0_In} = %8b , ", {Data_7_In, Data_6_In, Data_5_In, Data_4_In, Data_3_In, Data_2_In, Data_1_In, Data_0_In},
            "Select_In = %1d , "                , Select_In,
            "MUX_Result_Data_Out = 0x%1b , "    , MUX_Result_Data_Out,
            "tb_MUX_Result_Data_Out = 0x%1b , " , tb_MUX_Result_Data_Out,
            "Is_Same = %1b"                     , Is_Same
        ));
    end
endtask

// Testbench MUX_8_1
task tb_MUX_8_1();
    begin
        case (tb_Select_In)
            3'd0    : begin tb_MUX_Result_Data_Out = tb_Data_0_In; end
            3'd1    : begin tb_MUX_Result_Data_Out = tb_Data_1_In; end
            3'd2    : begin tb_MUX_Result_Data_Out = tb_Data_2_In; end
            3'd3    : begin tb_MUX_Result_Data_Out = tb_Data_3_In; end
            3'd4    : begin tb_MUX_Result_Data_Out = tb_Data_4_In; end
            3'd5    : begin tb_MUX_Result_Data_Out = tb_Data_5_In; end
            3'd6    : begin tb_MUX_Result_Data_Out = tb_Data_6_In; end
            3'd7    : begin tb_MUX_Result_Data_Out = tb_Data_7_In; end
            default : begin tb_MUX_Result_Data_Out = 1'b0;  end
        endcase
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/MUX_8_1_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("MUX_8_1 - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        // Few Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Few Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_8_1(1'b0, $random(), $random());
        Check_MUX_8_1(1'b1,  (1 << 0), 3'd0);
        Check_MUX_8_1(1'b1, ~(1 << 0), 3'd0);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_8_1(1'b0, $random(), $random());
        Check_MUX_8_1(1'b1,  (1 << 1), 3'd1);
        Check_MUX_8_1(1'b1, ~(1 << 1), 3'd1);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_8_1(1'b0, $random(), $random());
        Check_MUX_8_1(1'b1,  (1 << 2), 3'd2);
        Check_MUX_8_1(1'b1, ~(1 << 2), 3'd2);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_8_1(1'b0, $random(), $random());
        Check_MUX_8_1(1'b1,  (1 << 3), 3'd3);
        Check_MUX_8_1(1'b1, ~(1 << 3), 3'd3);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_8_1(1'b0, $random(), $random());
        Check_MUX_8_1(1'b1,  (1 << 4), 3'd4);
        Check_MUX_8_1(1'b1, ~(1 << 4), 3'd4);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_8_1(1'b0, $random(), $random());
        Check_MUX_8_1(1'b1,  (1 << 5), 3'd5);
        Check_MUX_8_1(1'b1, ~(1 << 5), 3'd5);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_8_1(1'b0, $random(), $random());
        Check_MUX_8_1(1'b1,  (1 << 6), 3'd6);
        Check_MUX_8_1(1'b1, ~(1 << 6), 3'd6);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_MUX_8_1(1'b0, $random(), $random());
        Check_MUX_8_1(1'b1,  (1 << 7), 3'd7);
        Check_MUX_8_1(1'b1, ~(1 << 7), 3'd7);
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        repeat(10)
            begin
                Check_MUX_8_1($random(), $random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
