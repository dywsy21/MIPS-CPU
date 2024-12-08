`timescale 1ns / 1ps

// // use this version of top module if you wish to test the cpu itself
// module top(
//     input logic clk, reset,
//     output logic [31:0] writedata, dataadr,
//     output logic memwrite
//     );

//     logic [31:0] pc, instr, readdata;

//     mips mips(clk, reset, pc, instr, memwrite, dataadr, writedata, readdata);
//     imem imem(pc[7:2], instr);
//     dmem dmem(clk, memwrite, dataadr, writedata, readdata);
// endmodule

module top(
    input logic CLK100MHZ, BTNC, BTNL, BTNR,
    input logic [15:0] SW,
    output logic [7:0] AN,
    output logic [6:0] A2G,
    output logic DP
    );

    logic [31:0] pc, instr;
    imem imem(pc[7:2], instr);

    logic write;
    logic [31:0] dataadr, writedata, readdata;

    mips mips(CLK100MHZ, BTNC, pc, instr, write, dataadr, writedata, readdata);

    DMemoryDecoder dmd(CLK100MHZ, write, dataadr[7:0], writedata, readdata, BTNC, BTNL, BTNR, SW, AN, A2G, DP);
endmodule
