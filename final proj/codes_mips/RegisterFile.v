module RegisterFile(
    input clk,
    input RegWrite,
    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    reg [31:0] registers [0:31];

     // Initialize registers
    initial begin
        registers[0] = 32'b0;  // $zero is always 0
        registers[1] = 32'd10; //  $r1 = 10
        registers[2] = 32'd20; //  $r2 = 20
        registers[3] = 32'd30; //  $r3 = 30
        registers[4] = 32'd40; //  $r4 = 40
        registers[5] = 32'd50; //  $r5 = 50
        registers[6] = 32'd60; //  $r6 = 60
        registers[7] = 32'd0;  // Set unused registers to 0
        registers[8] = 32'd100; //  $r8 = 100
        registers[9] = 32'd200; //  $r9 = 200
        registers[10] = 32'd300; // $r10 = 300
        registers[11] = 32'd300; // $r11 = 300
        registers[12] = 32'd300; // $r12 = 300
    end


    always @(posedge clk) begin
        if (RegWrite)
            registers[write_reg] <= write_data;
    end

    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];
endmodule
