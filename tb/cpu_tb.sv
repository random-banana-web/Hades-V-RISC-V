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

  repeat (80) @(posedge clk);
  $display("x2  = %h", dut.register_file_inst.reg_file[2]);
  $display("x4  = %h", dut.register_file_inst.reg_file[4]);
  $display("x6  = %h", dut.register_file_inst.reg_file[6]);
  $display("x7  = %h", dut.register_file_inst.reg_file[7]);
  $display("x10 = %h", dut.register_file_inst.reg_file[10]);
  $finish;

  end
endmodule