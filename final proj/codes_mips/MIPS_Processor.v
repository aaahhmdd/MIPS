////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Author: Ahmed Sameh
// 
// Project: MIPS Processor 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module MIPS_Processor(
    input clk,                // Clock signal
    input reset,              // Reset signal

    output [31:0] pc_current, // Current Program Counter
    output [31:0] result      // Result from the ALU or memory
);

    // Internal signals
    wire [31:0] instr;          // Instruction fetched from instruction memory
    wire [31:0] pc_next;        // Next PC value
    wire branch_taken, jump;    // Branch and Jump signals
    wire [31:0] branch_target;  // Target address for branch
    wire [31:0] jump_target;    // Target address for jump
    wire [31:0] alu_result;     // ALU result
    wire [31:0] read_data;      // Data read from memory
    wire [31:0] write_data;     // Data to write to memory
    wire [31:0] reg_data1, reg_data2; // Register file outputs
    wire [31:0] alu_input2;     // ALU second operand
    wire [4:0] write_reg;       // Register to write
    wire [31:0] sign_ext_imm;   // Sign-extended immediate
    wire [31:0] alu_operand2;   // Second ALU operand

    // Control signals
    wire RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch;
    wire [1:0] ALUOp;
    wire [3:0] alu_ctrl;

    // Program Counter (PC)
    ProgramCounter pc(
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .pc_current(pc_current)
    );

    // Instruction Memory (4KB)
    InstructionMemory instr_mem(
        .address(pc_current), // Address is word-aligned
        .instruction(instr)
    );

    // Control Unit
    ControlUnit control(
        .opcode(instr[31:26]),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );

    // Register File
    RegisterFile reg_file(
        .clk(clk),
        .RegWrite(RegWrite),
        .read_reg1(instr[25:21]),
        .read_reg2(instr[20:16]),
        .write_reg(write_reg),
        .write_data(result),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );

    // ALU Control
    ALUControl alu_control(
        .ALUOp(ALUOp),
        .funct(instr[5:0]),
        .ALUCtrl(alu_ctrl)
    );

    // Sign Extend Immediate
    assign sign_ext_imm = {{16{instr[15]}}, instr[15:0]}; // Sign extension

    // ALU
    ALU alu(
        .input1(reg_data1),
        .input2(alu_input2),
        .control(alu_ctrl),
        .zero(zero),
        .result(alu_result)
    );

    // ALU second operand
    assign alu_input2 = (ALUSrc) ? sign_ext_imm : reg_data2;

    // Data Memory (16KB)
    DataMemory data_mem(
        .clk(clk),
        .addr(alu_result[13:2]), // Address is word-aligned
        .write_data(reg_data2),
        .mem_write(MemWrite),
        .mem_read(MemRead),
        .read_data(read_data)
    );

    // Write-back logic
    assign result = (MemtoReg) ? read_data : alu_result;

    // Write Register selection
    assign write_reg = (RegDst) ? instr[15:11] : instr[20:16];

    // Branch logic
    assign branch_taken = Branch & zero;
    assign branch_target = pc_current + 4 + (sign_ext_imm << 2);

    // Jump target address
    assign jump_target = {pc_current[31:28], instr[25:0], 2'b00};

    // PC Update Logic
    pcUpdateLogic pc_update(
        .pc_current(pc_current),
        .branch_target(branch_target),
        .jump_target(jump_target),
        .branch_taken(branch_taken),
        .jump(jump),
        .pc_next(pc_next)
    );

endmodule
