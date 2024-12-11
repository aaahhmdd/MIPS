module ControlUnit(
    input [5:0] opcode,      // Opcode from instruction[31:26]
    output reg RegDst,       // Register destination
    output reg Branch,       // Branch signal
    output reg MemRead,      // Memory read
    output reg MemtoReg,     // Memory to register
    output reg [1:0] ALUOp,  // ALU operation control
    output reg MemWrite,     // Memory write
    output reg ALUSrc,       // ALU source (immediate or register)
    output reg RegWrite      // Register write
);
    always @(*) begin
        // Default values
        RegDst = 0;
        Branch = 0;
        MemRead = 0;
        MemtoReg = 0;
        ALUOp = 2'b00;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 0;

        case (opcode)
            6'b000000: begin // R-type instructions (ADD, SUB)
                RegDst = 1;
                ALUOp = 2'b10;
                RegWrite = 1;
            end
            6'b100011: begin // LW (load word)
                MemRead = 1;
                MemtoReg = 1;
                ALUSrc = 1;
                RegWrite = 1;
            end
            6'b101011: begin // SW (store word)
                MemWrite = 1;
                ALUSrc = 1;
            end
            6'b000100: begin // BEQ (branch equal)
                Branch = 1;
                ALUOp = 2'b01;
            end
            default: begin
                // Defaults already set above
            end
        endcase
    end
endmodule
