module control_unit_tb;
     logic [2:0] fnct3;
     logic [6:0] fnct7;
     logic [6:0] op_code;
     logic reg_write;
     logic mem_write;
     logic mem_read;
     logic jump; 
     logic [1:0] alu_src; 
     logic branch;
     logic [3:0] alu_control; 
     logic [1:0] result_src;

control_unit dut (
    .fnct3(fnct3),
    .fnct7(fnct7),
    .op_code(op_code),
    .reg_write(reg_write),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .jump(jump), 
    .alu_src(alu_src),
    .branch(branch),
    .alu_control(alu_control), 
    .result_src(result_src)
);

logic [6:0] test_opcode [0:1];
logic [2:0] test_fnct3  [0:1];
logic [6:0] test_fnct7  [0:1];
logic [3:0] test_expected [0:1];

initial begin
    test_opcode[0]=7'b0010011; test_fnct3[0]=3'b101; test_fnct7[0]=7'b0000000; test_expected[0]=4'b0110; // srli
    test_opcode[1]=7'b0010011; test_fnct3[1]=3'b101; test_fnct7[1]=7'b0100000; test_expected[1]=4'b0111; // srai

    for (int i=0; i<=1; i++) begin
        op_code = test_opcode[i];
        fnct3   = test_fnct3[i];
        fnct7   = test_fnct7[i];
        #10;
        if (alu_control == test_expected[i]) begin
            $display("pass %0d", i);
        end else begin
            $display("fail %0d: got %h expected %h", i, alu_control, test_expected[i]);
        end
    end
end
endmodule

