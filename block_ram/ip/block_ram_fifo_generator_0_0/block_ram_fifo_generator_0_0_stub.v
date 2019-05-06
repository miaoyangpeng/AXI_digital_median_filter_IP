// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sun Mar 31 11:51:59 2019
// Host        : DESKTOP-59BA03F running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top block_ram_fifo_generator_0_0 -prefix
//               block_ram_fifo_generator_0_0_ block_ram_fifo_generator_0_0_stub.v
// Design      : block_ram_fifo_generator_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_2,Vivado 2018.2" *)
module block_ram_fifo_generator_0_0(clk, srst, din, wr_en, rd_en, dout, full, empty, 
  almost_empty)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[7:0],wr_en,rd_en,dout[7:0],full,empty,almost_empty" */;
  input clk;
  input srst;
  input [7:0]din;
  input wr_en;
  input rd_en;
  output [7:0]dout;
  output full;
  output empty;
  output almost_empty;
endmodule
