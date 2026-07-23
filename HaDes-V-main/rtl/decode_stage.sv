    module decode_stage
    import pipeline_types::*; 
    (
    input  logic [31:0] instruction_in,
    input logic [31:0] rd1,
    input logic [31:0] rd2,
    output decode_bus_t decode_out
);
    assign decode_out.rd1_out=rd1;
    assign decode_out.rd2_out=rd2;  
    assign decode_out.rd=rd;
    assign decode_out.imm=imm;
    assign decode_out.rs1=rs1;
    assign decode_out.rs2=rs2;
    assign decode_out.reg_write=reg_write;
    assign decode_out.mem_write=mem_write;
    assign decode_out.mem_read=mem_read;
    assign decode_out.jump=jump;
    assign decode_out.branch=branch;
    assign decode_out.alu_src=alu_src;
    assign decode_out.alu_control=alu_control;
    assign decode_out.result_src=result_src;
    assign decode_out.fnct3=fnct3;
    
        
    logic [6:0] op_code;
    logic [6:0]  fnct7; 
    logic [4:0]  rs1;
    logic [4:0]  rs2;
    logic [4:0]  rd;
    logic [31:0] imm;
    logic [2:0]  fnct3;
    logic        reg_write;
    logic        mem_write;
    logic        mem_read;
    logic        jump;
    logic        branch;
    logic [1:0]  alu_src;
    logic [3:0]  alu_control;
    logic [1:0]  result_src;
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
  