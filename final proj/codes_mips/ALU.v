module ALU(
    input [31:0] input1,
    input [31:0] input2,
    input [3:0] control,
    output reg [31:0] result,
    output zero
);
    always @(*) begin
        case (control)
            4'b0010: result = input1 + input2; // ADD
            4'b0110: result = input1 - input2; // SUB
            default: result = 0; // Undefined
        endcase
    end

    assign zero = (result == 0);
endmodule
