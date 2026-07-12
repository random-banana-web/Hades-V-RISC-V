module control_unit (
    input logic [2:0] fnct3,
    input logic [6:0] fnct7,
    input logic [6:0] op_code,
    output logic reg_write,
    output logic mem_write,
    output logic mem_read, 
    output logic mem_to_reg, //chooses whether output is from memory or alu
    output logic alu_src, // chooses if 2nd operand for alu comes from imm or another register
    output logic branch, // PC is reset if branch is taken
    output logic [3:0] alu_control // to differentiate between diff instructions in a type

);
// R type
always_comb begin
    if (op_code==7'b0110011) begin
     reg_write=1'b1;
     alu_src=1'b0;
     mem_read=1'b0;
     mem_write=1'b0;
     mem_to_reg=1'b0;
     branch=1'b0;
        if (fnct3==3'b000) begin
            if (fnct7==7'b0000000) begin
            //add
                 alu_control=4'b0000;
            end
            if (fnct7==7'b0100000) begin
            //sub
                 alu_control=4'b0001;
            end
        end
        if (fnct3==3'b001) begin
            //sll
                 alu_control=4'b0010;
        end
        if (fnct3==3'b010) begin
            //slt
                 alu_control=4'b0011;
        end
        if (fnct3==3'b011) begin
            //sltu
                 alu_control=4'b0100;
        end
        if (fnct3==3'b100) begin
            //xor
                 alu_control=4'b0101;
        end
        if (fnct3==3'b101) begin
            if (fnct7==7'b0000000) begin
                //srl
                 alu_control=4'b0110;
            end
            if (fnct7==7'b0100000) begin
                //sra
                 alu_control=4'b0111;
            end
            
        end 
        if (fnct3==3'b110) begin
            //or
                 alu_control=4'b1000;
        end
        if (fnct3==3'b111) begin
            //and
                 alu_control=4'b1001;
        end
    end

// I type(load)

    if (op_code==7'b0000011) begin
        reg_write=1'b1;
        alu_src=1'b1;
        mem_read=1'b1;
        mem_write=1'b0;
        mem_to_reg=1'b1;
        branch=1'b0;
        alu_control=4'b0000;
    end
        
// I type(alu immediate)

    if (op_code==7'b0010011) begin
        reg_write=1'b1;
        alu_src=1'b1;
        mem_read=1'b0;
        mem_write=1'b0;
        mem_to_reg=1'b0;
        branch=1'b0;
        if (fnct3==3'b000) begin
            //addi
            alu_control=4'b0000;
        end
        if (fnct3==3'b001) begin
            //slli
            alu_control=4'b0010;
        end
        if (fnct3==3'b010) begin
            //slti
            alu_control=4'b0011;
        end
        if (fnct3==3'b011) begin
            //sltiu
            alu_control=4'b0100;
        end
        if (fnct3==3'b100) begin
            //xori
            alu_control=4'b0101;
        end
        if (fnct3==3'b101) begin
            if (fnct7==7'b0000000) begin
                //srli
                alu_control=4'b0110;
            end
            if (fnct7==7'b0100000) begin
                //srai
                alu_control=4'b0111;
            end
        end
        if (fnct3==3'b110) begin
            //ori
            alu_control=4'b1000;
        end
        if (fnct3==3'b111) begin
            //andi
            alu_control=4'b1001;
        end     
    end
end

    
endmodule
