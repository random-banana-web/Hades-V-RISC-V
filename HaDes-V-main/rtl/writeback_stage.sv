module writeback_stage 
import pipeline_types::*;
(
    input mem_bus_t wb_in,
    output logic write_address,
    output logic write_data,
    output logic write_enable,
    output logic imm
);
    logic [1:0] result_src;
    logic [31:0] alu_result;
    logic [31:0] ram_out;
    logic [31:0] write_data_internal;
    assign result_src=wb_in.result_src;
    assign alu_result=wb_in.alu_result;
    assign ram_out=wb_in.ram_out;
    assign write_enable=wb_in.reg_write;
    assign imm=wb_in.imm;
    assign write_address=wb_in.rd;
    case (result_src)
        2'b00: write_data_internal=alu_result;
        2'b01: write_data_internal=ram_out;
        2'b10: //TODO AFTER FETCH STAGE
        2'b11: write_data_internal=imm;
    endcase
    assign write_data=write_data_internal;
    

endmodule
