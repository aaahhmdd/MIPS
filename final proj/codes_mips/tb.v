module MIPS_Testbench;

    reg clk;              // Clock signal
    reg reset;            // Reset signal
    wire [31:0] pc;       // Program Counter
    wire [31:0] result;   // Output of the processor (ALU or memory)

    // Instantiate MIPS Processor
    MIPS_Processor mips(
        .clk(clk),
        .reset(reset),
        .pc_current(pc),
        .result(result)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk; 
    end

    // Test sequence
    initial begin
        $monitor("At time %t: PC = %h, Result = %h", $time, pc, result);

        reset = 1;        // Apply reset
        @(negedge clk) reset = 0;    // Release reset after 20 time units

        // Allow simulation to run
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        @(negedge clk);
        
        $finish;          // Stop simulation
    end
endmodule
