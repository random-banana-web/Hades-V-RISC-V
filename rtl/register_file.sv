
module register_file 
(
    input logic clk,
    input logic rst,
    // read ports
    input  logic [4:0]  read_address1, //rs1
    output logic [31:0] read_data1,     //rd1
    input  logic [4:0]  read_address2, //rs2
    output logic [31:0] read_data2,     //rd2
    // write port
    input  logic [4:0]  write_address, //rd
    input  logic [31:0] write_data,
    input  logic        write_enable
);
logic [31:0] reg_file [0:31];

always@(posedge clk)
    begin
        if(rst)
            begin
                for(int i=0;i<=31;i++)
                begin
                    reg_file[i]<=0;
                end
            end
        else if (write_enable && write_address != 5'd0) 
            begin
                reg_file[write_address]<=write_data;
            end
    end
always_comb 
    begin 
        if(read_address1==write_address && write_enable==1 && write_address!=0) //write_address!=0 to so that NOP does not trigger it
        begin
            read_data1=write_data;
        end
        else
        begin
            read_data1=reg_file[read_address1];
        end
        if(read_address2==write_address && write_enable==1 && write_address!=0)
        begin
            read_data2=write_data;
        end
        else
        begin
            read_data2=reg_file[read_address2];
        end
    end

endmodule
