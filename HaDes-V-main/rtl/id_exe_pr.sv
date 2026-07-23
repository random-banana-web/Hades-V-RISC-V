module id_exe_pr
import pipeline_types::*;
(
            input logic clk,
            input logic rst,
            input decode_bus_t decode_in,
            output decode_bus_t decode_out_e
            
        );
            always_ff @( posedge clk ) begin     
                if(rst)
                    decode_out_e <= 1'b0;
                else
                    decode_out_e<=decode_in;
            end
        endmodule   