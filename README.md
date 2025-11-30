# 🧩 Verilog_Codes

This repository contains a collection of **RTL design modules written in Verilog** along with their corresponding **functional testbenches written in SystemVerilog**.  

Each module focuses on illustrating key concepts in **digital design, simulation, and verification**.

---

## Table of Contents

- [🧩 Verilog\_Codes](#-verilog_codes)
  - [Table of Contents](#table-of-contents)
  - [📂 Repository Structure](#-repository-structure)
  - [📁 Individual Module Folder Structure](#-individual-module-folder-structure)
  - [📝 Note](#-note)
  - [⚙️ Tools and Environment](#️-tools-and-environment)
  - [🧠 Key Learning Areas](#-key-learning-areas)
  - [🧪 Testbench Overview](#-testbench-overview)
  - [📄 License](#-license)
  - [👤 Author](#-author)
  - [🌟 Acknowledgements](#-acknowledgements)

---

## 📂 Repository Structure

``` md
🗄️ Verilog Codes
    📂 Arithmetic and Logic Modules
        📑 Adder with Look Ahead Carry Generator
        📑 ALU
        📑 Barrel Shifter
        📑 Basic Arithmetic
        📑 Comparator
        📑 Unsigned Array Multiplier
    📂 Counters and Timers
        📑 Decade Counter
        📑 Gray Counter
        📑 Johnson Counter
        📑 MOD Counter
        📑 Ring Counter
        📑 Timer
        📑 Up-Down MOD Counter
    📂 Data Selectors and Converters
        📑 Binary Gray Converter
        📑 Decoder
        📑 DeMultiplxer (DEMUX)
        📑 Encoder
        📑 Multiplxer (MUX)
    📂 Data Storage
        📑 Queue (FIFO)
        📑 SRAM - Dual Port
        📑 SRAM - Single Port
        📑 SROM - Dual Port
        📑 SROM - Single Port
        📑 Stack (LIFO)
    📂 Flip Flops
        📑 Flip Flop
```

---

## 📁 Individual Module Folder Structure

``` md
src/                      → Verilog RTL source files
tb/                       → SystemVerilog Testbench Files
Transcript/               → Transcript prints of the SystemVerilog Testbench
Results_Documentation/    → Results such as RTL Netlist and Simulation Waveforms
docs/                     → Documentation, Waveforms or Diagrams (If Any)
```

---

## 📝 Note

```md
- To view the Transcripts and vcd files:
  1) Create a folder named "Transcript" and "vcd_Files" in the Project folder.
  2) Run the Simulation, and you can view the Transcript and vcd file within these folders.

- The Simulation Waveforms Results with the "Results_Documentation/" folder, may not be not be clearly visible, and these images are not taken for every possible combinations.
```

---

## ⚙️ Tools and Environment

**Quartus Prime Lite** was used to compile the RTL Codes.

Simulation was performed using **Intel QuestaSim Starter Edition**.

**GTKWave** was used to view the vcd files.

---

## 🧠 Key Learning Areas

This repository covers a variety of topics in digital design and verification:

- Combinational and Sequential Circuits  
- Counters, Shift Registers, Encoders, Decoders  
- Finite State Machines (FSMs)  
- Arithmetic and Logic Units (ALUs)  
- Pipelining and Timing Control  
- Testbench Structuring and Verification Techniques  

---

## 🧪 Testbench Overview

Each SystemVerilog testbench includes:

- DUT instantiation  
- Stimulus generation  
- Monitors and checkers  
- Output waveform dumping (`.vcd` files)  
- Assertions (for functional verification where applicable)  

---

## 📄 License

This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

**Prasad N. Ghatol**  
🔗 [GitHub Profile](https://github.com/Prasad-N-Ghatol)

---

## 🌟 Acknowledgements

This repository is created for educational and reference purposes to help students, researchers, and hardware enthusiasts about **RTL design and verification using Verilog and SystemVerilog**.
