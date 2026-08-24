module memory_stage 
import pipeline_types::*;
(
    input clk,
    input exe_bus_t mem_in,
    output mem_bus_t mem_out
);
logic [7:0] mem_ram [0:1023]; //1024 bytes. each byte is 8 bits. 
logic mem_read;
logic mem_write;
logic [2:0]  fnct3;
logic [31:0] store_data;
logic [31:0] ram_out;
logic [31:0] alu_result;
assign mem_read=mem_in.mem_read;
assign mem_write=mem_in.mem_write;
assign fnct3=mem_in.fnct3;
assign store_data=mem_in.store_data;
assign alu_result=mem_in.alu_result;
assign mem_out.reg_write=mem_in.reg_write;
assign mem_out.ram_out=ram_out;
assign mem_out.alu_result=alu_result;
assign mem_out.result_src=mem_in.result_src;
assign mem_out.rd=mem_in.rd;
assign mem_out.imm=mem_in.imm;
always_comb begin 
    ram_out = 32'bx;
    if (mem_read==1 && mem_write==0) begin
    // load
    case (fnct3)
        3'b000: ram_out=32'($signed(mem_ram[alu_result]));//lb
        3'b001: ram_out=32'($signed({(mem_ram[alu_result+1]), mem_ram[alu_result]}));//lh
        3'b010: ram_out= {(mem_ram[alu_result+3]), mem_ram[alu_result+2], mem_ram[alu_result+1], mem_ram[alu_result]};//lw
        3'b100: ram_out= {24'b0, mem_ram[alu_result]};//lbu
        3'b101: ram_out= {16'b0, mem_ram[alu_result+1], mem_ram[alu_result]};//lhu
        default: 
        ram_out=32'bx;
    endcase
end
end


    //store
always_ff @(posedge clk) begin 
     if (mem_read==0 && mem_write==1) begin
        case (fnct3)
        3'b000: mem_ram[alu_result]= store_data[7:0];//sb
        3'b001: begin  //sh
            mem_ram[alu_result]= store_data[7:0];
            mem_ram[alu_result+1]= store_data[15:8];
        end 
        3'b010: begin  //sw
            mem_ram[alu_result]= store_data[7:0];
            mem_ram[alu_result+1]= store_data[15:8];
            mem_ram[alu_result+2]= store_data[23:16];
            mem_ram[alu_result+3]= store_data[31:24];
    end
        endcase
            end
    
end
endmodule
