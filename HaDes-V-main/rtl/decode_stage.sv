module decode_stage (
    input logic clk,
    input  logic [31:0] instruction_in,
    output logic [31:0] rd1,
    output logic [31:0] rd2,
    input logic write_enable,
    output logic [4:0]  rd,
    output logic [31:0] imm
);
instruction_decoder id_inst (
    .instruction_in(instruction_in),
    

);

endmodule
