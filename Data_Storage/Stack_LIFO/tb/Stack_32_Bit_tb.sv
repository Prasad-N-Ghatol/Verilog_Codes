/*
--------------------------------------------------
Module :
--------------------------------------------------
Stack_32_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 32-Bit Stack Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Stack_32_Bit_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg           Clk_In = 1'b0;
reg           Reset_In = 1'b0;
reg           Enable_In = 1'b0;

reg           Push_Data_Signal_In = 1'b0;
reg           Pop_Data_Signal_In = 1'b0;
reg           Peak_Data_Signal_In = 1'b0;

wire          Stack_Empty_Signal_Out;
wire          Stack_Full_Signal_Out;
wire          Stack_Overflow_Signal_Out;
wire          Stack_Underflow_Signal_Out;

wire [3:0]    SP_Value_Out;
reg  [31:0]   Stack_Write_Data_In = 32'b0;
wire [31:0]   Stack_Read_Data_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire [4:0]  DUT_r_SP                     = DUT.r_SP;
wire        DUT_r_Stack_Overflow_Signal  = DUT.r_Stack_Overflow_Signal;
wire        DUT_r_Stack_Underflow_Signal = DUT.r_Stack_Underflow_Signal;
wire [31:0] DUT_r_Stack_Read_Data        = DUT.r_Stack_Read_Data;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic          tb_Reset_In = 1'b0;
logic          tb_Enable_In = 1'b0;

logic          tb_Push_Data_Signal_In = 1'b0;
logic          tb_Pop_Data_Signal_In = 1'b0;
logic          tb_Peak_Data_Signal_In = 1'b0;

logic          tb_Stack_Empty_Signal_Out;
logic          tb_Stack_Full_Signal_Out;
logic          tb_Stack_Overflow_Signal_Out;
logic          tb_Stack_Underflow_Signal_Out;

logic [3:0]    tb_SP_Value_Out;
logic [31:0]   tb_Stack_Write_Data_In = 32'b0;
logic [31:0]   tb_Stack_Read_Data_Out;


logic [4:0] tb_r_SP = {1'b1, 4'hF};

logic        tb_w_Push_Data_Signal_In;
logic        tb_w_Pop_Data_Signal_In;
logic        tb_w_Peak_Data_Signal_In;

logic        tb_w_Stack_Empty_Signal;
logic        tb_w_Stack_Full_Signal;
logic        tb_r_Stack_Overflow_Signal  = 1'b0;
logic        tb_r_Stack_Underflow_Signal = 1'b0;

logic [3:0]  tb_w_SP_Value_Out;
logic [31:0] tb_w_Stack_Write_Data;
logic [31:0] tb_r_Stack_Read_Data = 32'b0;


logic [31:0] tb_SRAM_MEMORY [15:0];



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
// Stack_32_Bit DUT Instantiation
// --------------------------------------------------
Stack_32_Bit DUT (
    .Clk_In                         (Clk_In),
    .Reset_In                       (Reset_In),
    .Enable_In                      (Enable_In),

    .Push_Data_Signal_In            (Push_Data_Signal_In),
    .Pop_Data_Signal_In             (Pop_Data_Signal_In),
    .Peak_Data_Signal_In            (Peak_Data_Signal_In),

    .Stack_Empty_Signal_Out         (Stack_Empty_Signal_Out),
    .Stack_Full_Signal_Out          (Stack_Full_Signal_Out),
    .Stack_Overflow_Signal_Out      (Stack_Overflow_Signal_Out),
    .Stack_Underflow_Signal_Out     (Stack_Underflow_Signal_Out),

    .SP_Value_Out                   (SP_Value_Out),
    .Stack_Write_Data_In            (Stack_Write_Data_In),
    .Stack_Read_Data_Out            (Stack_Read_Data_Out)
);



// --------------------------------------------------
// Stack_32_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Stack_32_Bit.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [39:0] f_Actual_Value, input logic [39:0] f_Expected_Value);
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
// Check the 32-Bit Stack
task Check_Stack_32_Bit(input logic f_Reset_In, input logic f_Enable_In, input logic f_Push_Data_Signal_In, input logic f_Pop_Data_Signal_In, input logic f_Peak_Data_Signal_In, input logic [31:0] f_Stack_Write_Data_In);
    begin
        Reset_In            = f_Reset_In;
        Enable_In           = f_Enable_In;
        Push_Data_Signal_In = f_Push_Data_Signal_In;
        Pop_Data_Signal_In  = f_Pop_Data_Signal_In;
        Peak_Data_Signal_In = f_Peak_Data_Signal_In;
        Stack_Write_Data_In = f_Stack_Write_Data_In;

        tb_Reset_In            = f_Reset_In;
        tb_Enable_In           = f_Enable_In;
        tb_Push_Data_Signal_In = f_Push_Data_Signal_In;
        tb_Pop_Data_Signal_In  = f_Pop_Data_Signal_In;
        tb_Peak_Data_Signal_In = f_Peak_Data_Signal_In;
        tb_Stack_Write_Data_In = f_Stack_Write_Data_In;

        #20;

        Check_Actual_vs_Expected_Value({Stack_Empty_Signal_Out, Stack_Full_Signal_Out, Stack_Overflow_Signal_Out, Stack_Underflow_Signal_Out, SP_Value_Out, Stack_Read_Data_Out}, {tb_Stack_Empty_Signal_Out, tb_Stack_Full_Signal_Out, tb_Stack_Overflow_Signal_Out, tb_Stack_Underflow_Signal_Out, tb_SP_Value_Out, tb_Stack_Read_Data_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                                 , $time,
            "Reset_In = 0x%1b , "                       , Reset_In,
            "Enable_In = 0x%1b , "                      , Enable_In,
            "Push_Data_Signal_In = 0x%1b , "            , Push_Data_Signal_In,
            "Pop_Data_Signal_In = 0x%1b , "             , Pop_Data_Signal_In,
            "Peak_Data_Signal_In = 0x%1b , "            , Peak_Data_Signal_In,
            "Stack_Empty_Signal_Out = 0x%1b , "         , Stack_Empty_Signal_Out,
            "Stack_Full_Signal_Out = 0x%1b , "          , Stack_Full_Signal_Out,
            "Stack_Overflow_Signal_Out = 0x%1b , "      , Stack_Overflow_Signal_Out,
            "Stack_Underflow_Signal_Out = 0x%1b , "     , Stack_Underflow_Signal_Out,
            "SP_Value_Out = 0x%1h , "                   , SP_Value_Out,
            "Stack_Write_Data_In = 0x%8h , "            , Stack_Write_Data_In,
            "Stack_Read_Data_Out = 0x%8h , "            , Stack_Read_Data_Out,
            "tb_Stack_Empty_Signal_Out = 0x%1b , "      , tb_Stack_Empty_Signal_Out,
            "tb_Stack_Full_Signal_Out = 0x%1b , "       , tb_Stack_Full_Signal_Out,
            "tb_Stack_Overflow_Signal_Out = 0x%1b , "   , tb_Stack_Overflow_Signal_Out,
            "tb_Stack_Underflow_Signal_Out = 0x%1b , "  , tb_Stack_Underflow_Signal_Out,
            "tb_SP_Value_Out = 0x%1h , "                , tb_SP_Value_Out,
            "tb_Stack_Read_Data_Out = 0x%8h , "         , tb_Stack_Read_Data_Out,
            "Is_Same = %1b"                             , Is_Same
        ));
    end
endtask


// Perform 32-Bit Stack Operations
always @ (posedge Clk_In or posedge tb_Reset_In)
    begin
        if (tb_Reset_In)
            begin
                tb_r_SP                     = {1'b1, 4'hF};
                tb_r_Stack_Overflow_Signal  = 1'b0;
                tb_r_Stack_Underflow_Signal = 1'b0;
                tb_r_Stack_Read_Data        = 32'b0;
            end
        else if (tb_w_Push_Data_Signal_In)
            begin
                if (tb_w_Stack_Full_Signal)
                    begin
                        tb_r_SP                    = tb_r_SP;
                        tb_r_Stack_Overflow_Signal = 1'b1;
                    end
                else
                    begin
                        tb_SRAM_MEMORY[tb_r_SP[3:0]]  = tb_w_Stack_Write_Data;
                        tb_r_SP                       = tb_r_SP - 1'b1;
                        tb_r_Stack_Overflow_Signal    = 1'b0;
                    end
            end
        else if (tb_w_Pop_Data_Signal_In)
            begin
                if (tb_w_Stack_Empty_Signal)
                    begin
                        tb_r_Stack_Read_Data        = 32'b0;
                        tb_r_SP                     = tb_r_SP;
                        tb_r_Stack_Underflow_Signal = 1'b1;
                    end
                else
                    begin
                        tb_r_Stack_Read_Data        = tb_SRAM_MEMORY[tb_r_SP[3:0] + 1'b1];
                        tb_r_SP                     = tb_r_SP + 1'b1;
                        tb_r_Stack_Underflow_Signal = 1'b0;
                    end
            end
        else if (tb_w_Peak_Data_Signal_In)
            begin
                if (tb_w_Stack_Empty_Signal)
                    begin
                        tb_r_Stack_Read_Data        = 32'b0;
                        tb_r_SP                     = tb_r_SP;
                        tb_r_Stack_Underflow_Signal = 1'b1;
                    end
                else
                    begin
                        tb_r_Stack_Read_Data        = tb_SRAM_MEMORY[tb_r_SP[3:0] + 1'b1];
                        tb_r_SP                     = tb_r_SP;
                        tb_r_Stack_Underflow_Signal = 1'b0;
                    end
            end
        else
            begin
                tb_r_SP                     = tb_r_SP;
                tb_r_Stack_Overflow_Signal  = 1'b0;
                tb_r_Stack_Underflow_Signal = 1'b0;
                tb_r_Stack_Read_Data        = tb_r_Stack_Read_Data;
            end
    end

assign tb_w_Push_Data_Signal_In        = tb_Enable_In ? tb_Push_Data_Signal_In       : 1'b0;
assign tb_w_Pop_Data_Signal_In         = tb_Enable_In ? tb_Pop_Data_Signal_In        : 1'b0;
assign tb_w_Peak_Data_Signal_In        = tb_Enable_In ? tb_Peak_Data_Signal_In       : 1'b0;

assign tb_Stack_Empty_Signal_Out       = tb_Enable_In ? tb_w_Stack_Empty_Signal      : 1'bZ;
assign tb_Stack_Full_Signal_Out        = tb_Enable_In ? tb_w_Stack_Full_Signal       : 1'bZ;
assign tb_Stack_Overflow_Signal_Out    = tb_Enable_In ? tb_r_Stack_Overflow_Signal   : 1'bZ;
assign tb_Stack_Underflow_Signal_Out   = tb_Enable_In ? tb_r_Stack_Underflow_Signal  : 1'bZ;

assign tb_w_Stack_Empty_Signal         = (tb_r_SP == {1'b1, 4'hF}) ? 1'b1 : 1'b0;
assign tb_w_Stack_Full_Signal          = (tb_r_SP == {1'b0, 4'hF}) ? 1'b1 : 1'b0;

assign tb_SP_Value_Out                 = tb_Enable_In ? tb_w_SP_Value_Out            : 4'bZ;
assign tb_w_Stack_Write_Data           = tb_Enable_In ? tb_Stack_Write_Data_In       : 32'b0;
assign tb_Stack_Read_Data_Out          = tb_Enable_In ? tb_r_Stack_Read_Data         : 32'bZ;
assign tb_w_SP_Value_Out               = tb_r_SP[3:0];

// Dump out thw Contents of the DUT and tb Memories
task Dump_Memory_Contents();
    begin
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------"));
        Write_To_File_And_Display($sformatf("[%16t] : Dump_Memory_Contents - DUT.SRAM_MEMORY and tb_SRAM_MEMORY ", $time));
        Write_To_File_And_Display($sformatf("--------------------------------------------------"));
        
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x0] = 0x%8h , tb_SRAM_MEMORY[0x0] = 0x%8h", DUT.SRAM_MEMORY[00], tb_SRAM_MEMORY[00]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x1] = 0x%8h , tb_SRAM_MEMORY[0x1] = 0x%8h", DUT.SRAM_MEMORY[01], tb_SRAM_MEMORY[01]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x2] = 0x%8h , tb_SRAM_MEMORY[0x2] = 0x%8h", DUT.SRAM_MEMORY[02], tb_SRAM_MEMORY[02]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x3] = 0x%8h , tb_SRAM_MEMORY[0x3] = 0x%8h", DUT.SRAM_MEMORY[03], tb_SRAM_MEMORY[03]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x4] = 0x%8h , tb_SRAM_MEMORY[0x4] = 0x%8h", DUT.SRAM_MEMORY[04], tb_SRAM_MEMORY[04]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x5] = 0x%8h , tb_SRAM_MEMORY[0x5] = 0x%8h", DUT.SRAM_MEMORY[05], tb_SRAM_MEMORY[05]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x6] = 0x%8h , tb_SRAM_MEMORY[0x6] = 0x%8h", DUT.SRAM_MEMORY[06], tb_SRAM_MEMORY[06]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x7] = 0x%8h , tb_SRAM_MEMORY[0x7] = 0x%8h", DUT.SRAM_MEMORY[07], tb_SRAM_MEMORY[07]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x8] = 0x%8h , tb_SRAM_MEMORY[0x8] = 0x%8h", DUT.SRAM_MEMORY[08], tb_SRAM_MEMORY[08]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0x9] = 0x%8h , tb_SRAM_MEMORY[0x9] = 0x%8h", DUT.SRAM_MEMORY[09], tb_SRAM_MEMORY[09]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xA] = 0x%8h , tb_SRAM_MEMORY[0xA] = 0x%8h", DUT.SRAM_MEMORY[10], tb_SRAM_MEMORY[10]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xB] = 0x%8h , tb_SRAM_MEMORY[0xB] = 0x%8h", DUT.SRAM_MEMORY[11], tb_SRAM_MEMORY[11]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xC] = 0x%8h , tb_SRAM_MEMORY[0xC] = 0x%8h", DUT.SRAM_MEMORY[12], tb_SRAM_MEMORY[12]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xD] = 0x%8h , tb_SRAM_MEMORY[0xD] = 0x%8h", DUT.SRAM_MEMORY[13], tb_SRAM_MEMORY[13]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xE] = 0x%8h , tb_SRAM_MEMORY[0xE] = 0x%8h", DUT.SRAM_MEMORY[14], tb_SRAM_MEMORY[14]));
        Write_To_File_And_Display($sformatf("DUT.SRAM_MEMORY[0xF] = 0x%8h , tb_SRAM_MEMORY[0xF] = 0x%8h", DUT.SRAM_MEMORY[15], tb_SRAM_MEMORY[15]));
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Stack_32_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Stack_32_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Reset and Enable"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 32'h0);
        Check_Stack_32_Bit(1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 32'h0);
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 32'h0);
        Check_Stack_32_Bit(1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 32'h0);
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 32'h0);
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("After Reset and Enable"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Push Operations - With Overflow"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Till Stack Full"));
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Write_To_File_And_Display($sformatf("Stack Over-Full"));
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, $random());

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("After Push Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Peak Operation"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b1, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, $random());

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("After Peak Operation"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Pop Operations - With Underflow"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Till Stack Empty"));
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Write_To_File_And_Display($sformatf("Stack Over-Full"));
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, $random());

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("After Pop Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Some Operations and Reset"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b1, 1'b1, 1'b0, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b1, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b1, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b1, 1'b1, 1'b0, 1'b0, 1'b0, $random());
        Check_Stack_32_Bit(1'b0, 1'b1, 1'b0, 1'b0, 1'b0, $random());
        
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("After Some Operations and Reset"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        repeat (20)
            begin
                Check_Stack_32_Bit(1'b0, 1'b1, $random(), $random(), $random(), $random());
            end
        
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("After Random Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Dump_Memory_Contents();
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
