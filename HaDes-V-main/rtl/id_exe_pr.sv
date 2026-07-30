module id_exe_pr
import pipeline_types::*;
(
            input logic clk,
            input logic rst,
            input decode_bus_t decode_pr_in,
            output decode_bus_t decode_pr_out
            
        );
            always_ff @( posedge clk ) begin     
                if(rst)
                    decode_pr_out <= 1'b0;
                else
                    decode_pr_out<=decode_pr_in;
            end
        endmodule   