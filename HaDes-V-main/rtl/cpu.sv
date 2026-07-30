
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
        logic [31:0] instruction_in;
        logic [31:0] rd1;
        logic [31:0] rd2;
        logic        PCsrc;
        logic write_enable; //placeholder untill WB stage is complete   

        
    register_file rf_inst (
        .read_address1(decode_out.rs1),
        .read_address2(decode_out.rs2),
        .write_address(/*TODO*/),
        .write_data( /*TODO*/ ),
        .read_data1(rd1),
        .read_data2(rd2),
        .write_enable(write_enable),
        .clk(clk),
        .rst(rst)
    );
    id_exe_pr id_exe_pr1 (
        .clk(clk),
        .rst(rst),
        .decode_in(decode_out),
        .decode_pr_out(decode_pr_out)
    );

    decode_stage decoder_inst (
        .instruction_in(instruction_in),
        .decode_out(decode_out),
        .rd1(rd1),
        .rd2(rd2)
        );
        execute_stage execute_stage_inst(
        .exe_in(decode_out),
        .exe_out(exe_out),
        .PCsrc(PCsrc)
        );
        exe_mem_pr exe_mem_pr1 (
            .clk(clk),
            .rst(rst),
            .exe_pr_in(exe_out),
            .exe_pr_out(exe_pr_out)
        );
    endmodule
        
        
             
    




