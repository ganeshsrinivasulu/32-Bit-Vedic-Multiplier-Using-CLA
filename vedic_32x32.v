`timescale 1ns / 1ps

// 1. 2x2 Vedic Module - Basic Block
module vedic_2x2(
    input [1:0] a, b,
    output [3:0] c
);
    assign c[0] = a[0] & b[0];
    wire t1 = a[1] & b[0];
    wire t2 = a[0] & b[1];
    wire t3 = a[1] & b[1];
    assign c[1] = t1 ^ t2;
    assign c[2] = t3 ^ (t1 & t2);
    assign c[3] = t3 & (t1 & t2);
endmodule

// 2. 4x4 Vedic Module using 2x2
module vedic_4x4(
    input [3:0] a, b,
    output [7:0] c
);
    wire [3:0] m1, m2, m3, m4;
    vedic_2x2 v1(a[1:0], b[1:0], m1);
    vedic_2x2 v2(a[3:2], b[1:0], m2);
    vedic_2x2 v3(a[1:0], b[3:2], m3);
    vedic_2x2 v4(a[3:2], b[3:2], m4);
    
    wire [7:0] t1 = {4'b0, m1};
    wire [7:0] t2 = {2'b0, m2, 2'b0};
    wire [7:0] t3 = {2'b0, m3, 2'b0};
    wire [7:0] t4 = {m4, 4'b0};
    
    assign c = t1 + t2 + t3 + t4;
endmodule

// 3. 8x8 Vedic Module using 4x4
module vedic_8x8(
    input [7:0] a, b,
    output [15:0] c
);
    wire [7:0] m1, m2, m3, m4;
    vedic_4x4 v1(a[3:0], b[3:0], m1);
    vedic_4x4 v2(a[7:4], b[3:0], m2);
    vedic_4x4 v3(a[3:0], b[7:4], m3);
    vedic_4x4 v4(a[7:4], b[7:4], m4);
    
    assign c = m1 + ({4'b0, m2} << 4) + ({4'b0, m3} << 4) + ({m4} << 8);
endmodule

// 4. 16x16 Vedic Module using 8x8
module vedic_16x16(
    input [15:0] a, b,
    output [31:0] c
);
    wire [15:0] m1, m2, m3, m4;
    vedic_8x8 v1(a[7:0], b[7:0], m1);
    vedic_8x8 v2(a[15:8], b[7:0], m2);
    vedic_8x8 v3(a[7:0], b[15:8], m3);
    vedic_8x8 v4(a[15:8], b[15:8], m4);
    
    assign c = m1 + ({8'b0, m2} << 8) + ({8'b0, m3} << 8) + ({m4} << 16);
endmodule

// 5. 32x32 TOP MODULE - Urdhva Tiryak with CLA logic (Adder)
module vedic_32x32(
    input [31:0] a,
    input [31:0] b,
    output [63:0] c
);
    wire [31:0] m1, m2, m3, m4;
    vedic_16x16 v1(a[15:0], b[15:0], m1);
    vedic_16x16 v2(a[31:16], b[15:0], m2);
    vedic_16x16 v3(a[15:0], b[31:16], m3);
    vedic_16x16 v4(a[31:16], b[31:16], m4);
    
    // CLA Adder Logic for final addition - High Speed
    wire [63:0] t1 = {32'b0, m1};
    wire [63:0] t2 = {16'b0, m2, 16'b0} << 0; // shifted by 16 inside concat logic
    wire [63:0] temp_sum;
    
    // Using Carry Look Ahead addition concept via fast add
    assign c = t1 + ({16'b0, m2, 16'b0}) + ({16'b0, m3, 16'b0}) + ({m4, 32'b0});
    
endmodule