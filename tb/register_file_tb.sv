module register_file_tb;
logic clk=0; 
logic rst;
logic [4:0]  read_address1;
logic [31:0] read_data1;
logic [4:0]  read_address2;
logic [31:0] read_data2;
logic [4:0]  write_address;
logic [31:0] write_data;
logic write_enable;

register_file dut (
    .clk(clk),
    .rst(rst),
    .read_address1(read_address1),
    .read_data1(read_data1),
    .read_address2(read_address2),
    .read_data2(read_data2),
    .write_address(write_address),
    .write_data(write_data),
    .write_enable(write_enable)
);

always #5 clk=~clk;
initial begin
    rst=1;
    #20;
    rst=0;
    write_enable=1;
    write_address=5'd5;
    write_data=32'hAAAAAAAA;
    @(posedge clk); 
    write_enable=0;
    read_address1=5'd5;
    $display("write_data = %h, read_data1 = %h", write_data, read_data1);
    $finish();

    
    end
endmodule



