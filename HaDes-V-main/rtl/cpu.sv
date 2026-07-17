/* Copyright (c) 2024 Tobias Scheipel, David Beikircher, Florian Riedl
 * Embedded Architectures & Systems Group, Graz University of Technology
 * SPDX-License-Identifier: MIT
 * ---------------------------------------------------------------------
 * File: cpu.sv
 */



module cpu (
    input logic clk,
    input logic rst,

);
    register_file rf_inst (
    .read_address1(rs1),
    .read_address2(rs2),
    .write_address(rd),
    .write_data(),
    .read_data1(rd1),
    .read_data2(rd2),
    .write_enable(write_enable),
    .clk(clk),
);
decode_stage dec1 (
    
    
);

);


endmodule
