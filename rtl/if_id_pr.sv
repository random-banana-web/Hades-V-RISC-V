module if_id_pr
import pipeline_types::*;
(
    input  logic clk,
    input  logic rst,
    input  logic [31:0] PC_out,
    input  logic [31:0] PC_plus_4,
    input  logic [31:0] instruction_in,
    input logic         load_use_stall, //hazard detection unit, causes stall if 1
    input logic         PCsrc, //used for control hazard 
    output logic [31:0] PC_out_d,
    output logic [31:0] PC_plus_4_d,
    output logic [31:0] instruction_in_d,  
    output logic [4:0] if_id_rs1, //for hazard detection unit
    output logic [4:0] if_id_rs2 //for hazard detection unit
);
    assign if_id_rs1=instruction_in_d[19:15];
    assign if_id_rs2=instruction_in_d[24:20]; /*yes it may cause false positives for the bits may be that of
     immediate and match the rd of load and cause 1 cycle stall for no reason so 1 cycle wasted but ans still correct*/
            always_ff @( posedge clk ) begin     
                if(rst)
                    begin
                        PC_out_d<='0;
                        PC_plus_4_d<='0;
                        instruction_in_d<=32'h00000013;
                    end
                else if(load_use_stall)
                    begin
                        //hold current values. stalled due to hazard detection unit
                    end
                else if(PCsrc)
                    begin
                        PC_out_d<='0;
                        PC_plus_4_d<='0;    
                        instruction_in_d<=32'h00000013; //equivalent to a NOP. we do this instead of rst since 0 is not a valid inst for ID to decode
                    end
                else
                    begin
                        PC_out_d<=PC_out;
                        PC_plus_4_d<=PC_plus_4;
                        instruction_in_d<=instruction_in;
                    end
            end
        endmodule 