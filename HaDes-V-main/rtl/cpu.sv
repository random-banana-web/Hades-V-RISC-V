
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

        
    register_file rf_inst (
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
        .decode_pr_out(decode_pr_out)
        );
    execute_stage execute_stage_inst(
        .exe_in(decode_out),
        .exe_out(exe_out),
        .PCsrc(PCsrc),
        .target_address(target_address)
        );
    exe_mem_pr exe_mem_pr_inst (
        .clk(clk),
        .rst(rst),
        .exe_pr_in(exe_out),
        .exe_pr_out(exe_pr_out)
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
        .mem_pr_out(mem_pr_out)
    );
    writeback_stage writeback_stage_inst(
        .wb_in(mem_pr_out),
        .write_address(write_address),
        .write_data(write_data),
        .write_enable(write_enable)
    );
    
    endmodule
        
        
             
    




