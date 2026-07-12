/* Copyright (c) 2024 Tobias Scheipel, David Beikircher, Florian Riedl
 * Embedded Architectures & Systems Group, Graz University of Technology
 * SPDX-License-Identifier: MIT
 * ---------------------------------------------------------------------
 * File: register_file.sv
 */



module register_file (
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
assign read_data1=reg_file[read_address1];
assign read_data2=reg_file[read_address2];
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

    // TODO: Delete the following line and implement this module.
    

endmodule
