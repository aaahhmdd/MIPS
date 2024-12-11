module ProgramCounter(
    input clk,
    input reset,
    input [31:0] pc_next,
    output reg [31:0] pc_current
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc_current <= 0; // Reset PC to 0
        else
            pc_current <= pc_next; // Update PC
    end
endmodule
