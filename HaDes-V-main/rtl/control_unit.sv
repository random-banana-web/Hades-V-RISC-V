module control_unit (
    input logic [2:0] fnct3,
    input logic [6:0] fnct7,
    input logic [6:0] op_code,
    output logic reg_write,
    output logic mem_write,
    output logic mem_read, 
    output logic mem_to_reg, //chooses whether output is from memory or alu
    output logic alu_src, // chooses if 2nd operand for alu comes from imm or another register
    output logic branch // PC is reset if branch is taken

);
// R type
if (op_code=7'b0110011) begin
    reg_write=1'b1;
    alu_src=1'b0;
    mem_read=1'b0;
    mem_write=1'b0;
    mem_to_reg=1'b0;
    branch=1'b0;
        if (fnct3=3'b000) begin
            if (fnct7=7'b0000000) begin
            //add
             
        end
            if (fnct7=7'b0100000) begin
            //sub
           
        end
    end
end
if (op_code=) begin
    
end
if (op_code=) begin
    
end
    
endmodule
assign reg_write=
            assign alu_src=
            assign mem_read=
            assign mem_write=
            assign mem_to_reg=
            assign branch=