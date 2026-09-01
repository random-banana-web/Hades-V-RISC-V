module fetch_stage (
    input logic         clk,
    input logic         rst,
    input logic         PCsrc,
    input logic  [31:0] target_address,
    output logic [31:0] PC_out,  //travels down the pipe to be used in EXE stage to calc PC+imm
    output logic [31:0] PC_plus_4,  //travels down the pipe to be used in WB stage to write PC+4 to register file
    output logic [31:0] instruction_in

);
logic [31:0] PC_plus_4_wire;
logic [31:0] PC_next;
logic [31:0] PC_reg;
logic [7:0] inst_mem [0:1023]; //instruction memory

//PC reg
always_ff @( posedge clk ) 
    begin 
            if(rst)
                    PC_reg <= '0;
            else
                    PC_out<=PC_reg;
    end
assign instruction_in={inst_mem[PC_out+3],inst_mem[PC_out+2],inst_mem[PC_out+1],inst_mem[PC_out]};
assign PC_plus_4_wire=PC_out+4;
assign PC_plus_4=PC_plus_4_wire;

//mux
always_comb begin
    case (PCsrc) 
        1'b0: PC_next=PC_plus_4_wire;
        1'b1: PC_next=target_address;
    endcase
end
endmodule
