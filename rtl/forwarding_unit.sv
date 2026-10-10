module forwarding_unit
import pipeline_types::*;
(
    input logic [4:0] id_exe_rs1,
    input logic [4:0] id_exe_rs2,
    input logic [4:0] exe_mem_rd,
    input logic       exe_mem_reg_write,
    input logic [4:0] mem_wb_rd,
    input logic       mem_wb_reg_write,
    output logic [1:0] fwd_1,
    output logic [1:0] fwd_2
);
    always_comb 
        begin 
            fwd_1=2'b00;
            fwd_2=2'b00;
            // the 01 encoding representing the 0 NOP gap
            if (id_exe_rs1==exe_mem_rd && exe_mem_reg_write==1 && exe_mem_rd!=0) begin
                fwd_1=2'b01;
            end
            
            else if (id_exe_rs1==mem_wb_rd && mem_wb_reg_write==1 && mem_wb_rd!=0) begin
                fwd_1=2'b10;
            end
            // the 10 encoding representing the 1 NOP gap
            if(id_exe_rs2==exe_mem_rd && exe_mem_reg_write==1 && exe_mem_rd!=0) begin
                fwd_2=2'b01;
            end
            else if(id_exe_rs2==mem_wb_rd && mem_wb_reg_write==1 && mem_wb_rd!=0) begin
                fwd_2=2'b10;
            end
        end 

endmodule   