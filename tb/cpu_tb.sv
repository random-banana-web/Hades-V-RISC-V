module cpu_tb;
  logic clk = 0;
  logic rst;

  cpu dut (
  .clk(clk), 
  .rst(rst) 
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("waves.vcd");
    $dumpvars(0, cpu_tb);
    $readmemh("sim/programs/test1.hex.txt", dut.fetch_stage_inst.inst_mem); 

    rst = 1;
    @(posedge clk);
    @(posedge clk);
    rst = 0;

    // let it run some cycles
    repeat (50) @(posedge clk); 
    $display("x1 = %h", dut.register_file_inst.reg_file[1]);
    $display("x2 = %h", dut.register_file_inst.reg_file[2]);
    $display("x3 = %h", dut.register_file_inst.reg_file[3]);
    $display("x4 = %h", dut.register_file_inst.reg_file[4]);
    $display("x5 = %h", dut.register_file_inst.reg_file[5]);
    $display("x6 = %h", dut.register_file_inst.reg_file[6]);
    $display("mem32 = %h", dut.memory_stage_inst.mem_ram[32]);
    $display("mem33 = %h", dut.memory_stage_inst.mem_ram[33]);
    $finish;


    $finish;
  end
endmodule