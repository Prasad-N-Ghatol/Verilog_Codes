/*
--------------------------------------------------
Module :
--------------------------------------------------
Barrel_Shifter_16_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the Barrel Shifter - 16-Bit Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Barrel_Shifter_16_Bit_tb();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg         Enable_In   = 1'b0;

reg  [2:0]  Shift_Operation_In   = 3'b0;

reg  [3:0]  Shift_Bits_Length_In = 4'b0;
reg         Carry_In             = 1'b0;
reg  [15:0] Data_In              = 16'b0;

wire [15:0] Shifted_Data_Out;
wire        Carry_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire [16:0] DUT_Shift_Rotate_Bits_8 = DUT.Shift_Rotate_Bits_8;
wire [16:0] DUT_Shift_Rotate_Bits_4 = DUT.Shift_Rotate_Bits_4;
wire [16:0] DUT_Shift_Rotate_Bits_2 = DUT.Shift_Rotate_Bits_2;
wire [16:0] DUT_Shift_Rotate_Bits_1 = DUT.Shift_Rotate_Bits_1;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic        tb_Enable_In               = 1'b0;

logic [2:0]  tb_Shift_Operation_In      = 3'b0;

logic [3:0]  tb_Shift_Bits_Length_In    = 4'b0;
logic        tb_Carry_In                = 1'b0;
logic [15:0] tb_Data_In                 = 16'b0;

logic [15:0] tb_Shifted_Data_Out        = 16'b0;
logic        tb_Carry_Out               = 1'b0;



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
localparam [2:0]    LOGICAL_SHIFT_LEFT         = 3'h0,
                    LOGICAL_SHIFT_RIGHT        = 3'h1,
                    ARITHMETIC_SHIFT_LEFT      = 3'h2,
                    ARITHMETIC_SHIFT_RIGHT     = 3'h3,
                    ROTATE_LEFT                = 3'h4,
                    ROTATE_RIGHT               = 3'h5,
                    ROTATE_LEFT_THROUGH_CARRY  = 3'h6,
                    ROTATE_RIGHT_THROUGH_CARRY = 3'h7;



// --------------------------------------------------
// Barrel_Shifter_16_Bit DUT Instantiation
// --------------------------------------------------
Barrel_Shifter_16_Bit DUT (
    .Enable_In              (Enable_In),
    
    .Shift_Operation_In     (Shift_Operation_In),

    .Shift_Bits_Length_In   (Shift_Bits_Length_In),
    .Carry_In               (Carry_In),
    .Data_In                (Data_In),
    
    .Shifted_Data_Out       (Shifted_Data_Out),
    .Carry_Out              (Carry_Out)
);



// --------------------------------------------------
// Barrel_Shifter_16_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Barrel_Shifter_16_Bit.vcd");
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
// Check the Barrel_Shifter
task Check_Barrel_Shifter(input logic f_Enable_In, input logic [2:0] f_Shift_Operation_In, input logic [1:0] f_Shift_Bits_Length_In, input logic f_Carry_In, input logic [15:0] f_Data_In);
    begin
        Enable_In               = f_Enable_In;
        Shift_Operation_In      = f_Shift_Operation_In;
        Shift_Bits_Length_In    = f_Shift_Bits_Length_In;
        Carry_In                = f_Carry_In;
        Data_In                 = f_Data_In;
                
        tb_Enable_In               = f_Enable_In;
        tb_Shift_Operation_In      = f_Shift_Operation_In;
        tb_Shift_Bits_Length_In    = f_Shift_Bits_Length_In;
        tb_Carry_In                = f_Carry_In;
        tb_Data_In                 = f_Data_In;

        if (tb_Enable_In)
            begin
                Perform_Barrel_Shifter_Operation();
            end
        else
            begin
                tb_Shifted_Data_Out = 16'bZ;
                tb_Carry_Out        = 1'bZ;
            end

        #20;

        Check_Actual_vs_Expected_Value({Carry_Out , Shifted_Data_Out}, {tb_Carry_In , tb_Shifted_Data_Out});

        Write_To_File_And_Display($sformatf(
            "[%16t] : "                      , $time,
            "Enable_In = 0x%1b , "           , Enable_In,
            "Shift_Operation_In = 0x%1h , "  , Shift_Operation_In,
            "Shift_Bits_Length_In = 0x%1h , ", Shift_Bits_Length_In,
            "Carry_In = 0x%1b , "            , Carry_In,
            "Data_In = 0x%4h , "             , Data_In,
            "Shifted_Data_Out = 0x%4h , "    , Shifted_Data_Out,
            "Carry_Out = 0x%1b , "           , Carry_Out,
            "tb_Shifted_Data_Out = 0x%4h , " , tb_Shifted_Data_Out,
            "tb_Carry_Out = 0x%1b , "        , tb_Carry_Out,
            "Is_Same = %1b"                  , Is_Same
        ));
    end
endtask

// Perform Barrel_Shifter Operation
task Perform_Barrel_Shifter_Operation();
    begin
        case (tb_Shift_Operation_In)
            LOGICAL_SHIFT_LEFT          : begin Perform_Logical_Shift_Left();                     end // 3'h0
            LOGICAL_SHIFT_RIGHT         : begin Perform_Logical_Shift_Right();                    end // 3'h1
            ARITHMETIC_SHIFT_LEFT       : begin Perform_Arithmetic_Shift_Left();                  end // 3'h2
            ARITHMETIC_SHIFT_RIGHT      : begin Perform_Arithmetic_Shift_Right();                 end // 3'h3
            ROTATE_LEFT                 : begin Perform_Rotate_Left();                            end // 3'h4
            ROTATE_RIGHT                : begin Perform_Rotate_Right();                           end // 3'h5
            ROTATE_LEFT_THROUGH_CARRY   : begin Perform_Rotate_Left_Through_Carry();              end // 3'h6
            ROTATE_RIGHT_THROUGH_CARRY  : begin Perform_Rotate_Right_Through_Carry();             end // 3'h7
            default                     : begin {tb_Shifted_Data_Out, tb_Carry_Out} = 17'h1FFFF;  end
        endcase
    end
endtask

// Perform Logical_Shift_Left Operation
task Perform_Logical_Shift_Left();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            4'h0    : begin tb_Shifted_Data_Out = tb_Data_In               ;  end
            4'h1    : begin tb_Shifted_Data_Out = {tb_Data_In[14:0],  1'b0};  end
            4'h2    : begin tb_Shifted_Data_Out = {tb_Data_In[13:0],  2'b0};  end
            4'h3    : begin tb_Shifted_Data_Out = {tb_Data_In[12:0],  3'b0};  end
            4'h4    : begin tb_Shifted_Data_Out = {tb_Data_In[11:0],  4'b0};  end
            4'h5    : begin tb_Shifted_Data_Out = {tb_Data_In[10:0],  5'b0};  end
            4'h6    : begin tb_Shifted_Data_Out = {tb_Data_In[ 9:0],  6'b0};  end
            4'h7    : begin tb_Shifted_Data_Out = {tb_Data_In[ 8:0],  7'b0};  end
            4'h8    : begin tb_Shifted_Data_Out = {tb_Data_In[ 7:0],  8'b0};  end
            4'h9    : begin tb_Shifted_Data_Out = {tb_Data_In[ 6:0],  9'b0};  end
            4'hA    : begin tb_Shifted_Data_Out = {tb_Data_In[ 5:0], 10'b0};  end
            4'hB    : begin tb_Shifted_Data_Out = {tb_Data_In[ 4:0], 11'b0};  end
            4'hC    : begin tb_Shifted_Data_Out = {tb_Data_In[ 3:0], 12'b0};  end
            4'hD    : begin tb_Shifted_Data_Out = {tb_Data_In[ 2:0], 13'b0};  end
            4'hE    : begin tb_Shifted_Data_Out = {tb_Data_In[ 1:0], 14'b0};  end
            4'hF    : begin tb_Shifted_Data_Out = {tb_Data_In[   0], 15'b0};  end
            default : begin {tb_Shifted_Data_Out, tb_Carry_Out} = 17'h1FFFF;  end
        endcase
    end
endtask

// Perform Logical_Shift_Right Operation
task Perform_Logical_Shift_Right();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            4'h0    : begin tb_Shifted_Data_Out = tb_Data_In                ; end
            4'h1    : begin tb_Shifted_Data_Out = { 1'b0, tb_Data_In[15: 1]}; end
            4'h2    : begin tb_Shifted_Data_Out = { 2'b0, tb_Data_In[15: 2]}; end
            4'h3    : begin tb_Shifted_Data_Out = { 3'b0, tb_Data_In[15: 3]}; end
            4'h4    : begin tb_Shifted_Data_Out = { 4'b0, tb_Data_In[15: 4]}; end
            4'h5    : begin tb_Shifted_Data_Out = { 5'b0, tb_Data_In[15: 5]}; end
            4'h6    : begin tb_Shifted_Data_Out = { 6'b0, tb_Data_In[15: 6]}; end
            4'h7    : begin tb_Shifted_Data_Out = { 7'b0, tb_Data_In[15: 7]}; end
            4'h8    : begin tb_Shifted_Data_Out = { 8'b0, tb_Data_In[15: 8]}; end
            4'h9    : begin tb_Shifted_Data_Out = { 9'b0, tb_Data_In[15: 9]}; end
            4'hA    : begin tb_Shifted_Data_Out = {10'b0, tb_Data_In[15:10]}; end
            4'hB    : begin tb_Shifted_Data_Out = {11'b0, tb_Data_In[15:11]}; end
            4'hC    : begin tb_Shifted_Data_Out = {12'b0, tb_Data_In[15:12]}; end
            4'hD    : begin tb_Shifted_Data_Out = {13'b0, tb_Data_In[15:13]}; end
            4'hE    : begin tb_Shifted_Data_Out = {14'b0, tb_Data_In[15:14]}; end
            4'hF    : begin tb_Shifted_Data_Out = {15'b0, tb_Data_In[15]}   ; end
            default : begin {tb_Shifted_Data_Out, tb_Carry_Out} = 17'h1FFFF;  end
        endcase
    end
endtask

// Perform Arithmetic_Shift_Left Operation
task Perform_Arithmetic_Shift_Left();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            4'h0    : begin tb_Shifted_Data_Out = tb_Data_In               ;  end
            4'h1    : begin tb_Shifted_Data_Out = {tb_Data_In[14:0],  1'b0};  end
            4'h2    : begin tb_Shifted_Data_Out = {tb_Data_In[13:0],  2'b0};  end
            4'h3    : begin tb_Shifted_Data_Out = {tb_Data_In[12:0],  3'b0};  end
            4'h4    : begin tb_Shifted_Data_Out = {tb_Data_In[11:0],  4'b0};  end
            4'h5    : begin tb_Shifted_Data_Out = {tb_Data_In[10:0],  5'b0};  end
            4'h6    : begin tb_Shifted_Data_Out = {tb_Data_In[ 9:0],  6'b0};  end
            4'h7    : begin tb_Shifted_Data_Out = {tb_Data_In[ 8:0],  7'b0};  end
            4'h8    : begin tb_Shifted_Data_Out = {tb_Data_In[ 7:0],  8'b0};  end
            4'h9    : begin tb_Shifted_Data_Out = {tb_Data_In[ 6:0],  9'b0};  end
            4'hA    : begin tb_Shifted_Data_Out = {tb_Data_In[ 5:0], 10'b0};  end
            4'hB    : begin tb_Shifted_Data_Out = {tb_Data_In[ 4:0], 11'b0};  end
            4'hC    : begin tb_Shifted_Data_Out = {tb_Data_In[ 3:0], 12'b0};  end
            4'hD    : begin tb_Shifted_Data_Out = {tb_Data_In[ 2:0], 13'b0};  end
            4'hE    : begin tb_Shifted_Data_Out = {tb_Data_In[ 1:0], 14'b0};  end
            4'hF    : begin tb_Shifted_Data_Out = {tb_Data_In[   0], 15'b0};  end
            default : begin {tb_Shifted_Data_Out, tb_Carry_Out} = 17'h1FFFF;  end
        endcase
    end
endtask

// Perform Arithmetic_Shift_Right Operation
task Perform_Arithmetic_Shift_Right();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            4'h0    : begin tb_Shifted_Data_Out = tb_Data_In                               ;    end
            4'h1    : begin tb_Shifted_Data_Out = {{ 1{tb_Data_In[15]}}, tb_Data_In[15: 1]};    end
            4'h2    : begin tb_Shifted_Data_Out = {{ 2{tb_Data_In[15]}}, tb_Data_In[15: 2]};    end
            4'h3    : begin tb_Shifted_Data_Out = {{ 3{tb_Data_In[15]}}, tb_Data_In[15: 3]};    end
            4'h4    : begin tb_Shifted_Data_Out = {{ 4{tb_Data_In[15]}}, tb_Data_In[15: 4]};    end
            4'h5    : begin tb_Shifted_Data_Out = {{ 5{tb_Data_In[15]}}, tb_Data_In[15: 5]};    end
            4'h6    : begin tb_Shifted_Data_Out = {{ 6{tb_Data_In[15]}}, tb_Data_In[15: 6]};    end
            4'h7    : begin tb_Shifted_Data_Out = {{ 7{tb_Data_In[15]}}, tb_Data_In[15: 7]};    end
            4'h8    : begin tb_Shifted_Data_Out = {{ 8{tb_Data_In[15]}}, tb_Data_In[15: 8]};    end
            4'h9    : begin tb_Shifted_Data_Out = {{ 9{tb_Data_In[15]}}, tb_Data_In[15: 9]};    end
            4'hA    : begin tb_Shifted_Data_Out = {{10{tb_Data_In[15]}}, tb_Data_In[15:10]};    end
            4'hB    : begin tb_Shifted_Data_Out = {{11{tb_Data_In[15]}}, tb_Data_In[15:11]};    end
            4'hC    : begin tb_Shifted_Data_Out = {{12{tb_Data_In[15]}}, tb_Data_In[15:12]};    end
            4'hD    : begin tb_Shifted_Data_Out = {{13{tb_Data_In[15]}}, tb_Data_In[15:13]};    end
            4'hE    : begin tb_Shifted_Data_Out = {{14{tb_Data_In[15]}}, tb_Data_In[15:14]};    end
            4'hF    : begin tb_Shifted_Data_Out = {{15{tb_Data_In[15]}}, tb_Data_In[15]}   ;    end
            default : begin {tb_Shifted_Data_Out, tb_Carry_Out} = 17'h1FFFF;                    end
        endcase
    end
endtask

// Perform Rotate_Left Operation
task Perform_Rotate_Left();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            4'h0    : begin tb_Shifted_Data_Out = tb_Data_In                           ;    end
            4'h1    : begin tb_Shifted_Data_Out = {tb_Data_In[14:0], tb_Data_In[15]}   ;    end
            4'h2    : begin tb_Shifted_Data_Out = {tb_Data_In[13:0], tb_Data_In[15:14]};    end
            4'h3    : begin tb_Shifted_Data_Out = {tb_Data_In[12:0], tb_Data_In[15:13]};    end
            4'h4    : begin tb_Shifted_Data_Out = {tb_Data_In[11:0], tb_Data_In[15:12]};    end
            4'h5    : begin tb_Shifted_Data_Out = {tb_Data_In[10:0], tb_Data_In[15:11]};    end
            4'h6    : begin tb_Shifted_Data_Out = {tb_Data_In[ 9:0], tb_Data_In[15:10]};    end
            4'h7    : begin tb_Shifted_Data_Out = {tb_Data_In[ 8:0], tb_Data_In[15: 9]};    end
            4'h8    : begin tb_Shifted_Data_Out = {tb_Data_In[ 7:0], tb_Data_In[15: 8]};    end
            4'h9    : begin tb_Shifted_Data_Out = {tb_Data_In[ 6:0], tb_Data_In[15: 7]};    end
            4'hA    : begin tb_Shifted_Data_Out = {tb_Data_In[ 5:0], tb_Data_In[15: 6]};    end
            4'hB    : begin tb_Shifted_Data_Out = {tb_Data_In[ 4:0], tb_Data_In[15: 5]};    end
            4'hC    : begin tb_Shifted_Data_Out = {tb_Data_In[ 3:0], tb_Data_In[15: 4]};    end
            4'hD    : begin tb_Shifted_Data_Out = {tb_Data_In[ 2:0], tb_Data_In[15: 3]};    end
            4'hE    : begin tb_Shifted_Data_Out = {tb_Data_In[ 1:0], tb_Data_In[15: 2]};    end
            4'hF    : begin tb_Shifted_Data_Out = {tb_Data_In[   0], tb_Data_In[15: 1]};    end
            default : begin {tb_Shifted_Data_Out, tb_Carry_Out} = 17'h1FFFF;                end
        endcase
    end
endtask

// Perform Rotate_Right Operation
task Perform_Rotate_Right();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            4'h0    : begin tb_Shifted_Data_Out = tb_Data_In                           ;   end
            4'h1    : begin tb_Shifted_Data_Out = {tb_Data_In[   0], tb_Data_In[15: 1]};   end
            4'h2    : begin tb_Shifted_Data_Out = {tb_Data_In[ 1:0], tb_Data_In[15: 2]};   end
            4'h3    : begin tb_Shifted_Data_Out = {tb_Data_In[ 2:0], tb_Data_In[15: 3]};   end
            4'h4    : begin tb_Shifted_Data_Out = {tb_Data_In[ 3:0], tb_Data_In[15: 4]};   end
            4'h5    : begin tb_Shifted_Data_Out = {tb_Data_In[ 4:0], tb_Data_In[15: 5]};   end
            4'h6    : begin tb_Shifted_Data_Out = {tb_Data_In[ 5:0], tb_Data_In[15: 6]};   end
            4'h7    : begin tb_Shifted_Data_Out = {tb_Data_In[ 6:0], tb_Data_In[15: 7]};   end
            4'h8    : begin tb_Shifted_Data_Out = {tb_Data_In[ 7:0], tb_Data_In[15: 8]};   end
            4'h9    : begin tb_Shifted_Data_Out = {tb_Data_In[ 8:0], tb_Data_In[15: 9]};   end
            4'hA    : begin tb_Shifted_Data_Out = {tb_Data_In[ 9:0], tb_Data_In[15:10]};   end
            4'hB    : begin tb_Shifted_Data_Out = {tb_Data_In[10:0], tb_Data_In[15:11]};   end
            4'hC    : begin tb_Shifted_Data_Out = {tb_Data_In[11:0], tb_Data_In[15:12]};   end
            4'hD    : begin tb_Shifted_Data_Out = {tb_Data_In[12:0], tb_Data_In[15:13]};   end
            4'hE    : begin tb_Shifted_Data_Out = {tb_Data_In[13:0], tb_Data_In[15:14]};   end
            4'hF    : begin tb_Shifted_Data_Out = {tb_Data_In[14:0], tb_Data_In[15]}   ;   end
            default : begin {tb_Shifted_Data_Out, tb_Carry_Out} = 17'h1FFFF;               end
        endcase
    end
endtask

// Perform Rotate_Left_Through_Carry Operation
task Perform_Rotate_Left_Through_Carry();
    begin
        case (tb_Shift_Bits_Length_In)
            4'h0    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Carry_In     , tb_Data_In                    };  end
            4'h1    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[15:0], tb_Carry_In                   };  end
            4'h2    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[14:0], tb_Carry_In, tb_Data_In[15]   };  end
            4'h3    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[13:0], tb_Carry_In, tb_Data_In[15:14]};  end
            4'h4    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[12:0], tb_Carry_In, tb_Data_In[15:13]};  end
            4'h5    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[11:0], tb_Carry_In, tb_Data_In[15:12]};  end
            4'h6    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[10:0], tb_Carry_In, tb_Data_In[15:11]};  end
            4'h7    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 9:0], tb_Carry_In, tb_Data_In[15:10]};  end
            4'h8    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 8:0], tb_Carry_In, tb_Data_In[15: 9]};  end
            4'h9    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 7:0], tb_Carry_In, tb_Data_In[15: 8]};  end
            4'hA    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 6:0], tb_Carry_In, tb_Data_In[15: 7]};  end
            4'hB    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 5:0], tb_Carry_In, tb_Data_In[15: 6]};  end
            4'hC    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 4:0], tb_Carry_In, tb_Data_In[15: 5]};  end
            4'hD    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 3:0], tb_Carry_In, tb_Data_In[15: 4]};  end
            4'hE    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 2:0], tb_Carry_In, tb_Data_In[15: 3]};  end
            4'hF    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 1:0], tb_Carry_In, tb_Data_In[15: 2]};  end
            default : begin {tb_Shifted_Data_Out, tb_Carry_Out} = 17'h1FFFF;                                           end
        endcase
    end
endtask

// Perform Rotate_Right_Through_Carry Operation
task Perform_Rotate_Right_Through_Carry();
    begin
        case (tb_Shift_Bits_Length_In)
            4'h0    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Carry_In     , tb_Data_In                    };  end
            4'h1    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[   0], tb_Carry_In, tb_Data_In[15: 1]};  end
            4'h2    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 1:0], tb_Carry_In, tb_Data_In[15: 2]};  end
            4'h3    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 2:0], tb_Carry_In, tb_Data_In[15: 3]};  end
            4'h4    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 3:0], tb_Carry_In, tb_Data_In[15: 4]};  end
            4'h5    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 4:0], tb_Carry_In, tb_Data_In[15: 5]};  end
            4'h6    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 5:0], tb_Carry_In, tb_Data_In[15: 6]};  end
            4'h7    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 6:0], tb_Carry_In, tb_Data_In[15: 7]};  end
            4'h8    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 7:0], tb_Carry_In, tb_Data_In[15: 8]};  end
            4'h9    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 8:0], tb_Carry_In, tb_Data_In[15: 9]};  end
            4'hA    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 9:0], tb_Carry_In, tb_Data_In[15:10]};  end
            4'hB    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[10:0], tb_Carry_In, tb_Data_In[15:11]};  end
            4'hC    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[11:0], tb_Carry_In, tb_Data_In[15:12]};  end
            4'hD    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[12:0], tb_Carry_In, tb_Data_In[15:13]};  end
            4'hE    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[13:0], tb_Carry_In, tb_Data_In[15:14]};  end
            4'hF    : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[14:0], tb_Carry_In, tb_Data_In[15]   };  end
            default : begin {tb_Shifted_Data_Out, tb_Carry_Out} = 17'h1FFFF;                                           end
        endcase
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Barrel_Shifter_16_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Barrel_Shifter_16_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("All Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, LOGICAL_SHIFT_LEFT        , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'h0, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'h1, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'h3, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'h4, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'h5, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'h6, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'h7, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'h8, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'h9, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'hA, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'hB, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'hC, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'hD, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'hE, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 4'hF, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, LOGICAL_SHIFT_RIGHT       , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'h0, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'h1, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'h3, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'h4, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'h5, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'h6, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'h7, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'h8, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'h9, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'hA, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'hB, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'hC, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'hD, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'hE, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 4'hF, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ARITHMETIC_SHIFT_LEFT     , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'h0, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'h1, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'h3, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'h4, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'h5, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'h6, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'h7, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'h8, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'h9, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'hA, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'hB, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'hC, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'hD, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'hE, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 4'hF, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ARITHMETIC_SHIFT_RIGHT    , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'h0, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'h1, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'h3, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'h4, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'h5, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'h6, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'h7, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'h8, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'h9, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'hA, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'hB, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'hC, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'hD, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'hE, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 4'hF, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ROTATE_LEFT               , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'h0, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'h1, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'h3, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'h4, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'h5, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'h6, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'h7, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'h8, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'h9, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'hA, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'hB, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'hC, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'hD, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'hE, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 4'hF, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ROTATE_RIGHT              , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'h0, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'h1, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'h3, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'h4, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'h5, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'h6, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'h7, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'h8, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'h9, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'hA, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'hB, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'hC, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'hD, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'hE, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 4'hF, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ROTATE_LEFT_THROUGH_CARRY , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'h0, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'h1, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'h3, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'h4, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'h5, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'h6, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'h7, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'h8, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'h9, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'hA, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'hB, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'hC, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'hD, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'hE, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 4'hF, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ROTATE_RIGHT_THROUGH_CARRY, 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'h0, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'h1, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'h2, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'h3, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'h4, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'h5, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'h6, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'h7, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'h8, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'h9, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'hA, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'hB, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'hC, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'hD, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'hE, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 4'hF, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        #40;

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Random Combinations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        repeat(20)
            begin
                Check_Barrel_Shifter($random(), $random(), $random(), $random(), $random());
            end

        Display_Results();
        Close_File();
        $stop;
    end



endmodule
