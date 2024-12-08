module x7seg( input  logic [31:0] data,
              input  logic        clk, 
              input  logic        clr, 
              output logic [6:0]  a2g, 
              output logic [7:0]  an,  
              output logic        dp );
    
    logic [2:0] s;           
    logic [3:0] digit;       
    logic [19:0] clkdiv;     
    
    assign dp = 1;           
    assign s = clkdiv[19:17];
    
    always_comb
        case(s)
            0:  digit = data[3:0];    
            1:  digit = data[7:4];    
            2:  digit = data[11:8];   
            3:  digit = data[15:12];  
            4:  digit = data[19:16];  
            5:  digit = data[23:20];  
            6:  digit = data[27:24];  
            7:  digit = data[31:28];  
            default: digit = 'h16;
        endcase
    
    always_comb
        case(s)
            0:  an = 8'b11111110;         
            1:  an = 8'b11111101;         
            2:  an = 8'b11111011;         
            3:  an = 8'b11110111;         
            4:  an = 8'b11101111;         
            5:  an = 8'b11011111;         
            6:  an = 8'b10111111;         
            7:  an = 8'b01111111;         
            default: an = 8'b11111111;    
        endcase
        
    always @(posedge clk, posedge clr)
      if(clr == 1) clkdiv <= 0;       
      else         clkdiv <= clkdiv + 1; 
    
    Hex7Seg H7(.digit(digit), .a2g(a2g));    
endmodule