    module decode_stage (
    input  logic [31:0] instruction_in,
    input logic [31:0] rd1,
    input logic [31:0] rd2,
    input logic [31:0] rd1_out,
    input logic [31:0] rd2_out,
    output logic [4:0]  rd,
    output logic [31:0] imm,
    output logic [4:0]  rs1,
    output logic [4:0]  rs2,
    output logic reg_write,
    output logic mem_write,
    output logic mem_read,
    output logic jump, 
    output logic branch,
    output logic [1:0]alu_src,
    output logic [3:0] alu_control, 
    output logic [1:0] result_src, 
    output logic [2:0] fnct3
);
    assign rd1_out=rd1;
    assign rd2_out=rd2;
    logic [6:0] op_code;
    logic [6:0]  fnct7; 
instruction_decoder id_inst (
    .instruction_in(instruction_in),
    .fnct3(fnct3),
    .fnct7(fnct7),
    .op_code(op_code),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .imm(imm)
);
control_unit control1 (
    .fnct3(fnct3),
    .fnct7(fnct7),
    .op_code(op_code),
    .reg_write(reg_write),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .jump(jump),
    .alu_control(alu_control),
    .alu_src(alu_src),
    .branch(branch),
    .result_src(result_src)

);

endmodule
  