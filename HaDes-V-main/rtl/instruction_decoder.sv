/* Copyright (c) 2024 Tobias Scheipel, David Beikircher, Florian Riedl
 * Embedded Architectures & Systems Group, Graz University of Technology
 * SPDX-License-Identifier: MIT
 * ---------------------------------------------------------------------
 * File: instruction_decoder.sv
 */



module instruction_decoder (
    input  logic [31:0] instruction_in,
    output logic [6:0]  op_code,
    output logic [2:0]  fnct3,
    output logic [6:0]  fnct7,
    output logic [4:0]  rs1,
    output logic [4:0]  rs2,
    output logic [4:0]  rd,
    output logic [31:0] imm
);
    assign op_code=instruction_in[6:0];
    assign fnct3=instruction_in[14:12];
    assign rs1=instruction_in[19:15];
    always_comb begin
     imm=32'b0;
     // R type
    if (op_code==7'b0110011) begin
         fnct7=instruction_in[31:25];
         rd=instruction_in[11:7];
         rs2=instruction_in[24:20];
    end
    
    // I type
    else if (op_code == 7'b0010011 || op_code == 7'b0000011 || op_code == 7'b1100111) begin
         imm[11:0]=instruction_in[31:20];
         imm[31:12]={20{imm[11]}};
         rd=instruction_in[11:7];
    end
    // S type
    else if (op_code==7'b0100011) begin
         imm[4:0]=instruction_in[11:7];
         imm[11:5]=instruction_in[31:25];
         imm[31:12]={20{imm[11]}};
         rs2=instruction_in[24:20];
    end
    
    // B type
    else if (op_code==7'b1100011) begin
         imm[11]=instruction_in[7];
         imm[4:1]=instruction_in[11:8];
         imm[10:5]=instruction_in[30:25];
         imm[12]=instruction_in[31];
         imm[31:13]={19{imm[12]}};
         rs2=instruction_in[24:20];
    end
    //U type
    else if (op_code==7'b0010111|| op_code==7'b0110111) begin
     //auipc
          rd=instruction_in[11:7];
          imm={instruction_in[31:12],12'b0};  
    end
    //J type
    else if (op_code==7'b1101111) begin
     //jal
          rd=instruction_in[11:7];
          imm[19:12]=instruction_in[19:12];
          imm[11]=instruction_in[20];
          imm[10:1]=instruction_in[30:21];
          imm[20]=instruction_in[31];
          imm[31:21]={11{imm[20]}};     
    end
end
endmodule
