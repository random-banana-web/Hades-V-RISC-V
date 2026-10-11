module id_exe_pr
import pipeline_types::*;
(
    input logic clk,
    input logic rst,
    input logic         load_use_stall, //hazard detection unit, causes clear if 1
    input logic         PCsrc, //used for control hazard
    input decode_bus_t decode_pr_in,
    output decode_bus_t decode_pr_out,
    output logic [4:0] id_exe_rs1, //this goes into the forwarding unit and used for hazards
    output logic [4:0] id_exe_rs2, //this goes into the forwarding unit and used for hazards   
    output logic [4:0] id_exe_rd,// this goes into hazard detection unit for the load use stall hazard detection 
    output logic       id_exe_mem_read// this goes into hazard detection unit for the load use stall hazard detection
);
    assign id_exe_rs1=decode_pr_out.rs1;
    assign id_exe_rs2=decode_pr_out.rs2;
    assign id_exe_rd=decode_pr_out.rd;
    assign id_exe_mem_read=decode_pr_out.mem_read;  
            always_ff @( posedge clk ) begin     
                if(rst || load_use_stall || PCsrc)
                    decode_pr_out <= '0;
                else
                    decode_pr_out<=decode_pr_in;
            end
        endmodule   