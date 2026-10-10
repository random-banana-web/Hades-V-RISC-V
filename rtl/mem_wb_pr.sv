module mem_wb_pr 
import pipeline_types::*;
(
    input logic clk,
    input logic rst,
    input mem_bus_t mem_pr_in,
    output mem_bus_t mem_pr_out,
    output logic [4:0] mem_wb_rd,
    output logic       mem_wb_reg_write
);
    assign mem_wb_rd= mem_pr_out.rd;
    assign mem_wb_reg_write=mem_pr_out.reg_write;
    always_ff @( posedge clk ) begin     
                if(rst)
                    mem_pr_out <= '0;
                else
                    mem_pr_out<=mem_pr_in;
            end
endmodule