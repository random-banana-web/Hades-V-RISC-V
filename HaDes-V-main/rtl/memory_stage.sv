module memory_stage (
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
assign mem_read=mem_in.mem_read;
assign mem_write=mem_in.mem_write;
assign fnct3=mem_in.fnct3;
assign store_data=mem_in.store_data;
if (mem_read==1 && mem_write==0) begin
    // load
    case (fnct3)
        3'b000: //lb
        3'b001: //lh
        3'b010: //lw
        3'b100: //lbu
        3'b101: //lhu
        default: 
    endcase
end
else if (mem_read==0 && mem_write==1) begin
    //store
end


endmodule
