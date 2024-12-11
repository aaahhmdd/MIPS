module WriteBackMUX(
    input [31:0] ALUResult,    // ALU result
    input [31:0] MemData,      // Data from memory
    input MemtoReg,            // Control signal for selecting between ALU or memory
    output [31:0] WriteData    // Write data to register file
);
    MUX2to1 mux(.in0(ALUResult), .in1(MemData), .select(MemtoReg), .out(WriteData));
endmodule
