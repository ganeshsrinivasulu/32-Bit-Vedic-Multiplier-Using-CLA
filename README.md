# 32-Bit Vedic Multiplier Using CLA

High-speed 32x32 Vedic Multiplier implemented using Urdhva Tiryakbhyam Sutra with Carry Look Ahead (CLA) Adder.

### Tool: Vivado 2026.1
### Language: Verilog HDL
### Target FPGA: xc7vx485tffg1157-1

## Features
- 32-bit x 32-bit multiplication -> 64-bit output
- Based on Ancient Vedic Mathematics - Urdhva Tiryak Sutra
- Uses 4x 16x16 Vedic modules internally
- CLA Adder for fast addition
- Low power and high speed compared to conventional multipliers

## Architecture
- Top Module: vedic_32x32
- Sub-modules: vedic_16x16, vedic_8x8, vedic_4x4, vedic_2x2
- Adder: CLA (Carry Look Ahead)

## Simulation Result
Test Case: FFFFFFFF * FFFFFFFF = FFFFFFFE00000001 - VERIFIED
- Behavioral Simulation: PASS
- Synthesized Design: PASS

## Files
- `vedic_32x32.v` - Main 32-bit Vedic Multiplier
- `vedic_32x32_tb.v` - Testbench

## How to Run
1. Open Vivado -> Create Project
2. Add vedic_32x32.v
3. Run Behavioral Simulation
4. Run Synthesis for FPGA utilization

Developed by Ganesh Srinivasulu
