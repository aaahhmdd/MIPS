module InstructionMemory(
    input [31:0] address,
    output [31:0] instruction
);
    reg [31:0] memory [0:1023]; // 4 KB instruction memory (1024 instructions)
    integer i ;

    initial begin // 
        // initialize Add, Sub, LW, SW, and Branch instructions 
        //memory[0] = 32'b000000_00000_00000_00000_00000_000000; // 0
        //memory[1] = 32'b000000_00000_00000_00000_00000_000000; // 0
        //memory[1] = 32'b000000_00000_00000_00000_00000_000000; // 0
        memory[0] = 32'b000000_00000_00000_00000_00000_000000; // 0
        
        memory[1] = 32'b000000_00010_00011_00001_00000_100000; // ADD R1 = R2 + R3 32'h00430820;
        memory[2] = 32'b000000_00101_00110_00100_00000_100010; // SUB R4 = R5 - R6 32'h00C51822;
        memory[3] = 32'b100011_01000_00111_00000_00000_000100; // LW R7, 4(R8)     32'h81070004;
        memory[4] = 32'b101011_01010_01001_00000_00000_001000; // SW R9, 8(R10)    32'h85520008;
        memory[5] = 32'b000100_01011_01100_1111111111111110;  // BEQ R11, R12, -2  32'h116CFFFE;
        // Fill remaining memory with zeros 
        for ( i = 6; i < 1024; i = i + 1) begin
            memory[i] = 32'b000000_00000_00000_00000_00000_000000; 
        end
    end

    assign instruction = memory[address[11:2]];

    //assign instruction = {memory[address], memory[address+1], 
    //                memory[address+2], memory[address+3]}; 
endmodule
/*
memory[0] = 32'h00430820; // ADD R1 = R2 + R3
memory[1] = 32'h00C51822; // SUB R4 = R5 - R6
memory[2] = 32'h81070004; // LW R7, 4(R8)
memory[3] = 32'h85520008; // SW R9, 8(R10)
memory[4] = 32'h116CFFFE; // BEQ R11, R12, -2
*/