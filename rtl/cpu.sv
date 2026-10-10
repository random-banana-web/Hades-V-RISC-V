
    module cpu 
    import pipeline_types::*;
    (
        input logic clk,
        input logic rst
        
    );
        decode_bus_t decode_out;
        decode_bus_t decode_pr_out;
        exe_bus_t exe_out;
        exe_bus_t exe_pr_out;
        mem_bus_t mem_out;
        mem_bus_t mem_pr_out;

        
        logic [31:0] rd1;
        logic [31:0] rd2;
        logic        PCsrc;
        logic [31:0] target_address;
        logic [4:0] write_address;
        logic [31:0] write_data;
        logic [31:0] imm;
        logic        write_enable; 
        logic [31:0] PC_out;
        logic [31:0] PC_plus_4;
        logic [31:0] instruction_in;
        logic [31:0] PC_out_d;
        logic [31:0] PC_plus_4_d;
        logic [31:0] instruction_in_d;
        logic [31:0] fwd_alu_result;
        // forwarding unit
        logic [4:0] id_exe_rs1;
        logic [4:0] id_exe_rs2;
        logic [4:0] exe_mem_rd;
        logic       exe_mem_reg_write;
        logic [4:0] mem_wb_rd;
        logic       mem_wb_reg_write;
        logic [1:0] fwd_1;
        logic [1:0] fwd_2;

        
    register_file register_file_inst (
        .read_address1(decode_out.rs1),
        .read_address2(decode_out.rs2),
        .write_address(write_address),
        .write_data(write_data),
        .read_data1(rd1),
        .read_data2(rd2),
        .write_enable(write_enable),
        .clk(clk),
        .rst(rst)
        );
    fetch_stage fetch_stage_inst(
        .clk(clk),
        .rst(rst),
        .PCsrc(PCsrc),
        .target_address(target_address),
        .instruction_in(instruction_in),
        .PC_out(PC_out),
        .PC_plus_4(PC_plus_4)
    );
    if_id_pr if_id_pr_inst(
        .clk(clk),
        .rst(rst),
        .PC_out(PC_out),
        .PC_plus_4(PC_plus_4),
        .instruction_in(instruction_in),
        .PC_out_d(PC_out_d),
        .PC_plus_4_d(PC_plus_4_d),
        .instruction_in_d(instruction_in_d)

    );
    decode_stage decoder_inst (
        .instruction_in(instruction_in_d),
        .decode_out(decode_out),
        .rd1(rd1),
        .rd2(rd2),
        .PC_out(PC_out_d),
        .PC_plus_4(PC_plus_4_d)
        );
    id_exe_pr id_exe_pr_inst (
        .clk(clk),
        .rst(rst),
        .decode_pr_in(decode_out),
        .decode_pr_out(decode_pr_out),
        .id_exe_rs1(id_exe_rs1),
        .id_exe_rs2(id_exe_rs2)
        );
    execute_stage execute_stage_inst(
        .exe_in(decode_pr_out),
        .exe_out(exe_out),
        .PCsrc(PCsrc),
        .target_address(target_address),
        .fwd_1(fwd_1),
        .fwd_2(fwd_2),
        .write_data(write_data),
        .fwd_alu_result(fwd_alu_result)
        );
    exe_mem_pr exe_mem_pr_inst (
        .clk(clk),
        .rst(rst),
        .exe_pr_in(exe_out),
        .exe_pr_out(exe_pr_out),
        .exe_mem_rd(exe_mem_rd),
        .exe_mem_reg_write(exe_mem_reg_write),
        .fwd_alu_result(fwd_alu_result)
        );
    memory_stage memory_stage_inst(
        .clk(clk),
        .mem_in(exe_pr_out),
        .mem_out(mem_out)
        );
    mem_wb_pr mem_wb_pr_inst(
        .clk(clk),
        .rst(rst),
        .mem_pr_in(mem_out),
        .mem_pr_out(mem_pr_out),
        .mem_wb_rd(mem_wb_rd),
        .mem_wb_reg_write(mem_wb_reg_write)
    );
    writeback_stage writeback_stage_inst(
        .wb_in(mem_pr_out),
        .write_address(write_address),
        .write_data(write_data),
        .write_enable(write_enable)
    );
    forwarding_unit forwarding_unit_inst(
        .id_exe_rs1(id_exe_rs1),
        .id_exe_rs2(id_exe_rs2),
        .exe_mem_rd(exe_mem_rd),
        .exe_mem_reg_write(exe_mem_reg_write),
        .mem_wb_rd(mem_wb_rd),
        .mem_wb_reg_write(mem_wb_reg_write),
        .fwd_1(fwd_1),
        .fwd_2(fwd_2)
    );
    
    endmodule
        
        
             
    




