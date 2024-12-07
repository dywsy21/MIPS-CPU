`timescale 1ns / 1ps

module testbench();

    logic clk, reset;
    logic [31:0] writedata, dataadr;
    logic memwrite;

    top dut(clk, reset, writedata, dataadr, memwrite);

    initial begin
        $display("Testbench started!");
        reset <= 1; #22; reset <= 0;
    end

    always begin
        clk <= 1; #5; clk <= 0; #5;
    end

    always_ff @( negedge clk ) begin
        if(memwrite) begin
            if(dataadr === 84 & writedata === 7) begin
                $display("Test Passed");
                $stop;
            end
            else if(dataadr !== 80) begin
                $display("Test Failed");
                $stop;
            end
        end
    end

endmodule
