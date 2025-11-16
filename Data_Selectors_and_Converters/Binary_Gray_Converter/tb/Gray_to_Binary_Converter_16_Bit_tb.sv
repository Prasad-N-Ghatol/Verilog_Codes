/*
--------------------------------------------------
Module :
--------------------------------------------------
Gray_to_Binary_Converter_16_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 16-Bit Gray to Binary Converter Implementation.



--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Gray_to_Binary_Converter_16_Bit_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg         Enable_In      = 1'b0;

reg  [15:0] Gray_Data_In   = 16'b0;

wire [15:0] Binary_Data_Out;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic        tb_Enable_In        = 1'b0;

logic [15:0] tb_Gray_Data_In     = 16'b0;

logic [15:0] tb_Binary_Data_Out  = 16'b0;



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
// Gray_to_Binary_Converter_16_Bit DUT Instantiation
// --------------------------------------------------
Gray_to_Binary_Converter_16_Bit DUT (
    .Enable_In          (Enable_In),

    .Gray_Data_In       (Gray_Data_In),

    .Binary_Data_Out    (Binary_Data_Out)
);



// --------------------------------------------------
// Gray_to_Binary_Converter_16_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Gray_to_Binary_Converter_16_Bit.vcd");
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
// Check the 16-Bit Gray to Binary Converter
task Check_Gray_to_Binary_Converter_16_Bit(input logic f_Enable_In, input logic [15:0] f_Gray_Data_In);
    begin
        Enable_In       = f_Enable_In;
        Gray_Data_In    = f_Gray_Data_In;
        
        tb_Enable_In    = f_Enable_In;
        tb_Gray_Data_In = f_Gray_Data_In;
        
        if (tb_Enable_In)
            begin
                tb_Gray_to_Binary_Converter_16_Bit();
            end
        else
            begin
                tb_Binary_Data_Out = 16'bZ;
            end
        
        #20;
        
        Check_Actual_vs_Expected_Value(Binary_Data_Out, tb_Binary_Data_Out);

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                     , $time,
            "Enable_In = 0x%1b , "          , Enable_In,
            "Gray_Data_In = 0x%4h , "       , Gray_Data_In,
            "Binary_Data_Out = 0x%4h , "    , Binary_Data_Out,
            "tb_Binary_Data_Out = 0x%4h , " , tb_Binary_Data_Out,
            "Is_Same = %1b"                 , Is_Same
        ));
    end
endtask

// Testbench Gray_to_Binary_Converter_16_Bit
task tb_Gray_to_Binary_Converter_16_Bit();
    begin
        tb_Binary_Data_Out[15] = tb_Gray_Data_In[15];
        tb_Binary_Data_Out[14] = tb_Gray_Data_In[14] ^ tb_Binary_Data_Out[15];
        tb_Binary_Data_Out[13] = tb_Gray_Data_In[13] ^ tb_Binary_Data_Out[14];
        tb_Binary_Data_Out[12] = tb_Gray_Data_In[12] ^ tb_Binary_Data_Out[13];
        tb_Binary_Data_Out[11] = tb_Gray_Data_In[11] ^ tb_Binary_Data_Out[12];
        tb_Binary_Data_Out[10] = tb_Gray_Data_In[10] ^ tb_Binary_Data_Out[11];
        tb_Binary_Data_Out[9]  = tb_Gray_Data_In[9]  ^ tb_Binary_Data_Out[10];
        tb_Binary_Data_Out[8]  = tb_Gray_Data_In[8]  ^ tb_Binary_Data_Out[9];
        tb_Binary_Data_Out[7]  = tb_Gray_Data_In[7]  ^ tb_Binary_Data_Out[8];
        tb_Binary_Data_Out[6]  = tb_Gray_Data_In[6]  ^ tb_Binary_Data_Out[7];
        tb_Binary_Data_Out[5]  = tb_Gray_Data_In[5]  ^ tb_Binary_Data_Out[6];
        tb_Binary_Data_Out[4]  = tb_Gray_Data_In[4]  ^ tb_Binary_Data_Out[5];
        tb_Binary_Data_Out[3]  = tb_Gray_Data_In[3]  ^ tb_Binary_Data_Out[4];
        tb_Binary_Data_Out[2]  = tb_Gray_Data_In[2]  ^ tb_Binary_Data_Out[3];
        tb_Binary_Data_Out[1]  = tb_Gray_Data_In[1]  ^ tb_Binary_Data_Out[2];
        tb_Binary_Data_Out[0]  = tb_Gray_Data_In[0]  ^ tb_Binary_Data_Out[1];
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Gray_to_Binary_Converter_16_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Gray_to_Binary_Converter_16_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        // Few Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Few Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_Gray_to_Binary_Converter_16_Bit(1'b0, $random());
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 0);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 1);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 2);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 3);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 4);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 5);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 6);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 7);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 8);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 9);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 10);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 11);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 12);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 13);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 14);
        Check_Gray_to_Binary_Converter_16_Bit(1'b1, 1 << 15);
        
        #40;

        // Random Input Combinations
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Input Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        repeat(20)
            begin
                Check_Gray_to_Binary_Converter_16_Bit($random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
