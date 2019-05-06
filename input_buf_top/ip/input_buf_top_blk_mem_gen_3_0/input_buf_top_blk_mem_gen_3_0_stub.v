// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Wed Mar 27 00:35:10 2019
// Host        : DESKTOP-59BA03F running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top input_buf_top_blk_mem_gen_3_0 -prefix
//               input_buf_top_blk_mem_gen_3_0_ input_buf_top_blk_mem_gen_2_0_stub.v
// Design      : input_buf_top_blk_mem_gen_2_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module input_buf_top_blk_mem_gen_3_0(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[3:0],addra[9:0],dina[31:0],clkb,addrb[9:0],doutb[31:0]" */;
  input clka;
  input [3:0]wea;
  input [9:0]addra;
  input [31:0]dina;
  input clkb;
  input [9:0]addrb;
  output [31:0]doutb;
endmodule
