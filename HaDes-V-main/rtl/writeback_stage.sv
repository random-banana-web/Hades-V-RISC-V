module writeback_stage 
import pipeline_types::*;
(
    input mem_bus_t exe_in,
    output wb_bus_t exe_out,
);
    logic [1:0] result_src;
    logic [31:0] alu_result;
    logic [31:0] ram_out;
    logic [31:0] write_data;
    logic [31:0] imm;
    assign result_src=exe_in.result_src;
    assign alu_result=exe_in.alu_result;
    assign ram_out=exe_in.ram_out;
    assign imm=exe_in.imm;
    case (result_src)
        2'b00: write_data=alu_result;
        2'b01: write_data=ram_out;
        2'b10: //TODO AFTER FETCH STAGE
        2'b11: write_data=imm;
        default: 
    endcase

    

endmodule
