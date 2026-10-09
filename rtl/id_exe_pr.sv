module id_exe_pr
import pipeline_types::*;
(
    input logic clk,
    input logic rst,
    input decode_bus_t decode_pr_in,
    output decode_bus_t decode_pr_out,
    output logic [4:0] id_exe_rs1,
    output logic [4:0] id_exe_rs2     
);
    assign id_exe_rs1=decode_pr_in.rs1;
    assign id_exe_rs2=decode_pr_in.rs2;
            always_ff @( posedge clk ) begin     
                if(rst)
                    decode_pr_out <= '0;
                else
                    decode_pr_out<=decode_pr_in;
            end
        endmodule   