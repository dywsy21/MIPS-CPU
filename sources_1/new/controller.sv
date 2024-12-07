`timescale 1ns / 1ps

module controller(
    input logic [5:0] op, funct,
    input logic zero,
    output logic memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump,
    output logic [2:0] alucontrol
    );

    logic [1:0] aluop;
    logic branch;

    maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);
    aludec ad(funct, aluop, alucontrol);
    assign pcsrc = branch & zero;
    
endmodule
