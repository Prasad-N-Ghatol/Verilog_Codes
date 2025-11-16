/*
--------------------------------------------------
Module :
--------------------------------------------------
T_Flip_Flop_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the T Flip Flop Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module T_Flip_Flop_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg  Clk_In     = 1'b0;
reg  Reset_In   = 1'b0;

reg  T_In       = 1'b0;
wire Q_Out;
wire Qb_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire DUT_T_FF_Q = DUT.T_FF_Q;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic tb_Reset_In  = 1'b0;

logic tb_T_In      = 1'b0;
logic tb_Q_Out;
logic tb_Qb_Out;

logic tb_T_FF_Q    = 1'b0;



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
// T_Flip_Flop DUT Instantiation
// --------------------------------------------------
T_Flip_Flop DUT (
    .Clk_In     (Clk_In),
    .Reset_In   (Reset_In),

    .T_In       (T_In),
    .Q_Out      (Q_Out),
    .Qb_Out     (Qb_Out)
);



// --------------------------------------------------
// T_Flip_Flop VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/T_Flip_Flop.vcd");
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
// Check the T_Flip_Flop
task Check_T_Flip_Flop(input logic f_Reset_In, input logic f_T_In);
    begin
        Reset_In    = f_Reset_In;
        T_In        = f_T_In;
        
        tb_Reset_In = f_Reset_In;
        tb_T_In     = f_T_In;

        Perform_T_Flip_Flop_Operation();

        #20;

        Check_Actual_vs_Expected_Value({Q_Out, Qb_Out}, {tb_Q_Out, tb_Qb_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "             , $time,
            "Reset_In = 0x%1b , "   , Reset_In,
            "T_In = 0x%1b , "       , T_In,
            "Q_Out = 0x%1b , "      , Q_Out,
            "Qb_Out = 0x%1b , "     , Qb_Out,
            "tb_Q_Out = 0x%1b , "   , tb_Q_Out,
            "tb_Qb_Out = 0x%1b , "  , tb_Qb_Out,
            "Is_Same = %1b"         , Is_Same
        ));
    end
endtask

// Perform T_Flip_Flop Operations
task Perform_T_Flip_Flop_Operation();
    begin
        if (tb_Reset_In)
            begin
                tb_T_FF_Q <= 1'b0;
            end
        else if (tb_T_In)
            begin
                tb_T_FF_Q <= ~tb_T_FF_Q;
            end
        else
            begin
                tb_T_FF_Q <= tb_T_FF_Q;
            end
    end
endtask

assign tb_Q_Out  = tb_T_FF_Q;
assign tb_Qb_Out = ~tb_T_FF_Q;



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/T_Flip_Flop_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("T_Flip_Flop - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("All Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("Reset"));
        Check_T_Flip_Flop(1'b1, 1'b0);
        Check_T_Flip_Flop(1'b0, 1'b0);
        Write_To_File_And_Display($sformatf("Toggle"));
        Check_T_Flip_Flop(1'b0, 1'b1);
        Check_T_Flip_Flop(1'b0, 1'b0);
        Check_T_Flip_Flop(1'b0, 1'b1);
        Check_T_Flip_Flop(1'b0, 1'b1);
        Check_T_Flip_Flop(1'b0, 1'b1);
        Check_T_Flip_Flop(1'b0, 1'b0);

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        repeat(10)
            begin
                Check_T_Flip_Flop(1'b0, $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
