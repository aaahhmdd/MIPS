module MUX2to1(
    input [31:0] in0,           // Input 0
    input [31:0] in1,           // Input 1
    input select,               // Select signal (1 or 0)
    output reg [31:0] out       // Output
);
    always @(*) begin
        if (select)
            out = in1;          // Select in1 if select is 1
        else
            out = in0;          // Select in0 if select is 0
    end
endmodule
