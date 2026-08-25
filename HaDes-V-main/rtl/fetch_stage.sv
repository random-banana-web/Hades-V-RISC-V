module fetch_stage (
    input logic         clk,
    input logic         rst,
    input logic         PCsrc,
    input logic  [31:0] target_address,
    output logic [31:0] PC_out,
    output logic [31:0] PC 

);
logic [31:0] PC_plus_4;
logic [31:0] PC_next;
logic [7:0] inst_mem [0:1023];
always_ff @( posedge ) 
    begin 
            if(rst)
            begin
                for(int i=0;i<=1023;i++)
                begin
                    PC_reg[i]<=0;
                end
            end

    end
endmodule
