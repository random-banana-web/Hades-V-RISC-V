/* Copyright (c) 2024 Tobias Scheipel, David Beikircher, Florian Riedl
 * Embedded Architectures & Systems Group, Graz University of Technology
 * SPDX-License-Identifier: MIT
 * ---------------------------------------------------------------------
 * File: instruction_decoder.sv
 */



module instruction_decoder (
    input  logic [31:0] instruction_in,
    output logic [6:0]  opcode,
    output logic [2:0]  funct3,
    output logic [6:0]  funct7,
    output logic [4:0]  rs1,
    output logic [4:0]  rs2,
    output logic [4:0]  rd,
    output logic [31:0] imm
);
    assign opcode=instruction_in[6:0];
    assign funct3=instruction_in[14:12];
    assign rs1=instruction_in[19:15];
    always_comb begin
     // R type
    if (opcode==7'b0110011) begin
         funct7=instruction_in[31:25];
         rd=instruction_in[11:7];
         rs2=instruction_in[24:20];
    end
    
    // I type
    else if (opcode == 7'b0010011 || opcode == 7'b0000011 || opcode == 7'b1100111) begin
         imm[11:0]=instruction_in[31:20];
         imm[31:12]={20{imm[11]}};
         rd=instruction_in[11:7];
    end
    // S type
    else if (opcode==7'b0100011) begin
         imm[4:0]=instruction_in[11:7];
         imm[11:5]=instruction_in[31:25];
         imm[31:12]={20{imm[11]}};
         rs2=instruction_in[24:20];
    end
    
    // B type
    else if (opcode==7'b1100011) begin
         imm[11]=instruction_in[7];
         imm[4:1]=instruction_in[11:8];
         imm[10:5]=instruction_in[30:25];
         imm[12]=instruction_in[31];
         imm[31:13]={19{imm[12]}};
         rs2=instruction_in[24:20];
    end
    end
endmodule
