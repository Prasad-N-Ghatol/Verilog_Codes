/*
--------------------------------------------------
Module :
--------------------------------------------------
Low_Priority_Encoder_8_3_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 8:3 Low Priority Encoder Implementation.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Low_Priority_Encoder_8_3_tb ();



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

wire [2:0] Encoded_Value_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire [2:0] DUT_Encoded_Value = DUT.Encoded_Value;



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

logic [2:0] tb_Encoded_Value_Out   = 3'b0;



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
// Low_Priority_Encoder_8_3 DUT Instantiation
// --------------------------------------------------
Low_Priority_Encoder_8_3 DUT (
    .Enable_In          (Enable_In),

    .Data_0_In          (Data_0_In),
    .Data_1_In          (Data_1_In),
    .Data_2_In          (Data_2_In),
    .Data_3_In          (Data_3_In),
    .Data_4_In          (Data_4_In),
    .Data_5_In          (Data_5_In),
    .Data_6_In          (Data_6_In),
    .Data_7_In          (Data_7_In),

    .Encoded_Value_Out  (Encoded_Value_Out)
);



// --------------------------------------------------
// Low_Priority_Encoder_8_3 VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Low_Priority_Encoder_8_3.vcd");
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
// Check the 8:3 Low Priority Encoder
task Check_Low_Priority_Encoder_8_3(input logic f_Enable_In, input logic [7:0] f_Data_In);
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
        
        tb_Enable_In = f_Enable_In;
        tb_Data_0_In = f_Data_In[0];
        tb_Data_1_In = f_Data_In[1];
        tb_Data_2_In = f_Data_In[2];
        tb_Data_3_In = f_Data_In[3];
        tb_Data_4_In = f_Data_In[4];
        tb_Data_5_In = f_Data_In[5];
        tb_Data_6_In = f_Data_In[6];
        tb_Data_7_In = f_Data_In[7];

        if (tb_Enable_In)
            begin
                tb_Low_Priority_Encoder_8_3();
            end
        else
            begin
                tb_Encoded_Value_Out = 3'bZ;
            end
        
        #20;
        
        Check_Actual_vs_Expected_Value(Encoded_Value_Out, tb_Encoded_Value_Out);

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                         , $time,
            "Enable_In = 0x%1b , "              , Enable_In,
            "{Data_7_In ... Data_0_In} = %8b , ", {Data_7_In, Data_6_In, Data_5_In, Data_4_In, Data_3_In, Data_2_In, Data_1_In, Data_0_In},
            "Encoded_Value_Out = 0x%1h , "      , Encoded_Value_Out,
            "tb_Encoded_Value_Out = 0x%1h , "   , tb_Encoded_Value_Out,
            "Is_Same = %1b"                     , Is_Same
        ));
    end
endtask

// Testbench Low_Priority_Encoder_8_3
task tb_Low_Priority_Encoder_8_3();
    begin
        casex ({tb_Data_0_In, tb_Data_1_In, tb_Data_2_In, tb_Data_3_In, tb_Data_4_In, tb_Data_5_In, tb_Data_6_In, tb_Data_7_In})
            8'b1xxxxxxx : begin tb_Encoded_Value_Out <= 3'd7; end
            8'b01xxxxxx : begin tb_Encoded_Value_Out <= 3'd6; end
            8'b001xxxxx : begin tb_Encoded_Value_Out <= 3'd5; end
            8'b0001xxxx : begin tb_Encoded_Value_Out <= 3'd4; end
            8'b00001xxx : begin tb_Encoded_Value_Out <= 3'd3; end
            8'b000001xx : begin tb_Encoded_Value_Out <= 3'd2; end
            8'b0000001x : begin tb_Encoded_Value_Out <= 3'd1; end
            8'b00000001 : begin tb_Encoded_Value_Out <= 3'd0; end
            default     : begin tb_Encoded_Value_Out <= 3'dZ; end
        endcase
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Low_Priority_Encoder_8_3_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Low_Priority_Encoder_8_3 - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        // Few Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Few Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_Low_Priority_Encoder_8_3(1'b0, $random());
        Check_Low_Priority_Encoder_8_3(1'b1, 0 << 0);
        Check_Low_Priority_Encoder_8_3(1'b1, 1 << 0);
        Check_Low_Priority_Encoder_8_3(1'b1, 1 << 1);
        Check_Low_Priority_Encoder_8_3(1'b1, 1 << 2);
        Check_Low_Priority_Encoder_8_3(1'b1, 1 << 3);
        Check_Low_Priority_Encoder_8_3(1'b1, 1 << 4);
        Check_Low_Priority_Encoder_8_3(1'b1, 1 << 5);
        Check_Low_Priority_Encoder_8_3(1'b1, 1 << 6);
        Check_Low_Priority_Encoder_8_3(1'b1, 1 << 7);
        
        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        repeat(20)
            begin
                Check_Low_Priority_Encoder_8_3($random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
