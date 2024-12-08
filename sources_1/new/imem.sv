`timescale 1ns / 1ps

module imem(
    input logic [5:0] a,
    output logic [31:0] rd
    );

    logic [31:0] RAM [63:0];

    initial begin
        // $readmemh("memfile.dat", RAM);
        $readmemh("test_new_instrs.dat", RAM);
        // $readmemh("test_fail.dat", RAM);
        // $readmemh("test_andi.dat", RAM);
        // $readmemh("test_ori.dat", RAM);
        // $readmemh("test_bne.dat", RAM);
        // $readmemh("test_beq.dat", RAM);
    end

    assign rd = RAM[a];
endmodule
