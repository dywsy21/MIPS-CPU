`timescale 1ns / 1ps

module alu(
    input logic [31:0] srca, srcb,
    input logic [2:0] alucontrol,
    output logic [31:0] aluout,
    output logic zero
    );

always_comb begin
    aluout = 32'b0;
    case (alucontrol)
        3'b000 : aluout = srca & srcb;
        3'b001 : aluout = srca | srcb;
        3'b010 : aluout = srca + srcb;
        3'b110 : aluout = srca - srcb;
        3'b101 : aluout = srca * srcb;
        3'b111 : begin
                    if(srca < srcb) aluout = 32'b1;
                    else aluout = 32'b0;
                end
        default : aluout = 32'b0;
    endcase
end

//zero flag
always_comb begin
    zero = (aluout == 32'b0);
end 

endmodule
