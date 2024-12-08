`timescale 1ns / 1ps

module maindec(
    input logic [5:0] op,
    output logic memtoreg, memwrite, 
    output logic [1:0] branch, alusrc,
    output logic regdst, regwrite, jump,
    output logic [2:0] aluop
    );

    logic [11:0] controls;

    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop} = controls;

    always_comb begin
        case (op)
            6'b000000: controls = 12'b110000000010;
            6'b100011: controls = 12'b100100010000;
            6'b101011: controls = 12'b000100100000;
            6'b000100: controls = 12'b000001000001;
            6'b001000: controls = 12'b100100000000;
            6'b000010: controls = 12'b000000001000;
            6'b001100: controls = 12'b101000000011; // andi
            6'b000101: controls = 12'b000010000001; // bne
            6'b001101: controls = 12'b101000000100; // ori
            default: controls = 12'bxxxxxxxxx;
        endcase        
    end


endmodule
