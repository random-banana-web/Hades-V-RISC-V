    module execute_stage 
    import pipeline_types::*;
    (
        input decode_bus_t exe_in,
        output exe_bus_t exe_out,
        output logic PCsrc
    );
    logic [31:0] alu_operand_A;
    logic [31:0] alu_operand_B;
    logic        alu_result_src; //mux control signal for alu_result
    logic [31:0] alu_result_mainALU; //result from mainALU
    logic [31:0] alu_result_sideALU; //result from side pc+immaALU
    logic [31:0] alu_result;
    logic        zero_flag;
    logic        less_than_flag;
    logic        less_than_u;
    logic        branch_taken;
    logic [31:0] store_data;
    

    // assigning alu operandA and alu_src
    assign alu_operand_A=exe_in.rd1_out;
    assign alu_result_src=exe_in.alu_result_src;
    always_comb begin
        case (exe_in.alu_src)
            2'b00:  alu_operand_B=exe_in.rd2_out;  //rs1&rs2
            2'b01:  alu_operand_B=exe_in.imm;   //rs1&imm 
            default: alu_operand_B='x;   //default
        endcase
    end

        
    // main ALU
    always_comb begin
        case (exe_in.alu_control)
            4'b0000: alu_result_mainALU=alu_operand_A+alu_operand_B; //add
            4'b0001: alu_result_mainALU=alu_operand_A-alu_operand_B;//sub
            4'b0010: alu_result_mainALU=alu_operand_A<<alu_operand_B[4:0];//sll
            4'b0011: alu_result_mainALU=$signed(alu_operand_A)<$signed(alu_operand_B);//slt
            4'b0100: alu_result_mainALU=alu_operand_A<alu_operand_B;//sltu
            4'b0101: alu_result_mainALU=alu_operand_A^alu_operand_B;//xor
            4'b0110: alu_result_mainALU=alu_operand_A>>alu_operand_B[4:0];//srl
            4'b0111: alu_result_mainALU=$signed(alu_operand_A)>>>alu_operand_B[4:0];//sra
            4'b1000: alu_result_mainALU=alu_operand_A|alu_operand_B;//or
            4'b1001: alu_result_mainALU=alu_operand_A&alu_operand_B;//and
            default: alu_result_mainALU='x;
        endcase
    end
        
    // side pc+imm ALU
    assign alu_result_sideALU= /*TODOpc*/ +exe_in.imm;
    always_comb begin
        case(alu_result_src)
            1'b0: alu_result=alu_result_mainALU;
            1'b1: alu_result=alu_result_sideALU;
        endcase
    end
    assign zero_flag = (alu_operand_A == alu_operand_B);              // beq/bne — signed/unsigned does not matter
    assign less_than_flag = ($signed(alu_operand_A) < $signed(alu_operand_B));  // blt/bge — signed
    assign less_than_u = (alu_operand_A < alu_operand_B);                    // bltu/bgeu — unsigned
    
    always_comb begin 
    
        case (exe_in.fnct3)
            3'b000:  branch_taken = zero_flag;           // beq            
            3'b001:  branch_taken = ~zero_flag;          // bne
            3'b100:  branch_taken = less_than_flag;      // blt
            3'b101:  branch_taken = ~less_than_flag;     // bge
            3'b110:  branch_taken = less_than_u;         // bltu
            3'b111:  branch_taken = ~less_than_u;        // bgeu
            default: branch_taken = 1'bx; 
        endcase
    end
    assign PCsrc = exe_in.jump | (exe_in.branch & branch_taken);
    
    assign exe_out.alu_result=exe_in.alu_result;
    assign exe_out.reg_write=exe_in.reg_write;
    assign exe_out.mem_read=exe_in.mem_read;
    assign exe_out.mem_write=exe_in.mem_write;
    assign exe_out.result_src=exe_in.result_src;
    assign exe_out.rd=exe_in.rd;
    assign exe_out.fnct3=exe_in.fnct3;
    assign exe_out.store_data=exe_in.rd2_out;
    endmodule
