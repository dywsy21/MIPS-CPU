`timescale 1ns / 1ps


module DMemoryDecoder(
    input logic clk, writeEn,
    input logic [7:0] addr,
    input logic [31:0] writedata,
    output logic [31:0] readdata,
    input logic reset, BTNL, BTNR,
    input logic [15:0] SW,
    output logic [7:0] AN,
    output logic [6:0] A2G,
    output logic DP
    );

    // WE of dmem
    logic memwrite, pwrite;
    always_comb begin : write_decision
        if(addr[7]) begin
            pwrite = writeEn;
            memwrite = 1'b0;
        end 
        else begin
            pwrite = 1'b0;
            memwrite = writeEn;
        end
    end

    // dmem instantiation
    logic [31:0] readdata1;
    dmem dmem(clk, memwrite, addr, writedata, readdata1);

    // IO instantiation
    logic [31:0] readdata2;
    logic [11:0] calc_result;
    IO io(clk, reset, addr[7], pwrite, addr[3:2], writedata[11:0], readdata2, BTNL, BTNR, SW, calc_result);

    // readdata out
    assign readdata = addr[7] ? readdata2 : readdata1;

    // transform calc_result to decimal
    logic [11:0] display_calc_result;
    hex_to_decimal h2d(.hex(calc_result), .decimal(display_calc_result));

    // 7-seg instantiation
    logic [31:0] x7seg_data;
    assign x7seg_data = {SW, 4'b1111, display_calc_result}; // 'hF for equal sign
    x7seg x7seg(x7seg_data, clk, reset, A2G, AN, DP);
endmodule
