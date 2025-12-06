/*
--------------------------------------------------
Module :
--------------------------------------------------
Universal_Shift_Register_USR_4_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the 4-Bit Parallel-In-Parallel-Out (PIPO) Shift Register Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Universal_Shift_Register_USR_4_Bit_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg        Clk_In                       = 1'b0;
reg        Reset_In                     = 1'b0;
reg        Enable_In                    = 1'b0;

reg  [1:0] USR_Operation_Select_In      = 2'b0;

reg        Serial_Left_Side_Data_In     = 1'b0;
reg        Serial_Right_Side_Data_In    = 1'b0;

wire       Serial_Left_Side_Data_Out;
wire       Serial_Right_Side_Data_Out;

reg  [3:0] Parallel_Data_In             = 4'b0;
wire [3:0] Parallel_Data_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire [3:0] DUT_r_Shift_Register = DUT.r_Shift_Register;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic       tb_Reset_In                     = 1'b0;
logic       tb_Enable_In                    = 1'b0;

logic [1:0] tb_USR_Operation_Select_In      = 2'b0;

logic       tb_Serial_Left_Side_Data_In     = 1'b0;
logic       tb_Serial_Right_Side_Data_In    = 1'b0;

logic       tb_Serial_Left_Side_Data_Out    = 1'b0;
logic       tb_Serial_Right_Side_Data_Out   = 1'b0;

logic [3:0] tb_Parallel_Data_In             = 4'b0;
logic [3:0] tb_Parallel_Data_Out            = 4'b0;

logic [3:0] tb_r_Shift_Register             = 4'b0;



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
// Constants
// --------------------------------------------------
localparam [1:0]    tb_NO_OPERATIONS       = 2'h0,
                    tb_SHIFT_DATA_LEFT     = 2'h1,
                    tb_SHIFT_DATA_RIGHT    = 2'h2,
                    tb_LOAD_PARALLEL_DATA  = 2'h3;



// --------------------------------------------------
// Universal_Shift_Register_USR_4_Bit DUT Instantiation
// --------------------------------------------------
Universal_Shift_Register_USR_4_Bit DUT (
    .Clk_In                     (Clk_In),
    .Reset_In                   (Reset_In),
    .Enable_In                  (Enable_In),

    .USR_Operation_Select_In    (USR_Operation_Select_In),

    .Serial_Left_Side_Data_In   (Serial_Left_Side_Data_In),
    .Serial_Right_Side_Data_In  (Serial_Right_Side_Data_In),

    .Serial_Left_Side_Data_Out  (Serial_Left_Side_Data_Out),
    .Serial_Right_Side_Data_Out (Serial_Right_Side_Data_Out),

    .Parallel_Data_In           (Parallel_Data_In),
    .Parallel_Data_Out          (Parallel_Data_Out)
);



// --------------------------------------------------
// Universal_Shift_Register_USR_4_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Universal_Shift_Register_USR_4_Bit.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [5:0] f_Actual_Value, input logic [5:0] f_Expected_Value);
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
// Check the 4-Bit Parallel-In-Parallel-Out (PIPO) Shift Register
task Check_Universal_Shift_Register_USR_4_Bit(input logic f_Reset_In, input logic f_Enable_In, input logic [1:0] f_USR_Operation_Select_In, input logic f_Serial_Left_Side_Data_In, input logic f_Serial_Right_Side_Data_In, input logic [3:0] f_Parallel_Data_In);
    begin
        Reset_In                    = f_Reset_In;
        Enable_In                   = f_Enable_In;
        USR_Operation_Select_In     = f_USR_Operation_Select_In;
        Serial_Left_Side_Data_In    = f_Serial_Left_Side_Data_In;
        Serial_Right_Side_Data_In   = f_Serial_Right_Side_Data_In;
        Parallel_Data_In            = f_Parallel_Data_In;

        tb_Reset_In                     = f_Reset_In;
        tb_Enable_In                    = f_Enable_In;
        tb_USR_Operation_Select_In      = f_USR_Operation_Select_In;
        tb_Serial_Left_Side_Data_In     = f_Serial_Left_Side_Data_In;
        tb_Serial_Right_Side_Data_In    = f_Serial_Right_Side_Data_In;
        tb_Parallel_Data_In             = f_Parallel_Data_In;

        if (tb_Enable_In)
            begin
                case (tb_USR_Operation_Select_In)
                    tb_NO_OPERATIONS        : // 2'h0
                        begin
                            tb_r_Shift_Register = tb_r_Shift_Register;
                        end
                    tb_SHIFT_DATA_LEFT      : // 2'h1
                        begin
                            tb_r_Shift_Register = {tb_r_Shift_Register[2:0], tb_Serial_Right_Side_Data_In};
                        end
                    tb_SHIFT_DATA_RIGHT     : // 2'h2
                        begin
                            tb_r_Shift_Register = {tb_Serial_Left_Side_Data_In, tb_r_Shift_Register[3:1]};
                        end
                    tb_LOAD_PARALLEL_DATA   : // 2'h3
                        begin
                            tb_r_Shift_Register = tb_Parallel_Data_In;
                        end
                    default :
                        begin
                            tb_r_Shift_Register = tb_r_Shift_Register;
                        end
                endcase

                tb_Serial_Left_Side_Data_Out  = tb_r_Shift_Register[3];
                tb_Serial_Right_Side_Data_Out = tb_r_Shift_Register[0];
                tb_Parallel_Data_Out          = tb_r_Shift_Register;
            end
        else
            begin
                tb_Serial_Left_Side_Data_Out  = 1'bZ;
                tb_Serial_Right_Side_Data_Out = 1'bZ;
                tb_Parallel_Data_Out          = 4'bZ;
            end
        
        #20;
        
        Check_Actual_vs_Expected_Value({Serial_Left_Side_Data_Out, Serial_Right_Side_Data_Out, Parallel_Data_Out}, {tb_Serial_Left_Side_Data_Out, tb_Serial_Right_Side_Data_Out, tb_Parallel_Data_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                                 , $time,
            "Reset_In = %1b , "                         , Reset_In,
            "Enable_In = %1b , "                        , Enable_In,
            "USR_Operation_Select_In = 0x%1h , "        , USR_Operation_Select_In,
            "Serial_Left_Side_Data_In = %1b , "         , Serial_Left_Side_Data_In,
            "Serial_Right_Side_Data_In = %1b , "        , Serial_Right_Side_Data_In,
            "Parallel_Data_In = 0x%1h , "               , Parallel_Data_In,
            "Serial_Left_Side_Data_Out = %1b , "        , Serial_Left_Side_Data_Out,
            "Serial_Right_Side_Data_Out = %1b , "       , Serial_Right_Side_Data_Out,
            "Parallel_Data_Out = 0x%1h , "              , Parallel_Data_Out,
            "tb_Serial_Left_Side_Data_Out = %1b , "     , tb_Serial_Left_Side_Data_Out,
            "tb_Serial_Right_Side_Data_Out = %1b , "    , tb_Serial_Right_Side_Data_Out,
            "tb_Parallel_Data_Out = 0x%1h , "           , tb_Parallel_Data_Out,
            "Is_Same = %1b"                             , Is_Same
        ));
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Universal_Shift_Register_USR_4_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Universal_Shift_Register_USR_4_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Reset"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, 2'h0, $random(), $random(), $random());
        Check_Universal_Shift_Register_USR_4_Bit(1'b1, 1'b1, 2'h0, $random(), $random(), $random());
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, 2'h0, $random(), $random(), $random());
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b0, 2'h0, $random(), $random(), $random());
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, 2'h0, $random(), $random(), $random());

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("No Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_NO_OPERATIONS, $random(), $random(), $random());
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_NO_OPERATIONS, $random(), $random(), $random());
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_NO_OPERATIONS, $random(), $random(), $random());

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Load Parallel Data"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_NO_OPERATIONS, $random(), $random(), $random());
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_LOAD_PARALLEL_DATA, $random(), $random(), $random());
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_LOAD_PARALLEL_DATA, $random(), $random(), $random());
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_NO_OPERATIONS, $random(), $random(), $random());

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Shift Data Left"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_NO_OPERATIONS, $random(), $random(), $random());
        repeat (4)
            begin
                Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_SHIFT_DATA_LEFT, $random(), $random(), $random());
            end
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_NO_OPERATIONS, $random(), $random(), $random());

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Shift Data Right"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_NO_OPERATIONS, $random(), $random(), $random());
        repeat (4)
            begin
                Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_SHIFT_DATA_RIGHT, $random(), $random(), $random());
            end
        Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, tb_NO_OPERATIONS, $random(), $random(), $random());

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        repeat(20)
            begin
                Check_Universal_Shift_Register_USR_4_Bit(1'b0, 1'b1, $random(), $random(), $random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
