module writeback_stage 
import pipeline_types::*;
(
    input mem_bus_t wb_in,
    output logic [4:0]  write_address,
    output logic [31:0] write_data,
    output logic        write_enable
);
    logic [1:0] result_src;
    logic [31:0] alu_result;
    logic [31:0] ram_out;
    logic [31:0] write_data_internal;
    logic [31:0] imm;
    logic [31:0] PC_plus_4;
    assign PC_plus_4=wb_in.PC_plus_4;
    assign result_src=wb_in.result_src;
    assign alu_result=wb_in.alu_result;
    assign ram_out=wb_in.ram_out;
    assign write_enable=wb_in.reg_write;
    assign imm=wb_in.imm;
    assign write_address=wb_in.rd;
    always_comb begin
        case (result_src)
            2'b00: write_data_internal=alu_result;
            2'b01: write_data_internal=ram_out;
            2'b10: write_data_internal=PC_plus_4;
            2'b11: write_data_internal=imm;
        endcase
    end
    assign write_data=write_data_internal;
    

endmodule
