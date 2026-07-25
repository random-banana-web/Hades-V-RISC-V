    module execute_stage 
    import pipeline_types::*;
    (
        input decode_bus_t exe_in,
        output exe_bus_t exe_out
    );
    logic [31:0] alu_operand_A;
    logic [31:0] alu_operand_B;
    logic        alu_result_src; //mux control signal for alu_result
    logic [31:0] alu_result_mainALU; //result from mainALU
    logic [31:0] alu_result_sideALU; //result from side pc+immaALU
    logic [31:0] alu_result;

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
    
    
    endmodule
