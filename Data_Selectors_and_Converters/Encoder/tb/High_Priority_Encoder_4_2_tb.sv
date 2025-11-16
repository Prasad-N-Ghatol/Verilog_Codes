/*
--------------------------------------------------
Module :
--------------------------------------------------
High_Priority_Encoder_4_2_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 4:2 High Priority Encoder Implementation.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module High_Priority_Encoder_4_2_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg        Enable_In = 1'b0;

reg        Data_0_In = 1'b0;
reg        Data_1_In = 1'b0;
reg        Data_2_In = 1'b0;
reg        Data_3_In = 1'b0;

wire [1:0] Encoded_Value_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire [1:0] DUT_Encoded_Value = DUT.Encoded_Value;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic       tb_Enable_In           = 1'b0;

logic       tb_Data_0_In           = 1'b0;
logic       tb_Data_1_In           = 1'b0;
logic       tb_Data_2_In           = 1'b0;
logic       tb_Data_3_In           = 1'b0;

logic [1:0] tb_Encoded_Value_Out   = 2'b0;



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
// High_Priority_Encoder_4_2 DUT Instantiation
// --------------------------------------------------
High_Priority_Encoder_4_2 DUT (
    .Enable_In          (Enable_In),

    .Data_0_In          (Data_0_In),
    .Data_1_In          (Data_1_In),
    .Data_2_In          (Data_2_In),
    .Data_3_In          (Data_3_In),

    .Encoded_Value_Out  (Encoded_Value_Out)
);



// --------------------------------------------------
// High_Priority_Encoder_4_2 VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/High_Priority_Encoder_4_2.vcd");
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
// Check the 4:2 High Priority Encoder
task Check_High_Priority_Encoder_4_2(input logic f_Enable_In, input logic [3:0] f_Data_In);
    begin
        Enable_In = f_Enable_In;
        Data_0_In = f_Data_In[0];
        Data_1_In = f_Data_In[1];
        Data_2_In = f_Data_In[2];
        Data_3_In = f_Data_In[3];
        
        tb_Enable_In = f_Enable_In;
        tb_Data_0_In = f_Data_In[0];
        tb_Data_1_In = f_Data_In[1];
        tb_Data_2_In = f_Data_In[2];
        tb_Data_3_In = f_Data_In[3];

        if (tb_Enable_In)
            begin
                tb_High_Priority_Encoder_4_2();
            end
        else
            begin
                tb_Encoded_Value_Out = 2'bZ;
            end
        
        #20;
        
        Check_Actual_vs_Expected_Value(Encoded_Value_Out, tb_Encoded_Value_Out);

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                         , $time,
            "Enable_In = 0x%1b , "              , Enable_In,
            "{Data_3_In ... Data_0_In} = %4b , ", {Data_3_In, Data_2_In, Data_1_In, Data_0_In},
            "Encoded_Value_Out = 0x%1h , "      , Encoded_Value_Out,
            "tb_Encoded_Value_Out = 0x%1h , "   , tb_Encoded_Value_Out,
            "Is_Same = %1b"                     , Is_Same
        ));
    end
endtask

// Testbench High_Priority_Encoder_4_2
task tb_High_Priority_Encoder_4_2();
    begin
        casex ({tb_Data_3_In, tb_Data_2_In, tb_Data_1_In, tb_Data_0_In})
            4'b1xxx : begin tb_Encoded_Value_Out <= 2'd3; end
            4'b01xx : begin tb_Encoded_Value_Out <= 2'd2; end
            4'b001x : begin tb_Encoded_Value_Out <= 2'd1; end
            4'b0001 : begin tb_Encoded_Value_Out <= 2'd0; end
            default : begin tb_Encoded_Value_Out <= 2'dZ; end
        endcase
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/High_Priority_Encoder_4_2_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("High_Priority_Encoder_4_2 - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        // Few Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Few Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_High_Priority_Encoder_4_2(1'b0, $random());
        Check_High_Priority_Encoder_4_2(1'b1, 0 << 0);
        Check_High_Priority_Encoder_4_2(1'b1, 1 << 0);
        Check_High_Priority_Encoder_4_2(1'b1, 1 << 1);
        Check_High_Priority_Encoder_4_2(1'b1, 1 << 2);
        Check_High_Priority_Encoder_4_2(1'b1, 1 << 3);
        
        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        repeat(20)
            begin
                Check_High_Priority_Encoder_4_2($random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
