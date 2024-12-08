`timescale 1ns / 1ps

module mux3(
    input logic [31:0] d0, d1, d2,
    input logic [1:0] s,
    output logic [31:0] y
    );

    // 三选一复用器
    assign y = (s == 2'b00) ? d0 : (s == 2'b01) ? d1 : d2;

endmodule
