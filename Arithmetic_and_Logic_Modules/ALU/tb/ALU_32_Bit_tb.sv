/*
--------------------------------------------------
Module :
--------------------------------------------------
ALU_32_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the ALU 32-Bit Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module ALU_32_Bit_tb ();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg         Enable_In                = 1'b0;

reg  [3:0]  ALU_Operation_Select_In  = 4'b0;

reg  [31:0] Data_A_In                = 32'b0;
reg  [31:0] Data_B_In                = 32'b0;

wire [31:0] Result_Out;
wire        Carry_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire [32:0] DUT_ALU_Results = DUT.ALU_Results;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic        tb_Enable_In                = 1'b0;

logic [3:0]  tb_ALU_Operation_Select_In  = 4'b0;

logic [31:0] tb_Data_A_In                = 32'b0;
logic [31:0] tb_Data_B_In                = 32'b0;

logic [31:0] tb_Result_Out               = 32'b0;
logic        tb_Carry_Out                = 1'b0;



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
// ALU_32_Bit DUT Instantiation
// --------------------------------------------------
ALU_32_Bit DUT (
    .Enable_In                  (Enable_In),

    .ALU_Operation_Select_In    (ALU_Operation_Select_In),

    .Data_A_In                  (Data_A_In),
    .Data_B_In                  (Data_B_In),

    .Result_Out                 (Result_Out),
    .Carry_Out                  (Carry_Out)
);



// --------------------------------------------------
// ALU_32_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/ALU_32_Bit.vcd");
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
task Check_Actual_vs_Expected_Value (input logic [32:0] f_Actual_Value, input logic [32:0] f_Expected_Value);
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
// Check the ALU
task Check_ALU (input logic f_Enable_In, input logic [31:0] f_Data_A_In, input logic [31:0] f_Data_B_In, input logic [3:0] f_ALU_Operation_Select_In);
    begin
        Enable_In               = f_Enable_In;
        Data_A_In               = f_Data_A_In;
        Data_B_In               = f_Data_B_In;
        ALU_Operation_Select_In = f_ALU_Operation_Select_In;
        
        tb_Enable_In                = f_Enable_In;
        tb_Data_A_In                = f_Data_A_In;
        tb_Data_B_In                = f_Data_B_In;
        tb_ALU_Operation_Select_In  = f_ALU_Operation_Select_In;

        if (tb_Enable_In)
            begin
                Perform_ALU_Operation();
            end
        else
            begin
                tb_Result_Out = 32'bZ;
                tb_Carry_Out  = 1'bZ;
            end

        #20;

        Check_Actual_vs_Expected_Value({Carry_Out, Result_Out}, {tb_Carry_Out, tb_Result_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                         , $time,
            "Enable_In = 0x%1b , "              , Enable_In,
            "Data_A_In = 0x%8h , "              , Data_A_In,
            "Data_B_In = 0x%8h , "              , Data_B_In,
            "ALU_Operation_Select_In = 0x%1h , ", ALU_Operation_Select_In,
            "Carry_Out = 0x%1b , "              , Carry_Out,
            "Result_Out = 0x%8h , "             , Result_Out,
            "tb_Carry_Out = 0x%1b , "           , tb_Carry_Out,
            "tb_Result_Out = 0x%8h , "          , tb_Result_Out,
            "Is_Same = %1b"                     , Is_Same
        ));
    end
endtask

// Perform ALU Operations
task Perform_ALU_Operation();
    begin
        case (tb_ALU_Operation_Select_In)
            // Arithmetic Operations
            4'h0    : begin {tb_Carry_Out, tb_Result_Out} = tb_Data_A_In + 1'b1;                end // A + 1
            4'h1    : begin {tb_Carry_Out, tb_Result_Out} = tb_Data_A_In - 1'b1;                end // A - 1
            4'h2    : begin {tb_Carry_Out, tb_Result_Out} = tb_Data_A_In + tb_Data_B_In;        end // A + B
            4'h3    : begin {tb_Carry_Out, tb_Result_Out} = tb_Data_A_In - tb_Data_B_In;        end // A - B
            4'h4    : begin {tb_Carry_Out, tb_Result_Out} = tb_Data_B_In - tb_Data_A_In;        end // B - A
            4'h5    : begin {tb_Carry_Out, tb_Result_Out} = tb_Data_A_In * tb_Data_B_In;        end // A * B
            4'h6    : begin {tb_Carry_Out, tb_Result_Out} = tb_Data_A_In / tb_Data_B_In;        end // A / B
            4'h7    : begin {tb_Carry_Out, tb_Result_Out} = tb_Data_A_In % tb_Data_B_In;        end // A % B

            // Logical Operations
            4'h8    : begin {tb_Carry_Out, tb_Result_Out} = tb_Data_A_In & tb_Data_B_In;        end // A AND B
            4'h9    : begin {tb_Carry_Out, tb_Result_Out} = tb_Data_A_In | tb_Data_B_In;        end // A OR B
            4'hA    : begin {tb_Carry_Out, tb_Result_Out} = ~tb_Data_A_In;                      end // NOT A
            4'hB    : begin {tb_Carry_Out, tb_Result_Out} = ~tb_Data_B_In;                      end // NOT B
            4'hC    : begin {tb_Carry_Out, tb_Result_Out} = ~(tb_Data_A_In & tb_Data_B_In);     end // A NAND B
            4'hD    : begin {tb_Carry_Out, tb_Result_Out} = ~(tb_Data_A_In | tb_Data_B_In);     end // A NOR B
            4'hE    : begin {tb_Carry_Out, tb_Result_Out} = tb_Data_A_In ^ tb_Data_B_In;        end // A XOR B
            4'hF    : begin {tb_Carry_Out, tb_Result_Out} = ~(tb_Data_A_In ^ tb_Data_B_In);     end // A XNOR B

            default : begin {tb_Carry_Out, tb_Result_Out} = 5'b0;                               end
        endcase
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/ALU_32_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("ALU_32_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("All Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Check_ALU(1'b0, $random(), $random(), $random());
        Check_ALU(1'b1, $random(), $random(), 4'h0);
        Check_ALU(1'b1, $random(), $random(), 4'h1);
        Check_ALU(1'b1, $random(), $random(), 4'h2);
        Check_ALU(1'b1, $random(), $random(), 4'h3);
        Check_ALU(1'b1, $random(), $random(), 4'h4);
        Check_ALU(1'b1, $random(), $random(), 4'h5);
        Check_ALU(1'b1, $random(), $random(), 4'h6);
        Check_ALU(1'b1, $random(), $random(), 4'h7);
        Check_ALU(1'b1, $random(), $random(), 4'h8);
        Check_ALU(1'b1, $random(), $random(), 4'h9);
        Check_ALU(1'b1, $random(), $random(), 4'hA);
        Check_ALU(1'b1, $random(), $random(), 4'hB);
        Check_ALU(1'b1, $random(), $random(), 4'hC);
        Check_ALU(1'b1, $random(), $random(), 4'hD);
        Check_ALU(1'b1, $random(), $random(), 4'hE);
        Check_ALU(1'b1, $random(), $random(), 4'hF);

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        repeat (20)
            begin
                Check_ALU($random(), $random(), $random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
