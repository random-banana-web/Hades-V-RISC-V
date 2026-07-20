
    module cpu (
        input logic clk,
        input logic rst
        
    );

        logic instruction_in;
        logic [31:0] rd1;
        logic [31:0] rd2;
        logic [31:0] rd1_out;
        logic [31:0] rd2_out;
        logic [4:0] rd;
        logic [31:0] imm;
        logic [4:0] rs1;
        logic [4:0] rs2;
        logic reg_write;
        logic mem_write;
        logic mem_read;
        logic jump;
        logic branch;
        logic [3:0] alu_control;
        logic [1:0] result_src;
        logic [1:0] alu_src;
        logic [2:0] fnct3;
        logic write_enable; //placeholder untill WB stage is complete   

        logic [31:0] rd1_out_e;
        logic [31:0] rd2_out_e;
        logic [4:0] rd_e;
        logic [31:0] imm_e;
        logic [4:0] rs1_e;
        logic [4:0] rs2_e;
        logic reg_write_e;
        logic mem_write_e;
        logic mem_read_e;
        logic jump_e;
        logic branch_e;
        logic [3:0] alu_control_e;
        logic [1:0] result_src_e;
        logic [1:0] alu_src_e;
        logic [2:0] fnct3_e;

    register_file rf_inst (
        .read_address1(rs1),
        .read_address2(rs2),
        .write_address(rd),
        .write_data( /*TODO*/ ),
        .read_data1(rd1),
        .read_data2(rd2),
        .write_enable(write_enable),
        .clk(clk)
    );
    id_exe_pr id_exe_pr1 (
        .clk(clk),
        .rst(rst),
        .rd1_out(rd1_out),
        .rd2_out(rd2_out),
        .rd(rd),
        .imm(imm),
        .rs1(rs1),
        .rs2(rs2),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .jump(jump),
        .branch(branch),
        .alu_src(alu_src),
        .alu_control(alu_control),
        .result_src(result_src),
        .fnct3(fnct3),

        .rd1_out_e(rd1_out_e),
        .rd2_out_e(rd2_out_e),
        .rd_e(rd_e),
        .imm_e(imm_e),
        .rs1_e(rs1_e),
        .rs2_e(rs2_e),
        .reg_write_e(reg_write_e),
        .mem_write_e(mem_write_e),
        .mem_read_e(mem_read_e),
        .jump_e(jump_e),
        .branch_e(branch_e),
        .alu_src_e(alu_src_e),
        .alu_control_e(alu_control_e),
        .result_src_e(result_src_e),
        .fnct3_e(fnct3_e)
    );

    decode_stage decoder_inst (
        .rd1(rd1),
        .rd2(rd2),    
        .instruction_in(instruction_in),

        .rd1_out(rd1_out),
        .rd2_out(rd2_out),
        .rd(rd),
        .imm(imm),
        .rs1(rs1),
        .rs2(rs2),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .jump(jump),
        .branch(branch),
        .alu_src(alu_src),
        .alu_control(alu_control),
        .result_src(result_src),
        .fnct3(fnct3)   
        );
    
        
    endmodule
        
        module id_exe_pr(
            input logic clk,
            input logic rst,
            input logic [31:0] rd1_out,
            input logic [31:0] rd2_out,
            input logic [4:0]  rd,
            input logic [31:0] imm,
            input logic [4:0]  rs1,
            input logic [4:0]  rs2,
            input logic reg_write,
            input logic mem_write,
            input logic mem_read,
            input logic jump, 
            input logic branch,
            input logic [1:0]alu_src,
            input logic [3:0] alu_control, 
            input logic [1:0] result_src, 
            input logic [2:0] fnct3,
            
            output logic [31:0] rd1_out_e,
            output logic [31:0] rd2_out_e,
            output logic [4:0] rd_e,
            output logic [31:0] imm_e,
            output logic [4:0]  rs1_e,
            output logic [4:0]  rs2_e,
            output logic reg_write_e,
            output logic mem_write_e,
            output logic mem_read_e,
            output logic jump_e, 
            output logic branch_e,
            output logic [1:0]alu_src_e,
            output logic [3:0] alu_control_e, 
            output logic [1:0] result_src_e, 
            output logic [2:0] fnct3_e
        );
            always_ff @( posedge clk ) begin 
            rd1_out_e<=rd1_out;
            rd2_out_e<=rd2_out;
            rd_e<=rd;
            imm_e<=imm;
            rs1_e<=rs1;
            rs2_e<=rs2;
            reg_write_e<=reg_write;
            mem_write_e<=mem_write;
            mem_read_e<=mem_read;
            jump_e<=jump;
            branch_e<=branch;
            alu_src_e<=alu_src;
            alu_control_e<=alu_control;
            result_src_e<=result_src;
            fnct3_e<=fnct3;
            end
        endmodule
             
    




