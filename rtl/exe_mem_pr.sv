module exe_mem_pr 
import pipeline_types::*;
(
    input logic clk,
    input logic rst,
    input exe_bus_t exe_pr_in,
    output exe_bus_t exe_pr_out,
    output logic [4:0] exe_mem_rd,
    output logic       exe_mem_reg_write,
    output logic [31:0] fwd_alu_result
);
    assign exe_mem_rd=exe_pr_in.rd;
    assign exe_mem_reg_write=exe_pr_in.reg_write;
    assign alu_result=exe_pr_in.alu_result;
    always_ff @( posedge clk ) begin     
                if(rst)
                    exe_pr_out <= '0;
                else
                    exe_pr_out<=exe_pr_in;
            end
endmodule