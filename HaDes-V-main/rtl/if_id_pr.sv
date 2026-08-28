module if_id_pr
import pipeline_types::*;
(
    input  logic clk,
    input  logic rst,
    input  logic [31:0] PC_out,
    input  logic [31:0] PC_plus_4,
    input  logic [31:0] instruction_in,
    output logic [31:0] PC_out_d,
    output logic [31:0] PC_plus_4_d,
    output logic [31:0] instruction_in_d   
);
            always_ff @( posedge clk ) begin     
                if(rst)
                    begin
                        PC_out_d<='0;
                        PC_plus_4_d<='0;
                        instruction_in_d<='0;
                    end
                else
                    begin
                        PC_out_d<=PC_out;
                        PC_plus_4_d<=PC_plus_4;
                        instruction_in_d<=instruction_in;
                    end
            end
        endmodule 