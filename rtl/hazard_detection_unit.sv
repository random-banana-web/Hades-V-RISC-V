module hazard_detection_unit (
    input logic [4:0] if_id_rs1,
    input logic [4:0] if_id_rs2,
    input logic [4:0] id_exe_rd,
    input logic       id_exe_mem_read,
    output logic      load_use_stall
);
    always_comb 
    begin 
        if ((if_id_rs1==id_exe_rd || if_id_rs2==id_exe_rd) && id_exe_mem_read==1 && id_exe_rd!=0) begin
            load_use_stall=1;
        end    
        else begin
            load_use_stall=0;
        end
    end
endmodule