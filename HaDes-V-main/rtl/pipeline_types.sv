package pipeline_types;
    typedef struct packed {
        logic [31:0] rd1_out;
        logic [31:0] rd2_out;
        logic [4:0]  rd;
        logic [31:0] imm;
        logic [4:0]  rs1;
        logic [4:0]  rs2;
        logic        reg_write;
        logic        mem_write;
        logic        mem_read;
        logic        jump;
        logic        branch;
        logic [1:0]  alu_src;
        logic [3:0]  alu_control;
        logic [1:0]  result_src;
        logic [2:0]  fnct3;
    } decode_bus_t;
endpackage