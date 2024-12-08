`timescale 1ns / 1ps

module controller(
    input logic [5:0] op, funct,
    input logic zero,
    output logic memtoreg, memwrite, pcsrc, 
    output logic [1:0] alusrc, 
    output logic regdst, regwrite, jump,
    output logic [2:0] alucontrol
    );

    logic [2:0] aluop;
    logic [1:0] branch;

    maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);
    aludec ad(funct, aluop, alucontrol);
    // assign pcsrc = branch & zero;
    assign pcsrc = (branch == 2'b00) ? 1'b0 : (branch == 2'b01) ? zero : ~zero;
    
endmodule
