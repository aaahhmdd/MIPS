module IF_ID_Reg(
    input clk,                  // Clock signal
    input reset,                // Reset signal
    input [31:0] instr_in,      // Instruction input
    input [31:0] PC_in,         // PC input
    output reg [31:0] instr_out,// Instruction output
    output reg [31:0] PC_out    // PC output
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            instr_out <= 32'b0;
            PC_out <= 32'b0;
        end else begin
            instr_out <= instr_in;
            PC_out <= PC_in;
        end
    end
endmodule
