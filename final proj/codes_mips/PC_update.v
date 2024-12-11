module pcUpdateLogic(
    input wire [31:0] pc_current,    // Current PC value
    input wire [31:0] branch_target, // Branch target address
    input wire [31:0] jump_target,   // Jump target address
    input wire branch_taken,         // Branch taken signal
    input wire jump,                 // Jump control signal
    output reg [31:0] pc_next        // Updated PC value
);

    always @(*) begin
        if (jump) begin
            pc_next = jump_target; // Handle jump instruction
        end else if (branch_taken) begin
            pc_next = branch_target; // Handle branch instruction
        end else begin
            pc_next = pc_current + 4; // Default: increment PC by 4
        end
    end

endmodule
