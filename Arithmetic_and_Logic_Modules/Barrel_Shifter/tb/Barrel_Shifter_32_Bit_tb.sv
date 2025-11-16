/*
--------------------------------------------------
Module :
--------------------------------------------------
Barrel_Shifter_32_Bit_tb


--------------------------------------------------
Description :
--------------------------------------------------
A Functional Testbench to check the Barrel Shifter - 32-Bit Implementation.


--------------------------------------------------
Author : Prasad Narayan Ghatol
--------------------------------------------------
*/
`timescale 1ns/1ps



module Barrel_Shifter_32_Bit_tb();



// --------------------------------------------------
// DUT Inputs and Outputs
// --------------------------------------------------
reg         Enable_In   = 1'b0;

reg  [2:0]  Shift_Operation_In   = 3'b0;

reg  [4:0]  Shift_Bits_Length_In = 5'b0;
reg         Carry_In             = 1'b0;
reg  [31:0] Data_In              = 32'b0;

wire [31:0] Shifted_Data_Out;
wire        Carry_Out;



// --------------------------------------------------
// Debug DUT Variables
// --------------------------------------------------
wire [32:0] DUT_Shift_Rotate_Bits_16 = DUT.Shift_Rotate_Bits_16;
wire [32:0] DUT_Shift_Rotate_Bits_8  = DUT.Shift_Rotate_Bits_8;
wire [32:0] DUT_Shift_Rotate_Bits_4  = DUT.Shift_Rotate_Bits_4;
wire [32:0] DUT_Shift_Rotate_Bits_2  = DUT.Shift_Rotate_Bits_2;
wire [32:0] DUT_Shift_Rotate_Bits_1  = DUT.Shift_Rotate_Bits_1;



// --------------------------------------------------
// Testbench Variables
// --------------------------------------------------
logic        tb_Enable_In               = 1'b0;

logic [2:0]  tb_Shift_Operation_In      = 3'b0;

logic [4:0]  tb_Shift_Bits_Length_In    = 5'b0;
logic        tb_Carry_In                = 1'b0;
logic [31:0] tb_Data_In                 = 32'b0;

logic [31:0] tb_Shifted_Data_Out        = 32'b0;
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
// Barrel_Shifter_32_Bit DUT Instantiation
// --------------------------------------------------
Barrel_Shifter_32_Bit DUT (
    .Enable_In              (Enable_In),
    
    .Shift_Operation_In     (Shift_Operation_In),

    .Shift_Bits_Length_In   (Shift_Bits_Length_In),
    .Carry_In               (Carry_In),
    .Data_In                (Data_In),
    
    .Shifted_Data_Out       (Shifted_Data_Out),
    .Carry_Out              (Carry_Out)
);



// --------------------------------------------------
// Barrel_Shifter_32_Bit VCD file
// --------------------------------------------------
initial
    begin
        $dumpfile("../../vcd_Files/Barrel_Shifter_32_Bit.vcd");
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
task Check_Barrel_Shifter(input logic f_Enable_In, input logic [2:0] f_Shift_Operation_In, input logic [1:0] f_Shift_Bits_Length_In, input logic f_Carry_In, input logic [31:0] f_Data_In);
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
                tb_Shifted_Data_Out = 32'bZ;
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
            "Data_In = 0x%8h , "             , Data_In,
            "Shifted_Data_Out = 0x%8h , "    , Shifted_Data_Out,
            "Carry_Out = 0x%1b , "           , Carry_Out,
            "tb_Shifted_Data_Out = 0x%8h , " , tb_Shifted_Data_Out,
            "tb_Carry_Out = 0x%1b , "        , tb_Carry_Out,
            "Is_Same = %1b"                  , Is_Same
        ));
    end
endtask

// Perform Barrel_Shifter Operation
task Perform_Barrel_Shifter_Operation();
    begin
        case (tb_Shift_Operation_In)
            LOGICAL_SHIFT_LEFT          : begin Perform_Logical_Shift_Left();                           end // 3'h0
            LOGICAL_SHIFT_RIGHT         : begin Perform_Logical_Shift_Right();                          end // 3'h1
            ARITHMETIC_SHIFT_LEFT       : begin Perform_Arithmetic_Shift_Left();                        end // 3'h2
            ARITHMETIC_SHIFT_RIGHT      : begin Perform_Arithmetic_Shift_Right();                       end // 3'h3
            ROTATE_LEFT                 : begin Perform_Rotate_Left();                                  end // 3'h4
            ROTATE_RIGHT                : begin Perform_Rotate_Right();                                 end // 3'h5
            ROTATE_LEFT_THROUGH_CARRY   : begin Perform_Rotate_Left_Through_Carry();                    end // 3'h6
            ROTATE_RIGHT_THROUGH_CARRY  : begin Perform_Rotate_Right_Through_Carry();                   end // 3'h7
            default                     : begin {tb_Shifted_Data_Out , tb_Carry_Out} = 33'h1FFFFFFFF;   end
        endcase
    end
endtask

// Perform Logical_Shift_Left Operation
task Perform_Logical_Shift_Left();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            5'h00   : begin tb_Shifted_Data_Out = tb_Data_In               ;       end
            5'h01   : begin tb_Shifted_Data_Out = {tb_Data_In[30:0],  1'b0};       end
            5'h02   : begin tb_Shifted_Data_Out = {tb_Data_In[29:0],  2'b0};       end
            5'h03   : begin tb_Shifted_Data_Out = {tb_Data_In[28:0],  3'b0};       end
            5'h04   : begin tb_Shifted_Data_Out = {tb_Data_In[27:0],  4'b0};       end
            5'h05   : begin tb_Shifted_Data_Out = {tb_Data_In[26:0],  5'b0};       end
            5'h06   : begin tb_Shifted_Data_Out = {tb_Data_In[25:0],  6'b0};       end
            5'h07   : begin tb_Shifted_Data_Out = {tb_Data_In[24:0],  7'b0};       end
            5'h08   : begin tb_Shifted_Data_Out = {tb_Data_In[23:0],  8'b0};       end
            5'h09   : begin tb_Shifted_Data_Out = {tb_Data_In[22:0],  9'b0};       end
            5'h0A   : begin tb_Shifted_Data_Out = {tb_Data_In[21:0], 10'b0};       end
            5'h0B   : begin tb_Shifted_Data_Out = {tb_Data_In[20:0], 11'b0};       end
            5'h0C   : begin tb_Shifted_Data_Out = {tb_Data_In[19:0], 12'b0};       end
            5'h0D   : begin tb_Shifted_Data_Out = {tb_Data_In[18:0], 13'b0};       end
            5'h0E   : begin tb_Shifted_Data_Out = {tb_Data_In[17:0], 14'b0};       end
            5'h0F   : begin tb_Shifted_Data_Out = {tb_Data_In[16:0], 15'b0};       end
            5'h10   : begin tb_Shifted_Data_Out = {tb_Data_In[15:0], 16'b0};       end
            5'h11   : begin tb_Shifted_Data_Out = {tb_Data_In[14:0], 17'b0};       end
            5'h12   : begin tb_Shifted_Data_Out = {tb_Data_In[13:0], 18'b0};       end
            5'h13   : begin tb_Shifted_Data_Out = {tb_Data_In[12:0], 19'b0};       end
            5'h14   : begin tb_Shifted_Data_Out = {tb_Data_In[11:0], 20'b0};       end
            5'h15   : begin tb_Shifted_Data_Out = {tb_Data_In[10:0], 21'b0};       end
            5'h16   : begin tb_Shifted_Data_Out = {tb_Data_In[ 9:0], 22'b0};       end
            5'h17   : begin tb_Shifted_Data_Out = {tb_Data_In[ 8:0], 23'b0};       end
            5'h18   : begin tb_Shifted_Data_Out = {tb_Data_In[ 7:0], 24'b0};       end
            5'h19   : begin tb_Shifted_Data_Out = {tb_Data_In[ 6:0], 25'b0};       end
            5'h1A   : begin tb_Shifted_Data_Out = {tb_Data_In[ 5:0], 26'b0};       end
            5'h1B   : begin tb_Shifted_Data_Out = {tb_Data_In[ 4:0], 27'b0};       end
            5'h1C   : begin tb_Shifted_Data_Out = {tb_Data_In[ 3:0], 28'b0};       end
            5'h1D   : begin tb_Shifted_Data_Out = {tb_Data_In[ 2:0], 29'b0};       end
            5'h1E   : begin tb_Shifted_Data_Out = {tb_Data_In[ 1:0], 30'b0};       end
            5'h1F   : begin tb_Shifted_Data_Out = {tb_Data_In[   0], 31'b0};       end
            default : begin {tb_Shifted_Data_Out , tb_Carry_Out} = 33'h1FFFFFFFF;  end
        endcase
    end
endtask

// Perform Logical_Shift_Right Operation
task Perform_Logical_Shift_Right();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            5'h00   : begin tb_Shifted_Data_Out = tb_Data_In                ;     end
            5'h01   : begin tb_Shifted_Data_Out = { 1'b0, tb_Data_In[31: 1]};     end
            5'h02   : begin tb_Shifted_Data_Out = { 2'b0, tb_Data_In[31: 2]};     end
            5'h03   : begin tb_Shifted_Data_Out = { 3'b0, tb_Data_In[31: 3]};     end
            5'h04   : begin tb_Shifted_Data_Out = { 4'b0, tb_Data_In[31: 4]};     end
            5'h05   : begin tb_Shifted_Data_Out = { 5'b0, tb_Data_In[31: 5]};     end
            5'h06   : begin tb_Shifted_Data_Out = { 6'b0, tb_Data_In[31: 6]};     end
            5'h07   : begin tb_Shifted_Data_Out = { 7'b0, tb_Data_In[31: 7]};     end
            5'h08   : begin tb_Shifted_Data_Out = { 8'b0, tb_Data_In[31: 8]};     end
            5'h09   : begin tb_Shifted_Data_Out = { 9'b0, tb_Data_In[31: 9]};     end
            5'h0A   : begin tb_Shifted_Data_Out = {10'b0, tb_Data_In[31:10]};     end
            5'h0B   : begin tb_Shifted_Data_Out = {11'b0, tb_Data_In[31:11]};     end
            5'h0C   : begin tb_Shifted_Data_Out = {12'b0, tb_Data_In[31:12]};     end
            5'h0D   : begin tb_Shifted_Data_Out = {13'b0, tb_Data_In[31:13]};     end
            5'h0E   : begin tb_Shifted_Data_Out = {14'b0, tb_Data_In[31:14]};     end
            5'h0F   : begin tb_Shifted_Data_Out = {15'b0, tb_Data_In[31:15]};     end
            5'h10   : begin tb_Shifted_Data_Out = {16'b0, tb_Data_In[31:16]};     end
            5'h11   : begin tb_Shifted_Data_Out = {17'b0, tb_Data_In[31:17]};     end
            5'h12   : begin tb_Shifted_Data_Out = {18'b0, tb_Data_In[31:18]};     end
            5'h13   : begin tb_Shifted_Data_Out = {19'b0, tb_Data_In[31:19]};     end
            5'h14   : begin tb_Shifted_Data_Out = {20'b0, tb_Data_In[31:20]};     end
            5'h15   : begin tb_Shifted_Data_Out = {21'b0, tb_Data_In[31:21]};     end
            5'h16   : begin tb_Shifted_Data_Out = {22'b0, tb_Data_In[31:22]};     end
            5'h17   : begin tb_Shifted_Data_Out = {23'b0, tb_Data_In[31:23]};     end
            5'h18   : begin tb_Shifted_Data_Out = {24'b0, tb_Data_In[31:24]};     end
            5'h19   : begin tb_Shifted_Data_Out = {25'b0, tb_Data_In[31:25]};     end
            5'h1A   : begin tb_Shifted_Data_Out = {26'b0, tb_Data_In[31:26]};     end
            5'h1B   : begin tb_Shifted_Data_Out = {27'b0, tb_Data_In[31:27]};     end
            5'h1C   : begin tb_Shifted_Data_Out = {28'b0, tb_Data_In[31:28]};     end
            5'h1D   : begin tb_Shifted_Data_Out = {29'b0, tb_Data_In[31:29]};     end
            5'h1E   : begin tb_Shifted_Data_Out = {30'b0, tb_Data_In[31:30]};     end
            5'h1F   : begin tb_Shifted_Data_Out = {31'b0, tb_Data_In[31]}   ;     end
            default : begin {tb_Shifted_Data_Out , tb_Carry_Out} = 33'h1FFFFFFFF; end
        endcase
    end
endtask

// Perform Arithmetic_Shift_Left Operation
task Perform_Arithmetic_Shift_Left();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            5'h00   : begin tb_Shifted_Data_Out = tb_Data_In               ;       end
            5'h01   : begin tb_Shifted_Data_Out = {tb_Data_In[30:0],  1'b0};       end
            5'h02   : begin tb_Shifted_Data_Out = {tb_Data_In[29:0],  2'b0};       end
            5'h03   : begin tb_Shifted_Data_Out = {tb_Data_In[28:0],  3'b0};       end
            5'h04   : begin tb_Shifted_Data_Out = {tb_Data_In[27:0],  4'b0};       end
            5'h05   : begin tb_Shifted_Data_Out = {tb_Data_In[26:0],  5'b0};       end
            5'h06   : begin tb_Shifted_Data_Out = {tb_Data_In[25:0],  6'b0};       end
            5'h07   : begin tb_Shifted_Data_Out = {tb_Data_In[24:0],  7'b0};       end
            5'h08   : begin tb_Shifted_Data_Out = {tb_Data_In[23:0],  8'b0};       end
            5'h09   : begin tb_Shifted_Data_Out = {tb_Data_In[22:0],  9'b0};       end
            5'h0A   : begin tb_Shifted_Data_Out = {tb_Data_In[21:0], 10'b0};       end
            5'h0B   : begin tb_Shifted_Data_Out = {tb_Data_In[20:0], 11'b0};       end
            5'h0C   : begin tb_Shifted_Data_Out = {tb_Data_In[19:0], 12'b0};       end
            5'h0D   : begin tb_Shifted_Data_Out = {tb_Data_In[18:0], 13'b0};       end
            5'h0E   : begin tb_Shifted_Data_Out = {tb_Data_In[17:0], 14'b0};       end
            5'h0F   : begin tb_Shifted_Data_Out = {tb_Data_In[16:0], 15'b0};       end
            5'h10   : begin tb_Shifted_Data_Out = {tb_Data_In[15:0], 16'b0};       end
            5'h11   : begin tb_Shifted_Data_Out = {tb_Data_In[14:0], 17'b0};       end
            5'h12   : begin tb_Shifted_Data_Out = {tb_Data_In[13:0], 18'b0};       end
            5'h13   : begin tb_Shifted_Data_Out = {tb_Data_In[12:0], 19'b0};       end
            5'h14   : begin tb_Shifted_Data_Out = {tb_Data_In[11:0], 20'b0};       end
            5'h15   : begin tb_Shifted_Data_Out = {tb_Data_In[10:0], 21'b0};       end
            5'h16   : begin tb_Shifted_Data_Out = {tb_Data_In[ 9:0], 22'b0};       end
            5'h17   : begin tb_Shifted_Data_Out = {tb_Data_In[ 8:0], 23'b0};       end
            5'h18   : begin tb_Shifted_Data_Out = {tb_Data_In[ 7:0], 24'b0};       end
            5'h19   : begin tb_Shifted_Data_Out = {tb_Data_In[ 6:0], 25'b0};       end
            5'h1A   : begin tb_Shifted_Data_Out = {tb_Data_In[ 5:0], 26'b0};       end
            5'h1B   : begin tb_Shifted_Data_Out = {tb_Data_In[ 4:0], 27'b0};       end
            5'h1C   : begin tb_Shifted_Data_Out = {tb_Data_In[ 3:0], 28'b0};       end
            5'h1D   : begin tb_Shifted_Data_Out = {tb_Data_In[ 2:0], 29'b0};       end
            5'h1E   : begin tb_Shifted_Data_Out = {tb_Data_In[ 1:0], 30'b0};       end
            5'h1F   : begin tb_Shifted_Data_Out = {tb_Data_In[   0], 31'b0};       end
            default : begin {tb_Shifted_Data_Out , tb_Carry_Out} = 33'h1FFFFFFFF;  end
        endcase
    end
endtask

// Perform Arithmetic_Shift_Right Operation
task Perform_Arithmetic_Shift_Right();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            5'h00   : begin tb_Shifted_Data_Out = tb_Data_In                               ;    end
            5'h01   : begin tb_Shifted_Data_Out = {{ 1{tb_Data_In[31]}}, tb_Data_In[31: 1]};    end
            5'h02   : begin tb_Shifted_Data_Out = {{ 2{tb_Data_In[31]}}, tb_Data_In[31: 2]};    end
            5'h03   : begin tb_Shifted_Data_Out = {{ 3{tb_Data_In[31]}}, tb_Data_In[31: 3]};    end
            5'h04   : begin tb_Shifted_Data_Out = {{ 4{tb_Data_In[31]}}, tb_Data_In[31: 4]};    end
            5'h05   : begin tb_Shifted_Data_Out = {{ 5{tb_Data_In[31]}}, tb_Data_In[31: 5]};    end
            5'h06   : begin tb_Shifted_Data_Out = {{ 6{tb_Data_In[31]}}, tb_Data_In[31: 6]};    end
            5'h07   : begin tb_Shifted_Data_Out = {{ 7{tb_Data_In[31]}}, tb_Data_In[31: 7]};    end
            5'h08   : begin tb_Shifted_Data_Out = {{ 8{tb_Data_In[31]}}, tb_Data_In[31: 8]};    end
            5'h09   : begin tb_Shifted_Data_Out = {{ 9{tb_Data_In[31]}}, tb_Data_In[31: 9]};    end
            5'h0A   : begin tb_Shifted_Data_Out = {{10{tb_Data_In[31]}}, tb_Data_In[31:10]};    end
            5'h0B   : begin tb_Shifted_Data_Out = {{11{tb_Data_In[31]}}, tb_Data_In[31:11]};    end
            5'h0C   : begin tb_Shifted_Data_Out = {{12{tb_Data_In[31]}}, tb_Data_In[31:12]};    end
            5'h0D   : begin tb_Shifted_Data_Out = {{13{tb_Data_In[31]}}, tb_Data_In[31:13]};    end
            5'h0E   : begin tb_Shifted_Data_Out = {{14{tb_Data_In[31]}}, tb_Data_In[31:14]};    end
            5'h0F   : begin tb_Shifted_Data_Out = {{15{tb_Data_In[31]}}, tb_Data_In[31:15]};    end
            5'h10   : begin tb_Shifted_Data_Out = {{16{tb_Data_In[31]}}, tb_Data_In[31:16]};    end
            5'h11   : begin tb_Shifted_Data_Out = {{17{tb_Data_In[31]}}, tb_Data_In[31:17]};    end
            5'h12   : begin tb_Shifted_Data_Out = {{18{tb_Data_In[31]}}, tb_Data_In[31:18]};    end
            5'h13   : begin tb_Shifted_Data_Out = {{19{tb_Data_In[31]}}, tb_Data_In[31:19]};    end
            5'h14   : begin tb_Shifted_Data_Out = {{20{tb_Data_In[31]}}, tb_Data_In[31:20]};    end
            5'h15   : begin tb_Shifted_Data_Out = {{21{tb_Data_In[31]}}, tb_Data_In[31:21]};    end
            5'h16   : begin tb_Shifted_Data_Out = {{22{tb_Data_In[31]}}, tb_Data_In[31:22]};    end
            5'h17   : begin tb_Shifted_Data_Out = {{23{tb_Data_In[31]}}, tb_Data_In[31:23]};    end
            5'h18   : begin tb_Shifted_Data_Out = {{24{tb_Data_In[31]}}, tb_Data_In[31:24]};    end
            5'h19   : begin tb_Shifted_Data_Out = {{25{tb_Data_In[31]}}, tb_Data_In[31:25]};    end
            5'h1A   : begin tb_Shifted_Data_Out = {{26{tb_Data_In[31]}}, tb_Data_In[31:26]};    end
            5'h1B   : begin tb_Shifted_Data_Out = {{27{tb_Data_In[31]}}, tb_Data_In[31:27]};    end
            5'h1C   : begin tb_Shifted_Data_Out = {{28{tb_Data_In[31]}}, tb_Data_In[31:28]};    end
            5'h1D   : begin tb_Shifted_Data_Out = {{29{tb_Data_In[31]}}, tb_Data_In[31:29]};    end
            5'h1E   : begin tb_Shifted_Data_Out = {{30{tb_Data_In[31]}}, tb_Data_In[31:30]};    end
            5'h1F   : begin tb_Shifted_Data_Out = {{31{tb_Data_In[31]}}, tb_Data_In[31]}   ;    end
            default : begin {tb_Shifted_Data_Out , tb_Carry_Out} = 33'h1FFFFFFFF;               end
        endcase
    end
endtask

// Perform Rotate_Left Operation
task Perform_Rotate_Left();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            5'h00   : begin tb_Shifted_Data_Out = tb_Data_In                           ;    end
            5'h01   : begin tb_Shifted_Data_Out = {tb_Data_In[30:0], tb_Data_In[31]}   ;    end
            5'h02   : begin tb_Shifted_Data_Out = {tb_Data_In[29:0], tb_Data_In[31:30]};    end
            5'h03   : begin tb_Shifted_Data_Out = {tb_Data_In[28:0], tb_Data_In[31:29]};    end
            5'h04   : begin tb_Shifted_Data_Out = {tb_Data_In[27:0], tb_Data_In[31:28]};    end
            5'h05   : begin tb_Shifted_Data_Out = {tb_Data_In[26:0], tb_Data_In[31:27]};    end
            5'h06   : begin tb_Shifted_Data_Out = {tb_Data_In[25:0], tb_Data_In[31:26]};    end
            5'h07   : begin tb_Shifted_Data_Out = {tb_Data_In[24:0], tb_Data_In[31:25]};    end
            5'h08   : begin tb_Shifted_Data_Out = {tb_Data_In[23:0], tb_Data_In[31:24]};    end
            5'h09   : begin tb_Shifted_Data_Out = {tb_Data_In[22:0], tb_Data_In[31:23]};    end
            5'h0A   : begin tb_Shifted_Data_Out = {tb_Data_In[21:0], tb_Data_In[31:22]};    end
            5'h0B   : begin tb_Shifted_Data_Out = {tb_Data_In[20:0], tb_Data_In[31:21]};    end
            5'h0C   : begin tb_Shifted_Data_Out = {tb_Data_In[19:0], tb_Data_In[31:20]};    end
            5'h0D   : begin tb_Shifted_Data_Out = {tb_Data_In[18:0], tb_Data_In[31:19]};    end
            5'h0E   : begin tb_Shifted_Data_Out = {tb_Data_In[17:0], tb_Data_In[31:18]};    end
            5'h0F   : begin tb_Shifted_Data_Out = {tb_Data_In[16:0], tb_Data_In[31:17]};    end
            5'h10   : begin tb_Shifted_Data_Out = {tb_Data_In[15:0], tb_Data_In[31:16]};    end
            5'h11   : begin tb_Shifted_Data_Out = {tb_Data_In[14:0], tb_Data_In[31:15]};    end
            5'h12   : begin tb_Shifted_Data_Out = {tb_Data_In[13:0], tb_Data_In[31:14]};    end
            5'h13   : begin tb_Shifted_Data_Out = {tb_Data_In[12:0], tb_Data_In[31:13]};    end
            5'h14   : begin tb_Shifted_Data_Out = {tb_Data_In[11:0], tb_Data_In[31:12]};    end
            5'h15   : begin tb_Shifted_Data_Out = {tb_Data_In[10:0], tb_Data_In[31:11]};    end
            5'h16   : begin tb_Shifted_Data_Out = {tb_Data_In[ 9:0], tb_Data_In[31:10]};    end
            5'h17   : begin tb_Shifted_Data_Out = {tb_Data_In[ 8:0], tb_Data_In[31: 9]};    end
            5'h18   : begin tb_Shifted_Data_Out = {tb_Data_In[ 7:0], tb_Data_In[31: 8]};    end
            5'h19   : begin tb_Shifted_Data_Out = {tb_Data_In[ 6:0], tb_Data_In[31: 7]};    end
            5'h1A   : begin tb_Shifted_Data_Out = {tb_Data_In[ 5:0], tb_Data_In[31: 6]};    end
            5'h1B   : begin tb_Shifted_Data_Out = {tb_Data_In[ 4:0], tb_Data_In[31: 5]};    end
            5'h1C   : begin tb_Shifted_Data_Out = {tb_Data_In[ 3:0], tb_Data_In[31: 4]};    end
            5'h1D   : begin tb_Shifted_Data_Out = {tb_Data_In[ 2:0], tb_Data_In[31: 3]};    end
            5'h1E   : begin tb_Shifted_Data_Out = {tb_Data_In[ 1:0], tb_Data_In[31: 2]};    end
            5'h1F   : begin tb_Shifted_Data_Out = {tb_Data_In[   0], tb_Data_In[31: 1]};    end
            default : begin {tb_Shifted_Data_Out , tb_Carry_Out} = 33'h1FFFFFFFF;           end
        endcase
    end
endtask

// Perform Rotate_Right Operation
task Perform_Rotate_Right();
    begin
        tb_Carry_Out = 1'b0;
        case (tb_Shift_Bits_Length_In)
            5'h00   : begin tb_Shifted_Data_Out = tb_Data_In                           ;   end
            5'h01   : begin tb_Shifted_Data_Out = {tb_Data_In[   0], tb_Data_In[31: 1]};   end
            5'h02   : begin tb_Shifted_Data_Out = {tb_Data_In[ 1:0], tb_Data_In[31: 2]};   end
            5'h03   : begin tb_Shifted_Data_Out = {tb_Data_In[ 2:0], tb_Data_In[31: 3]};   end
            5'h04   : begin tb_Shifted_Data_Out = {tb_Data_In[ 3:0], tb_Data_In[31: 4]};   end
            5'h05   : begin tb_Shifted_Data_Out = {tb_Data_In[ 4:0], tb_Data_In[31: 5]};   end
            5'h06   : begin tb_Shifted_Data_Out = {tb_Data_In[ 5:0], tb_Data_In[31: 6]};   end
            5'h07   : begin tb_Shifted_Data_Out = {tb_Data_In[ 6:0], tb_Data_In[31: 7]};   end
            5'h08   : begin tb_Shifted_Data_Out = {tb_Data_In[ 7:0], tb_Data_In[31: 8]};   end
            5'h09   : begin tb_Shifted_Data_Out = {tb_Data_In[ 8:0], tb_Data_In[31: 9]};   end
            5'h0A   : begin tb_Shifted_Data_Out = {tb_Data_In[ 9:0], tb_Data_In[31:10]};   end
            5'h0B   : begin tb_Shifted_Data_Out = {tb_Data_In[10:0], tb_Data_In[31:11]};   end
            5'h0C   : begin tb_Shifted_Data_Out = {tb_Data_In[11:0], tb_Data_In[31:12]};   end
            5'h0D   : begin tb_Shifted_Data_Out = {tb_Data_In[12:0], tb_Data_In[31:13]};   end
            5'h0E   : begin tb_Shifted_Data_Out = {tb_Data_In[13:0], tb_Data_In[31:14]};   end
            5'h0F   : begin tb_Shifted_Data_Out = {tb_Data_In[14:0], tb_Data_In[31:15]};   end
            5'h10   : begin tb_Shifted_Data_Out = {tb_Data_In[15:0], tb_Data_In[31:16]};   end
            5'h11   : begin tb_Shifted_Data_Out = {tb_Data_In[16:0], tb_Data_In[31:17]};   end
            5'h12   : begin tb_Shifted_Data_Out = {tb_Data_In[17:0], tb_Data_In[31:18]};   end
            5'h13   : begin tb_Shifted_Data_Out = {tb_Data_In[18:0], tb_Data_In[31:19]};   end
            5'h14   : begin tb_Shifted_Data_Out = {tb_Data_In[19:0], tb_Data_In[31:20]};   end
            5'h15   : begin tb_Shifted_Data_Out = {tb_Data_In[20:0], tb_Data_In[31:21]};   end
            5'h16   : begin tb_Shifted_Data_Out = {tb_Data_In[21:0], tb_Data_In[31:22]};   end
            5'h17   : begin tb_Shifted_Data_Out = {tb_Data_In[22:0], tb_Data_In[31:23]};   end
            5'h18   : begin tb_Shifted_Data_Out = {tb_Data_In[23:0], tb_Data_In[31:24]};   end
            5'h19   : begin tb_Shifted_Data_Out = {tb_Data_In[24:0], tb_Data_In[31:25]};   end
            5'h1A   : begin tb_Shifted_Data_Out = {tb_Data_In[25:0], tb_Data_In[31:26]};   end
            5'h1B   : begin tb_Shifted_Data_Out = {tb_Data_In[26:0], tb_Data_In[31:27]};   end
            5'h1C   : begin tb_Shifted_Data_Out = {tb_Data_In[27:0], tb_Data_In[31:28]};   end
            5'h1D   : begin tb_Shifted_Data_Out = {tb_Data_In[28:0], tb_Data_In[31:29]};   end
            5'h1E   : begin tb_Shifted_Data_Out = {tb_Data_In[29:0], tb_Data_In[31:30]};   end
            5'h1F   : begin tb_Shifted_Data_Out = {tb_Data_In[30:0], tb_Data_In[31]}   ;   end
            default : begin {tb_Shifted_Data_Out , tb_Carry_Out} = 33'h1FFFFFFFF;          end
        endcase
    end
endtask

// Perform Rotate_Left_Through_Carry Operation
task Perform_Rotate_Left_Through_Carry();
    begin
        case (tb_Shift_Bits_Length_In)
            5'h00   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Carry_In     , tb_Data_In                    };  end
            5'h01   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[31:0], tb_Carry_In                   };  end
            5'h02   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[30:0], tb_Carry_In, tb_Data_In[31]   };  end
            5'h03   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[29:0], tb_Carry_In, tb_Data_In[31:30]};  end
            5'h04   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[28:0], tb_Carry_In, tb_Data_In[31:29]};  end
            5'h05   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[27:0], tb_Carry_In, tb_Data_In[31:28]};  end
            5'h06   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[26:0], tb_Carry_In, tb_Data_In[31:27]};  end
            5'h07   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[25:0], tb_Carry_In, tb_Data_In[31:26]};  end
            5'h08   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[24:0], tb_Carry_In, tb_Data_In[31:25]};  end
            5'h09   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[23:0], tb_Carry_In, tb_Data_In[31:24]};  end
            5'h0A   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[22:0], tb_Carry_In, tb_Data_In[31:23]};  end
            5'h0B   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[21:0], tb_Carry_In, tb_Data_In[31:22]};  end
            5'h0C   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[20:0], tb_Carry_In, tb_Data_In[31:21]};  end
            5'h0D   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[19:0], tb_Carry_In, tb_Data_In[31:20]};  end
            5'h0E   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[18:0], tb_Carry_In, tb_Data_In[31:19]};  end
            5'h0F   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[17:0], tb_Carry_In, tb_Data_In[31:18]};  end
            5'h10   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[16:0], tb_Carry_In, tb_Data_In[31:17]};  end
            5'h11   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[15:0], tb_Carry_In, tb_Data_In[31:16]};  end
            5'h12   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[14:0], tb_Carry_In, tb_Data_In[31:15]};  end
            5'h13   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[13:0], tb_Carry_In, tb_Data_In[31:14]};  end
            5'h14   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[12:0], tb_Carry_In, tb_Data_In[31:13]};  end
            5'h15   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[11:0], tb_Carry_In, tb_Data_In[31:12]};  end
            5'h16   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[10:0], tb_Carry_In, tb_Data_In[31:11]};  end
            5'h17   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 9:0], tb_Carry_In, tb_Data_In[31:10]};  end
            5'h18   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 8:0], tb_Carry_In, tb_Data_In[31: 9]};  end
            5'h19   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 7:0], tb_Carry_In, tb_Data_In[31: 8]};  end
            5'h1A   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 6:0], tb_Carry_In, tb_Data_In[31: 7]};  end
            5'h1B   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 5:0], tb_Carry_In, tb_Data_In[31: 6]};  end
            5'h1C   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 4:0], tb_Carry_In, tb_Data_In[31: 5]};  end
            5'h1D   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 3:0], tb_Carry_In, tb_Data_In[31: 4]};  end
            5'h1E   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 2:0], tb_Carry_In, tb_Data_In[31: 3]};  end
            5'h1F   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 1:0], tb_Carry_In, tb_Data_In[31: 2]};  end
            default : begin {tb_Shifted_Data_Out , tb_Carry_Out} = 33'h1FFFFFFFF;                                       end
        endcase
    end
endtask

// Perform Rotate_Right_Through_Carry Operation
task Perform_Rotate_Right_Through_Carry();
    begin
        case (tb_Shift_Bits_Length_In)
            5'h00   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Carry_In     , tb_Data_In                    };  end
            5'h01   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[   0], tb_Carry_In, tb_Data_In[31: 1]};  end
            5'h02   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 1:0], tb_Carry_In, tb_Data_In[31: 2]};  end
            5'h03   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 2:0], tb_Carry_In, tb_Data_In[31: 3]};  end
            5'h04   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 3:0], tb_Carry_In, tb_Data_In[31: 4]};  end
            5'h05   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 4:0], tb_Carry_In, tb_Data_In[31: 5]};  end
            5'h06   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 5:0], tb_Carry_In, tb_Data_In[31: 6]};  end
            5'h07   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 6:0], tb_Carry_In, tb_Data_In[31: 7]};  end
            5'h08   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 7:0], tb_Carry_In, tb_Data_In[31: 8]};  end
            5'h09   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 8:0], tb_Carry_In, tb_Data_In[31: 9]};  end
            5'h0A   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[ 9:0], tb_Carry_In, tb_Data_In[31:10]};  end
            5'h0B   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[10:0], tb_Carry_In, tb_Data_In[31:11]};  end
            5'h0C   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[11:0], tb_Carry_In, tb_Data_In[31:12]};  end
            5'h0D   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[12:0], tb_Carry_In, tb_Data_In[31:13]};  end
            5'h0E   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[13:0], tb_Carry_In, tb_Data_In[31:14]};  end
            5'h0F   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[14:0], tb_Carry_In, tb_Data_In[31:15]};  end
            5'h10   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[15:0], tb_Carry_In, tb_Data_In[31:16]};  end
            5'h11   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[16:0], tb_Carry_In, tb_Data_In[31:17]};  end
            5'h12   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[17:0], tb_Carry_In, tb_Data_In[31:18]};  end
            5'h13   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[18:0], tb_Carry_In, tb_Data_In[31:19]};  end
            5'h14   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[19:0], tb_Carry_In, tb_Data_In[31:20]};  end
            5'h15   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[20:0], tb_Carry_In, tb_Data_In[31:21]};  end
            5'h16   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[21:0], tb_Carry_In, tb_Data_In[31:22]};  end
            5'h17   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[22:0], tb_Carry_In, tb_Data_In[31:23]};  end
            5'h18   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[23:0], tb_Carry_In, tb_Data_In[31:24]};  end
            5'h19   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[24:0], tb_Carry_In, tb_Data_In[31:25]};  end
            5'h1A   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[25:0], tb_Carry_In, tb_Data_In[31:26]};  end
            5'h1B   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[26:0], tb_Carry_In, tb_Data_In[31:27]};  end
            5'h1C   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[27:0], tb_Carry_In, tb_Data_In[31:28]};  end
            5'h1D   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[28:0], tb_Carry_In, tb_Data_In[31:29]};  end
            5'h1E   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[29:0], tb_Carry_In, tb_Data_In[31:30]};  end
            5'h1F   : begin {tb_Carry_Out, tb_Shifted_Data_Out} = {tb_Data_In[30:0], tb_Carry_In, tb_Data_In[31]   };  end
            default : begin {tb_Shifted_Data_Out , tb_Carry_Out} = 33'h1FFFFFFFF;                                      end
        endcase
    end
endtask



// --------------------------------------------------
// Testbench Logic
// --------------------------------------------------
initial
    begin
        Open_File("../../Transcript/Barrel_Shifter_32_Bit_tb - Transcript.txt");

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("Barrel_Shifter_32_Bit - Test"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Write_To_File_And_Display($sformatf("All Operations"));
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));

        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, LOGICAL_SHIFT_LEFT        , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h00, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h01, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h03, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h04, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h05, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h06, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h07, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h08, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h09, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h0A, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h0B, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h0C, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h0D, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h0E, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h0F, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h10, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h11, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h12, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h13, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h14, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h15, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h16, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h17, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h18, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h19, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h1A, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h1B, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h1C, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h1D, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h1E, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_LEFT        , 5'h1F, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, LOGICAL_SHIFT_RIGHT       , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h00, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h01, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h03, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h04, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h05, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h06, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h07, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h08, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h09, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h0A, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h0B, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h0C, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h0D, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h0E, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h0F, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h10, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h11, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h12, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h13, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h14, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h15, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h16, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h17, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h18, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h19, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h1A, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h1B, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h1C, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h1D, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h1E, $random(), $random());
        Check_Barrel_Shifter(1'b1, LOGICAL_SHIFT_RIGHT       , 5'h1F, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ARITHMETIC_SHIFT_LEFT     , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h00, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h01, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h03, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h04, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h05, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h06, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h07, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h08, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h09, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h0A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h0B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h0C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h0D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h0E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h0F, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h10, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h11, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h12, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h13, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h14, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h15, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h16, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h17, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h18, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h19, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h1A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h1B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h1C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h1D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h1E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_LEFT     , 5'h1F, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ARITHMETIC_SHIFT_RIGHT    , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h00, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h01, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h03, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h04, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h05, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h06, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h07, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h08, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h09, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h0A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h0B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h0C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h0D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h0E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h0F, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h10, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h11, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h12, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h13, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h14, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h15, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h16, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h17, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h18, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h19, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h1A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h1B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h1C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h1D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h1E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ARITHMETIC_SHIFT_RIGHT    , 5'h1F, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ROTATE_LEFT               , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h00, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h01, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h03, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h04, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h05, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h06, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h07, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h08, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h09, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h0A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h0B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h0C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h0D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h0E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h0F, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h10, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h11, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h12, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h13, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h14, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h15, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h16, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h17, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h18, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h19, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h1A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h1B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h1C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h1D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h1E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT               , 5'h1F, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ROTATE_RIGHT              , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h00, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h01, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h03, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h04, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h05, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h06, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h07, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h08, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h09, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h0A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h0B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h0C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h0D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h0E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h0F, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h10, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h11, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h12, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h13, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h14, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h15, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h16, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h17, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h18, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h19, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h1A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h1B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h1C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h1D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h1E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT              , 5'h1F, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ROTATE_LEFT_THROUGH_CARRY , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h00, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h01, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h03, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h04, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h05, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h06, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h07, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h08, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h09, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h0A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h0B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h0C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h0D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h0E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h0F, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h10, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h11, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h12, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h13, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h14, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h15, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h16, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h17, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h18, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h19, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h1A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h1B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h1C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h1D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h1E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_LEFT_THROUGH_CARRY , 5'h1F, $random(), $random());
        Write_To_File_And_Display($sformatf("\n--------------------------------------------------\n"));
        Check_Barrel_Shifter(1'b0, ROTATE_RIGHT_THROUGH_CARRY, 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h00, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h01, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h02, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h03, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h04, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h05, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h06, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h07, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h08, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h09, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h0A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h0B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h0C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h0D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h0E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h0F, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h10, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h11, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h12, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h13, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h14, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h15, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h16, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h17, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h18, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h19, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h1A, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h1B, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h1C, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h1D, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h1E, $random(), $random());
        Check_Barrel_Shifter(1'b1, ROTATE_RIGHT_THROUGH_CARRY, 5'h1F, $random(), $random());
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
