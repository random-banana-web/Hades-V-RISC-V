module if_id_pr
import pipeline_types::*;
(
    input  logic clk,
    input  logic rst,
    input  logic [31:0] pc,
    input  logic [31:0] pc_plus_4,
    input  logic [31:0] instruction_in,
    output logic [31:0] pc_d,
    output logic [31:0] pc_plus_4_d,
    output logic [31:0] instruction_in_d   
);
            always_ff @( posedge clk ) begin     
                if(rst)
                    begin
                        pc_d<='0;
                        pc_plus_4_d<='0;
                        instruction_in_d<='0;
                    end
                else
                    begin
                        pc_d<=pc;
                        pc_plus_4_d<=pc_plus_4;
                        instruction_in_d<=instruction_in;
                    end
            end
        endmodule 