`timescale 1ns / 1ps

module datapath(
    input logic clk, reset, memtoreg, pcsrc,
    input logic [1:0] alusrc, 
    input logic regdst, regwrite, jump,
    input logic [2:0] alucontrol,
    output logic zero,
    output logic [31:0] pc,
    input logic [31:0] instr,
    output logic [31:0] aluout, writedata,
    input logic [31:0] readdata
    );

    logic [4:0] writereg;
    logic [31:0] pcnext, pcnextbr, pcplus4, pcbranch, signimm, zeroimm, signimmsh, srca, srcb, result;

    // next PC logic
    flopr #(.WIDTH(32)) pcnextflop(clk, reset, pcnext, pc);
    adder pcadder(pc, 32'b100, pcplus4);
    s12 immsh(signimm, signimmsh);
    adder pcadd2(pcplus4, signimmsh, pcbranch);
    mux2 #(.WIDTH(32)) pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
    mux2 #(.WIDTH(32)) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);

    // register file logic
    regfile rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, srca, writedata);
    mux2 #(5) wrmux(instr[20:16], instr[15:11], regdst, writereg);
    mux2 #(32) resmux(aluout, readdata, memtoreg, result);
    signext se(instr[15:0], signimm);
    zeroext ze(instr[15:0], zeroimm);

    // ALU logic
    // mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb);
    mux3 srcbmux(writedata, signimm, zeroimm, alusrc, srcb);
    alu alu1(srca, srcb, alucontrol, aluout, zero);

endmodule