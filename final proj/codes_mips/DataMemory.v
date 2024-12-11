module DataMemory(
    input clk,
    input [11:0] addr,         // Address (word-aligned, 16KB memory)
    input [31:0] write_data,   // Data to write
    input mem_write,           // Write enable
    input mem_read,            // Read enable
    output reg [31:0] read_data // Data read
);

    reg [31:0] memory [0:4095]; // 16KB = 4096 words of 32-bit data
    integer i;

    // Initialize data memory
    initial begin
        memory[0] = 32'd100;  // Address 0 stores 100
        memory[1] = 32'd200;  // Address 4 stores 200
        memory[2] = 32'd300;  // Address 8 stores 300
        memory[3] = 32'd400;  // Address 12 stores 400

        // Fill remaining memory with zeros
        for (i = 4; i < 1024; i = i + 1) begin
            memory[i] = 32'b0;
        end
    end

    // Write logic
    always @(posedge clk) begin
        if (mem_write) begin
            memory[addr] <= write_data;
        end
    end

    // Read logic
    always @(*) begin
        if (mem_read) begin
            read_data = memory[addr];
        end 
    end

endmodule
