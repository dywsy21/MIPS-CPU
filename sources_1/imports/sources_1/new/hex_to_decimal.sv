module hex_to_decimal(
    input logic [11:0] hex,
    output logic [11:0] decimal
);

    logic [13:0] temp_decimal; // To hold up to 4095 (maximum value of 12-bit hex)

    always_comb begin
        decimal = 12'b0;
        temp_decimal = hex[11:0]; 

        decimal[11:8] = temp_decimal / 100;
        decimal[7:4] = (temp_decimal % 100) / 10;
        decimal[3:0] = temp_decimal % 10;
    end
endmodule