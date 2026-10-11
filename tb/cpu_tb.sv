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
  $display("x3  = %h", dut.register_file_inst.reg_file[3]);
  $display("x10 = %h", dut.register_file_inst.reg_file[10]);
  $display("x11 = %h", dut.register_file_inst.reg_file[11]);
  $display("x12 = %h", dut.register_file_inst.reg_file[12]);
  $display("x13 = %h", dut.register_file_inst.reg_file[13]);
  $display("x14 = %h", dut.register_file_inst.reg_file[14]);
  $display("x15 = %h", dut.register_file_inst.reg_file[15]);
  $display("x16 = %h", dut.register_file_inst.reg_file[16]);
  $display("x17 = %h", dut.register_file_inst.reg_file[17]);
  $display("x18 = %h", dut.register_file_inst.reg_file[18]);
  $finish;

  end
endmodule