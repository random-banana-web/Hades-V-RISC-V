module control_unit (
    input logic [2:0] fnct3,
    input logic [6:0] fnct7,
    input logic [6:0] op_code,
    output logic reg_write,
    output logic mem_write,
    output logic mem_read,
    output logic jump, 
    output logic [1:0]alu_src, // chooses if 2nd operand for alu comes from imm or another register
    output logic branch, // PC is reset if branch is taken
    output logic [3:0] alu_control, // to differentiate between diff instructions in a type
    output logic [1:0] result_src //mux select signal for WB into rd 

);
always_comb begin
    //  DEFAULT ASSIGNMENTS 
    reg_write  = 1'b0;
    mem_write  = 1'b0;
    mem_read   = 1'b0;
    jump       = 1'b0;
    branch     = 1'b0;
    alu_src    = 2'b00;
    alu_control= 4'b0000;
    result_src = 2'b00;

    // R type
    if (op_code==7'b0110011) begin
     reg_write=1'b1;
     alu_src=2'b00;
     mem_read=1'b0;
     mem_write=1'b0;
     branch=1'b0;
     jump=1'b0;
     result_src=2'b00;
        if (fnct3==3'b000) begin
            if (fnct7==7'b0000000) begin
            //add
                 alu_control=4'b0000;
            end
            else if (fnct7==7'b0100000) begin
            //sub
                 alu_control=4'b0001;
            end
        end
        else if (fnct3==3'b001) begin
            //sll
                 alu_control=4'b0010;
        end
        else if (fnct3==3'b010) begin
            //slt
                 alu_control=4'b0011;
        end
        else if (fnct3==3'b011) begin
            //sltu
                 alu_control=4'b0100;
        end
        else if (fnct3==3'b100) begin
            //xor
                 alu_control=4'b0101;
        end
        else if (fnct3==3'b101) begin
            if (fnct7==7'b0000000) begin
                //srl
                 alu_control=4'b0110;
            end
            else if (fnct7==7'b0100000) begin
                //sra
                 alu_control=4'b0111;
            end
            
        end 
        else if (fnct3==3'b110) begin
            //or
                 alu_control=4'b1000;
        end
        else if (fnct3==3'b111) begin
            //and
                 alu_control=4'b1001;
        end
    end

// I type(load)

    else if (op_code==7'b0000011) begin
        reg_write=1'b1;
        alu_src=2'b01;
        mem_read=1'b1;
        mem_write=1'b0; 
        branch=1'b0;
        jump=1'b0;
        alu_control=4'b0000;
        result_src=2'b01;
    end
        
// I type(alu immediate)

    else if (op_code==7'b0010011) begin
        reg_write=1'b1;
        alu_src=2'b01;
        mem_read=1'b0;
        mem_write=1'b0;
        branch=1'b0;
        jump=1'b0;
        result_src=2'b00;
        if (fnct3==3'b000) begin
            //addi
            alu_control=4'b0000;
        end
        else if (fnct3==3'b001) begin
            //slli
            alu_control=4'b0010;
        end
        else if (fnct3==3'b010) begin
            //slti
            alu_control=4'b0011;
        end
        else if (fnct3==3'b011) begin
            //sltiu
            alu_control=4'b0100;
        end
        else if (fnct3==3'b100) begin
            //xori
            alu_control=4'b0101;
        end
        else if (fnct3==3'b101) begin
            if (fnct7==7'b0000000) begin
                //srli
                alu_control=4'b0110;
            end
            else if (fnct7==7'b0100000) begin
                //srai
                alu_control=4'b0111;
            end
        end
        else if (fnct3==3'b110) begin
            //ori
            alu_control=4'b1000;
        end
        else if (fnct3==3'b111) begin
            //andi
            alu_control=4'b1001;
        end     
    end
    //I type (jump jalr)
    else if(op_code==7'b1100111) begin
        reg_write=1'b1;
        alu_src=2'b01;
        mem_read=1'b0;
        mem_write=1'b0;
        branch=1'b0;
        jump=1'b1;
        alu_control=4'b0000;
        result_src=2'b10;
    end

    // S type
    else if (op_code==7'b0100011) begin
        reg_write=1'b0;
        alu_src=2'b01;
        mem_read=1'b0;
        mem_write=1'b1;
        branch=1'b0;
        jump=1'b0;
        alu_control=4'b0000;
        result_src=2'b00; //dont care
    end
    // B type
    else if (op_code==7'b1100011) begin
        reg_write=1'b0;
        alu_src=2'b00;
        mem_read=1'b0;
        mem_write=1'b0;
        branch=1'b1;
        jump=1'b0;
        result_src=2'b00; //dont care
        if (fnct3==3'b000) begin
            //beq
            alu_control=4'b0001;
        end
        else if (fnct3==3'b001) begin
            //bne
            alu_control=4'b0001;
        end
        else if (fnct3==3'b100) begin
            //blt
            alu_control=4'b0011;
        end
        else if (fnct3==3'b101) begin
            //bge
            alu_control=4'b0011;
        end
        else if (fnct3==3'b110) begin
            //bltu
            alu_control=4'b0100;
        end
        else if (fnct3==3'b111) begin    
            //bgeu
            alu_control=4'b0100;
        end
    end
    //U type
    else if (op_code==7'b0110111) begin
        //lui
        reg_write=1'b1;
        alu_src=2'b00; //dont care
        mem_read=1'b0;
        mem_write=1'b0;
        branch=1'b0;
        jump=1'b0;
        alu_control=4'b0000; //dont care
        result_src=2'b11;
    end
    else if (op_code==7'b0010111) begin
        //auipc
        reg_write=1'b1;
        alu_src=2'b10; 
        mem_read=1'b0;
        mem_write=1'b0;
        branch=1'b0;
        jump=1'b0;
        alu_control=4'b0000; 
        result_src=2'b00;
    end
    //J type
    else if(op_code==7'b1101111) begin
        //jal
        reg_write=1'b1;
        alu_src=2'b00; //dont care
        mem_read=1'b0;
        mem_write=1'b0;
        branch=1'b0;
        jump=1'b1;
        alu_control=4'b0000; //dont care    
        result_src=2'b10;
    end

end
    
endmodule
