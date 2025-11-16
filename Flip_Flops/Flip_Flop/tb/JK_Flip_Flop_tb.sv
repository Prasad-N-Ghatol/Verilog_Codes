/*
--------------------------------------------------
Module :
--------------------------------------------------
JK_Flip_Flop_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the JK Flip Flop Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module JK_Flip_Flop_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg  Clk_In     = 1'b0;
reg  Reset_In   = 1'b0;

reg  J_In       = 1'b0;
reg  K_In       = 1'b0;
wire Q_Out;
wire Qb_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire DUT_JK_FF_Q = DUT.JK_FF_Q;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic tb_Reset_In  = 1'b0;

logic tb_J_In      = 1'b0;
logic tb_K_In      = 1'b0;
logic tb_Q_Out;
logic tb_Qb_Out;

logic tb_JK_FF_Q    = 1'b0;



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
// JK_Flip_Flop DUT Instantiation
// --------------------------------------------------
JK_Flip_Flop DUT (
    .Clk_In     (Clk_In),
    .Reset_In   (Reset_In),

    .J_In       (J_In),
    .K_In       (K_In),
    .Q_Out      (Q_Out),
    .Qb_Out     (Qb_Out)
);



// --------------------------------------------------
// JK_Flip_Flop VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/JK_Flip_Flop.vcd");
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
// Check the JK_Flip_Flop
task Check_JK_Flip_Flop(input logic f_Reset_In, input logic f_J_In, input logic f_K_In);
    begin
        Reset_In    = f_Reset_In;
        J_In        = f_J_In;
        K_In        = f_K_In;
        
        tb_Reset_In = f_Reset_In;
        tb_J_In     = f_J_In;
        tb_K_In     = f_K_In;

        Perform_JK_Flip_Flop_Operation();

        #20;

        Check_Actual_vs_Expected_Value({Q_Out, Qb_Out}, {tb_Q_Out, tb_Qb_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "             , $time,
            "Reset_In = 0x%1b , "   , Reset_In,
            "J_In = 0x%1b , "       , J_In,
            "K_In = 0x%1b , "       , K_In,
            "Q_Out = 0x%1b , "      , Q_Out,
            "Qb_Out = 0x%1b , "     , Qb_Out,
            "tb_Q_Out = 0x%1b , "   , tb_Q_Out,
            "tb_Qb_Out = 0x%1b , "  , tb_Qb_Out,
            "Is_Same = %1b"         , Is_Same
        ));
    end
endtask

// Perform JK_Flip_Flop Operations
task Perform_JK_Flip_Flop_Operation();
    begin
        if (tb_Reset_In)
            begin
                tb_JK_FF_Q <= 1'b0;
            end
        else
            begin
                case ({tb_J_In, tb_K_In})
                    2'b00   : begin tb_JK_FF_Q <= tb_JK_FF_Q;  end
                    2'b01   : begin tb_JK_FF_Q <= 1'b0;        end
                    2'b10   : begin tb_JK_FF_Q <= 1'b1;        end
                    2'b11   : begin tb_JK_FF_Q <= ~tb_JK_FF_Q; end
                    default : begin tb_JK_FF_Q <= 1'b0;        end
                endcase
            end
    end
endtask

assign tb_Q_Out  = tb_JK_FF_Q;
assign tb_Qb_Out = ~tb_JK_FF_Q;



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/JK_Flip_Flop_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("JK_Flip_Flop - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("All Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("Reset"));
        Check_JK_Flip_Flop(1'b1, 1'b0, 1'b0);
        Check_JK_Flip_Flop(1'b0, 1'b0, 1'b0);
        Write_To_File_And_Display($sformatf("Set"));
        Check_JK_Flip_Flop(1'b0, 1'b1, 1'b0);
        Check_JK_Flip_Flop(1'b0, 1'b0, 1'b0);
        Write_To_File_And_Display($sformatf("Reset"));
        Check_JK_Flip_Flop(1'b0, 1'b0, 1'b1);
        Check_JK_Flip_Flop(1'b0, 1'b0, 1'b0);
        Write_To_File_And_Display($sformatf("Toggle Condition"));
        Check_JK_Flip_Flop(1'b0, 1'b1, 1'b1);
        Check_JK_Flip_Flop(1'b0, 1'b0, 1'b0);

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        repeat(10)
            begin
                Check_JK_Flip_Flop(1'b0, $random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
