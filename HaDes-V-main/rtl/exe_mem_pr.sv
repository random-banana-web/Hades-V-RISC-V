module exe_mem_pr 
import pipeline_types::*;
(
    input logic clk,
    input logic rst,
    input exe_bus_t exe_pr_in,
    output exe_bus_t exe_pr_out
);
    always_ff @( posedge clk ) begin     
                if(rst)
                    exe_pr_out <= 1'b0;
                else
                    exe_pr_out<=exe_pr_in;
            end
endmodule