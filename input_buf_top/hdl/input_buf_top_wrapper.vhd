--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Sun Mar 31 01:21:23 2019
--Host        : DESKTOP-59BA03F running 64-bit major release  (build 9200)
--Command     : generate_target input_buf_top_wrapper.bd
--Design      : input_buf_top_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity input_buf_top_wrapper is
  port (
    clk : in STD_LOGIC;
    din_a : in STD_LOGIC_VECTOR ( 31 downto 0 );
    din_b : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dout_a_1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dout_a_2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dout_a_3 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dout_b_1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dout_b_2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dout_b_3 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rd_add_a : in STD_LOGIC_VECTOR ( 9 downto 0 );
    rd_add_b : in STD_LOGIC_VECTOR ( 9 downto 0 );
    wr_add_a : in STD_LOGIC_VECTOR ( 9 downto 0 );
    wr_add_b : in STD_LOGIC_VECTOR ( 9 downto 0 );
    wr_en_a_1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    wr_en_a_2 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    wr_en_a_3 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    wr_en_b_1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    wr_en_b_2 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    wr_en_b_3 : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end input_buf_top_wrapper;

architecture STRUCTURE of input_buf_top_wrapper is
  component input_buf_top is
  port (
    din_a : in STD_LOGIC_VECTOR ( 31 downto 0 );
    rd_add_a : in STD_LOGIC_VECTOR ( 9 downto 0 );
    wr_en_a_1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    wr_add_a : in STD_LOGIC_VECTOR ( 9 downto 0 );
    wr_en_b_1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    clk : in STD_LOGIC;
    dout_a_1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    din_b : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wr_add_b : in STD_LOGIC_VECTOR ( 9 downto 0 );
    rd_add_b : in STD_LOGIC_VECTOR ( 9 downto 0 );
    dout_b_1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    wr_en_a_2 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    wr_en_a_3 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    wr_en_b_2 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    wr_en_b_3 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dout_a_2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dout_a_3 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dout_b_2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dout_b_3 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component input_buf_top;
begin
input_buf_top_i: component input_buf_top
     port map (
      clk => clk,
      din_a(31 downto 0) => din_a(31 downto 0),
      din_b(31 downto 0) => din_b(31 downto 0),
      dout_a_1(31 downto 0) => dout_a_1(31 downto 0),
      dout_a_2(31 downto 0) => dout_a_2(31 downto 0),
      dout_a_3(31 downto 0) => dout_a_3(31 downto 0),
      dout_b_1(31 downto 0) => dout_b_1(31 downto 0),
      dout_b_2(31 downto 0) => dout_b_2(31 downto 0),
      dout_b_3(31 downto 0) => dout_b_3(31 downto 0),
      rd_add_a(9 downto 0) => rd_add_a(9 downto 0),
      rd_add_b(9 downto 0) => rd_add_b(9 downto 0),
      wr_add_a(9 downto 0) => wr_add_a(9 downto 0),
      wr_add_b(9 downto 0) => wr_add_b(9 downto 0),
      wr_en_a_1(3 downto 0) => wr_en_a_1(3 downto 0),
      wr_en_a_2(3 downto 0) => wr_en_a_2(3 downto 0),
      wr_en_a_3(3 downto 0) => wr_en_a_3(3 downto 0),
      wr_en_b_1(3 downto 0) => wr_en_b_1(3 downto 0),
      wr_en_b_2(3 downto 0) => wr_en_b_2(3 downto 0),
      wr_en_b_3(3 downto 0) => wr_en_b_3(3 downto 0)
    );
end STRUCTURE;
