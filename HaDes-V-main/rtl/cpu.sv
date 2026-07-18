/* Copyright (c) 2024 Tobias Scheipel, David Beikircher, Florian Riedl
 * Embedded Architectures & Systems Group, Graz University of Technology
 * SPDX-License-Identifier: MIT
 * ---------------------------------------------------------------------
 * File: cpu.sv
 */



    module cpu (
        input logic clk,
        input logic rst
    );
    register_file rf_inst (
        .read_address1(rs1),
        .read_address2(rs2),
        .write_address(rd),
        .write_data(),
        .read_data1(rd1),
        .read_data2(rd2),
        .write_enable(write_enable),
        .clk(clk)
    );
    id_exe_pr id_exe_pr1 (
        .clk(clk),
        .rst(rst)
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
            output logic [4:0]  rd_e,
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
        
    




