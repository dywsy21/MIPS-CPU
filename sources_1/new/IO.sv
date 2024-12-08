`timescale 1ns / 1ps

module IO(
    // CPU to IO
    input logic clk, reset, pread, pwrite, 
    input logic [1:0] addr,
    input logic [11:0] pwritedata,
    output logic [31:0] preaddata,
    
    // IO to x7seg
    input logic BTNL, BTNR,
    input logic [15:0] SW,
    output logic [11:0] led
    );

    logic [1:0] status;
    logic [15:0] sw1;
    logic [11:0] led1;

    always_ff @(posedge clk) begin
        if(reset) begin
            status <= 2'b00;
            led1 <= 12'h00;
            sw1 <= 16'h00;
        end else begin
            if(BTNR) begin
                status[1] <= 1;
                sw1 <= SW;
            end
            if(BTNL) begin
                status[0] <= 1;
                led <= led1;
            end
            if(pwrite & (addr == 2'b01)) begin
                led1 <= pwritedata;
                status[0] <= 0;
            end
        end
    end

    logic [7:0] decimal_15_8, decimal_7_0;
    always_comb begin
        if(pread) begin
            decimal_15_8 = (sw1[15:12] * 10 + sw1[11:8]);
            decimal_7_0 = (sw1[7:4] * 10 + sw1[3:0]);
            case(addr)
                // 2'b11: preaddata = {24'b0, sw1[15:8]};
                // 2'b10: preaddata = {24'b0, sw1[7:0]};
                2'b11: preaddata = {24'b0, decimal_15_8[7:0]};
                2'b10: preaddata = {24'b0, decimal_7_0[7:0]};
                2'b00: preaddata = {24'b0, 6'b0, status};
                default: preaddata = 32'b0;
            endcase
        end else preaddata = 32'b0;
    end

endmodule