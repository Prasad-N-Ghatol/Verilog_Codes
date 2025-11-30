/*
--------------------------------------------------
Module :
--------------------------------------------------
SRAM_Single_Port_16_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 16-Bit Single Port SRAM Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module SRAM_Single_Port_16_Bit_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg           Clk_In                    = 1'b0;
reg           Enable_In                 = 1'b0;

reg           Port_1_Write_Enable_In    = 1'b0;
reg           Port_1_Read_Enable_In     = 1'b0;
reg  [3:0]    Port_1_Address_In         = 4'b0;
reg  [15:0]   Port_1_Write_Data_In      = 16'b0;
wire [15:0]   Port_1_Read_Data_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire [15:0] DUT_r_Port_1_Read_Data = DUT.r_Port_1_Read_Data;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic        tb_Enable_In                = 1'b0;

logic        tb_Port_1_Write_Enable_In   = 1'b0;
logic        tb_Port_1_Read_Enable_In    = 1'b0;
logic [3:0]  tb_Port_1_Address_In        = 4'b0;
logic [15:0] tb_Port_1_Write_Data_In     = 16'b0;
logic [15:0] tb_Port_1_Read_Data_Out;

logic [15:0] tb_Port_1_Read_Data         = 16'b0;

logic [15:0] tb_SRAM_MEMORY [15:0];



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
// SRAM_Single_Port_16_Bit DUT Instantiation
// --------------------------------------------------
SRAM_Single_Port_16_Bit DUT (
    .Clk_In                 (Clk_In),
    .Enable_In              (Enable_In),

    .Port_1_Write_Enable_In (Port_1_Write_Enable_In),
    .Port_1_Read_Enable_In  (Port_1_Read_Enable_In),
    .Port_1_Address_In      (Port_1_Address_In),
    .Port_1_Write_Data_In   (Port_1_Write_Data_In),
    .Port_1_Read_Data_Out   (Port_1_Read_Data_Out)
);



// --------------------------------------------------
// SRAM_Single_Port_16_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/SRAM_Single_Port_16_Bit.vcd");
        $dumpvars;
    end



// --------------------------------------------------
// Time and Clock Initialization
// --------------------------------------------------
initial
    begin
        $timeformat(-9, 3, " ns", 16);
    end

initial
    begin
        Clk_In = 1'b0;

        forever
            begin
                #10;
                Clk_In = ~Clk_In;
            end
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
// Check the 16-Bit Single Port SRAM
task Check_SRAM_Single_Port_16_Bit(input logic f_Enable_In, input logic f_Port_1_Write_Enable_In, input logic f_Port_1_Read_Enable_In, input logic [15:0] f_Port_1_Address_In, input logic [15:0] f_Port_1_Write_Data_In);
    begin
        Enable_In               = f_Enable_In;
        Port_1_Write_Enable_In  = f_Port_1_Write_Enable_In;
        Port_1_Read_Enable_In   = f_Port_1_Read_Enable_In;
        Port_1_Address_In       = f_Port_1_Address_In;
        Port_1_Write_Data_In    = f_Port_1_Write_Data_In;

        tb_Enable_In                = f_Enable_In;
        tb_Port_1_Write_Enable_In   = f_Port_1_Write_Enable_In;
        tb_Port_1_Read_Enable_In    = f_Port_1_Read_Enable_In;
        tb_Port_1_Address_In        = f_Port_1_Address_In;
        tb_Port_1_Write_Data_In     = f_Port_1_Write_Data_In;

        Perform_SRAM_Single_Port_16_Bit_Operation();

        #20;

        Check_Actual_vs_Expected_Value(Port_1_Read_Data_Out, tb_Port_1_Read_Data_Out);

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                             , $time,
            "Enable_In = 0x%1b , "                  , Enable_In,
            "Port_1_Write_Enable_In = 0x%1b , "     , Port_1_Write_Enable_In,
            "Port_1_Read_Enable_In = 0x%1b , "      , Port_1_Read_Enable_In,
            "Port_1_Address_In = 0x%1h , "          , Port_1_Address_In,
            "Port_1_Write_Data_In = 0x%4h , "       , Port_1_Write_Data_In,
            "Port_1_Read_Data_Out = 0x%4h , "       , Port_1_Read_Data_Out,
            "tb_Port_1_Read_Data_Out = 0x%4h , "    , tb_Port_1_Read_Data_Out,
            "Is_Same = %1b"                         , Is_Same
        ));
    end
endtask

// Perform 16-Bit Single Port SRAM Operations
task Perform_SRAM_Single_Port_16_Bit_Operation();
    begin
        if (Enable_In && tb_Port_1_Read_Enable_In)
            begin
                tb_Port_1_Read_Data <= tb_SRAM_MEMORY[tb_Port_1_Address_In];
            end
        else if (Enable_In && tb_Port_1_Write_Enable_In)
            begin
                tb_SRAM_MEMORY[tb_Port_1_Address_In] <= tb_Port_1_Write_Data_In;
            end
    end
endtask

assign tb_Port_1_Read_Data_Out = (tb_Enable_In && tb_Port_1_Read_Enable_In) ? tb_Port_1_Read_Data : 16'bZ;


// Dump out thw Contents of the DUT and tb Memories
task Dump_Memory_Contents();
    begin
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------"));
        Write_To_File_And_Display($sformatf("[%16t] : Dump_Memory_Contents - DUT.SRAM_MEMORY and tb_SRAM_MEMORY ", $time));
        Write_To_File_And_Display($sformatf("--------------------------------------------------"));
        
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x0] = 0x%4h , tb_SRAM_MEMORY[0x0] = 0x%4h", DUT.SRAM_MEMORY[00], tb_SRAM_MEMORY[00]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x1] = 0x%4h , tb_SRAM_MEMORY[0x1] = 0x%4h", DUT.SRAM_MEMORY[01], tb_SRAM_MEMORY[01]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x2] = 0x%4h , tb_SRAM_MEMORY[0x2] = 0x%4h", DUT.SRAM_MEMORY[02], tb_SRAM_MEMORY[02]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x3] = 0x%4h , tb_SRAM_MEMORY[0x3] = 0x%4h", DUT.SRAM_MEMORY[03], tb_SRAM_MEMORY[03]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x4] = 0x%4h , tb_SRAM_MEMORY[0x4] = 0x%4h", DUT.SRAM_MEMORY[04], tb_SRAM_MEMORY[04]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x5] = 0x%4h , tb_SRAM_MEMORY[0x5] = 0x%4h", DUT.SRAM_MEMORY[05], tb_SRAM_MEMORY[05]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x6] = 0x%4h , tb_SRAM_MEMORY[0x6] = 0x%4h", DUT.SRAM_MEMORY[06], tb_SRAM_MEMORY[06]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x7] = 0x%4h , tb_SRAM_MEMORY[0x7] = 0x%4h", DUT.SRAM_MEMORY[07], tb_SRAM_MEMORY[07]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x8] = 0x%4h , tb_SRAM_MEMORY[0x8] = 0x%4h", DUT.SRAM_MEMORY[08], tb_SRAM_MEMORY[08]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x9] = 0x%4h , tb_SRAM_MEMORY[0x9] = 0x%4h", DUT.SRAM_MEMORY[09], tb_SRAM_MEMORY[09]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xA] = 0x%4h , tb_SRAM_MEMORY[0xA] = 0x%4h", DUT.SRAM_MEMORY[10], tb_SRAM_MEMORY[10]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xB] = 0x%4h , tb_SRAM_MEMORY[0xB] = 0x%4h", DUT.SRAM_MEMORY[11], tb_SRAM_MEMORY[11]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xC] = 0x%4h , tb_SRAM_MEMORY[0xC] = 0x%4h", DUT.SRAM_MEMORY[12], tb_SRAM_MEMORY[12]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xD] = 0x%4h , tb_SRAM_MEMORY[0xD] = 0x%4h", DUT.SRAM_MEMORY[13], tb_SRAM_MEMORY[13]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xE] = 0x%4h , tb_SRAM_MEMORY[0xE] = 0x%4h", DUT.SRAM_MEMORY[14], tb_SRAM_MEMORY[14]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xF] = 0x%4h , tb_SRAM_MEMORY[0xF] = 0x%4h", DUT.SRAM_MEMORY[15], tb_SRAM_MEMORY[15]));
    end
endtask


// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/SRAM_Single_Port_16_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("SRAM_Single_Port_16_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Default State"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b0, 4'h0, $random());
        Check_SRAM_Single_Port_16_Bit(1'b0, 1'b0, 1'b0, 4'h0, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b0, 4'h0, $random());
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Write Data Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'h0, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'h1, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'h2, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'h3, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'h4, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'h5, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'h6, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'h7, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'h8, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'h9, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'hA, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'hB, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'hC, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'hD, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'hE, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'hF, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b0, 4'h0, $random());

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("After Data Write State"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Read Data Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h0, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h1, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h2, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h3, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h4, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h5, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h6, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h7, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h8, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h9, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'hA, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'hB, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'hC, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'hD, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'hE, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'hF, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b0, 4'hF, $random());

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("After Data Read State"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Enable/Read/Write - On/Off Data Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Enable On - No Operation"));
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b0, 4'h2, $random());
        Write_To_File_And_Display($sformatf("Enable Off - No Operation"));
        Check_SRAM_Single_Port_16_Bit(1'b0, 1'b0, 1'b0, 4'h2, $random());
        Write_To_File_And_Display($sformatf("Enable Off - Write"));
        Check_SRAM_Single_Port_16_Bit(1'b0, 1'b1, 1'b0, 4'h2, $random());
        Check_SRAM_Single_Port_16_Bit(1'b0, 1'b0, 1'b0, 4'h2, $random());
        Write_To_File_And_Display($sformatf("Enable Off - Read"));
        Check_SRAM_Single_Port_16_Bit(1'b0, 1'b0, 1'b1, 4'h2, $random());
        Check_SRAM_Single_Port_16_Bit(1'b0, 1'b0, 1'b1, 4'h2, $random());
        Write_To_File_And_Display($sformatf("Enable On - No Operation"));
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b0, 4'h2, $random());
        Write_To_File_And_Display($sformatf("Enable On - Read"));
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h2, $random());
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b0, 4'h2, $random());
        Write_To_File_And_Display($sformatf("Enable On - Write and Read Simultaneously"));
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b0, 4'h3, 16'h5);
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b1, 4'h3, 16'h6);
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b0, 4'h3, 16'h7);
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b1, 1'b1, 4'h3, 16'h8);
        Check_SRAM_Single_Port_16_Bit(1'b1, 1'b0, 1'b0, 4'h3, 16'h9);

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("After Enable/Read/Write - On/Off Data Operations State"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        repeat (20)
            begin
                Check_SRAM_Single_Port_16_Bit(1'b1, $random(), $random(), $random(), $random());
            end
        
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("After Random Operations Complete State"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
