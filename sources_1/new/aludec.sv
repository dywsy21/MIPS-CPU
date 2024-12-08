`timescale 1ns / 1ps


module aludec(
    input logic [5:0] funct,
    input logic [2:0] aluop,
    output logic [2:0] alucontrol
    );

    // alu decoder
    always_comb begin
        case (aluop)
            3'b000: alucontrol <= 3'b010; // add
            3'b001: alucontrol <= 3'b110; // sub
            3'b011: alucontrol <= 3'b000; // and
            3'b100: alucontrol <= 3'b001; // or
            default: case (funct)
                    6'b100000: alucontrol <= 3'b010; // add
                    6'b100010: alucontrol <= 3'b110; // sub
                    6'b100100: alucontrol <= 3'b000; // and
                    6'b100101: alucontrol <= 3'b001; // or
                    6'b101010: alucontrol <= 3'b111; // slt
                    6'b001100: alucontrol <= 3'b000; // andi
                    6'b001101: alucontrol <= 3'b001; // ori
                    default: alucontrol <= 3'bxxx;
                endcase
        endcase
    end



endmodule
