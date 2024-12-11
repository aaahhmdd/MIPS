module ALUControl(
    input [1:0] ALUOp,
    input [5:0] funct,
    output reg [3:0] ALUCtrl
);
    always @(*) begin
        case (ALUOp)
            2'b00: ALUCtrl = 4'b0010; // LW/SW: Add
            2'b01: ALUCtrl = 4'b0110; // BEQ: Subtract
            2'b10: begin // R-type
                case (funct)
                    6'b100000: ALUCtrl = 4'b0010; // ADD
                    6'b100010: ALUCtrl = 4'b0110; // SUB
                    default: ALUCtrl = 4'b0010; // ADD
                endcase
            end
            default: ALUCtrl = 4'b0010; // ADD
        endcase
    end
endmodule
