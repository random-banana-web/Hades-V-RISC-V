module cpu_tb;
  logic clk = 0;
  logic rst;

  cpu dut (
  .clk(clk), 
  .rst(rst) 
  );

  always #5 clk = ~clk;
always @(posedge clk)
  initial begin
    $dumpfile("waves.vcd");
    $dumpvars(0, cpu_tb);
    $readmemh("sim/programs/test1.hex.txt", dut.fetch_stage_inst.inst_mem); 

    rst = 1;
    @(posedge clk);
    @(posedge clk);
    rst = 0;

    // let it run some cycles
 
  repeat (250) @(posedge clk);
  $display("x1  = %h", dut.register_file_inst.reg_file[1]);
  $display("x3  = %h", dut.register_file_inst.reg_file[3]);
  $display("x4  = %h", dut.register_file_inst.reg_file[4]);
  $display("x5  = %h", dut.register_file_inst.reg_file[5]);
  $display("x6  = %h", dut.register_file_inst.reg_file[6]);
  $display("x7  = %h", dut.register_file_inst.reg_file[7]);
  $display("x8  = %h", dut.register_file_inst.reg_file[8]);
  $display("x9  = %h", dut.register_file_inst.reg_file[9]);
  $display("x10 = %h", dut.register_file_inst.reg_file[10]);
  $display("x11 = %h", dut.register_file_inst.reg_file[11]);
  $display("x12 = %h", dut.register_file_inst.reg_file[12]);
  $display("x13 = %h", dut.register_file_inst.reg_file[13]);
  $display("x14 = %h", dut.register_file_inst.reg_file[14]);
  $display("x15 = %h", dut.register_file_inst.reg_file[15]);
  $display("x16 = %h", dut.register_file_inst.reg_file[16]);
  $display("x17 = %h", dut.register_file_inst.reg_file[17]);
  $display("x18 = %h", dut.register_file_inst.reg_file[18]);
  $display("x19 = %h", dut.register_file_inst.reg_file[19]);

  
  $finish;

  end
endmodule