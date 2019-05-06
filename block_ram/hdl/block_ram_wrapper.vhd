--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Thu Apr 11 10:27:13 2019
--Host        : DESKTOP-59BA03F running 64-bit major release  (build 9200)
--Command     : generate_target block_ram_wrapper.bd
--Design      : block_ram_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity block_ram_wrapper is
  port (
    almost_empty_0 : out STD_LOGIC;
    almost_empty_1 : out STD_LOGIC;
    almost_empty_2 : out STD_LOGIC;
    almost_empty_3 : out STD_LOGIC;
    clk : in STD_LOGIC;
    din_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    din_1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    din_2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    din_3 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    dout_0 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    dout_1 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    dout_2 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    dout_3 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    empty_0 : out STD_LOGIC;
    empty_1 : out STD_LOGIC;
    empty_2 : out STD_LOGIC;
    empty_3 : out STD_LOGIC;
    full_0 : out STD_LOGIC;
    full_1 : out STD_LOGIC;
    full_2 : out STD_LOGIC;
    full_3 : out STD_LOGIC;
    rd_en_0 : in STD_LOGIC;
    rd_en_1 : in STD_LOGIC;
    rd_en_2 : in STD_LOGIC;
    rd_en_3 : in STD_LOGIC;
    srst : in STD_LOGIC;
    wr_en_0 : in STD_LOGIC;
    wr_en_1 : in STD_LOGIC;
    wr_en_2 : in STD_LOGIC;
    wr_en_3 : in STD_LOGIC
  );
end block_ram_wrapper;

architecture STRUCTURE of block_ram_wrapper is
  component block_ram is
  port (
    srst : in STD_LOGIC;
    clk : in STD_LOGIC;
    full_0 : out STD_LOGIC;
    din_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en_0 : in STD_LOGIC;
    empty_0 : out STD_LOGIC;
    dout_0 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rd_en_0 : in STD_LOGIC;
    full_1 : out STD_LOGIC;
    din_1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en_1 : in STD_LOGIC;
    empty_1 : out STD_LOGIC;
    dout_1 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rd_en_1 : in STD_LOGIC;
    full_2 : out STD_LOGIC;
    din_2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en_2 : in STD_LOGIC;
    empty_2 : out STD_LOGIC;
    dout_2 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rd_en_2 : in STD_LOGIC;
    full_3 : out STD_LOGIC;
    din_3 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en_3 : in STD_LOGIC;
    empty_3 : out STD_LOGIC;
    dout_3 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    rd_en_3 : in STD_LOGIC;
    almost_empty_1 : out STD_LOGIC;
    almost_empty_0 : out STD_LOGIC;
    almost_empty_2 : out STD_LOGIC;
    almost_empty_3 : out STD_LOGIC
  );
  end component block_ram;
begin
block_ram_i: component block_ram
     port map (
      almost_empty_0 => almost_empty_0,
      almost_empty_1 => almost_empty_1,
      almost_empty_2 => almost_empty_2,
      almost_empty_3 => almost_empty_3,
      clk => clk,
      din_0(7 downto 0) => din_0(7 downto 0),
      din_1(7 downto 0) => din_1(7 downto 0),
      din_2(7 downto 0) => din_2(7 downto 0),
      din_3(7 downto 0) => din_3(7 downto 0),
      dout_0(7 downto 0) => dout_0(7 downto 0),
      dout_1(7 downto 0) => dout_1(7 downto 0),
      dout_2(7 downto 0) => dout_2(7 downto 0),
      dout_3(7 downto 0) => dout_3(7 downto 0),
      empty_0 => empty_0,
      empty_1 => empty_1,
      empty_2 => empty_2,
      empty_3 => empty_3,
      full_0 => full_0,
      full_1 => full_1,
      full_2 => full_2,
      full_3 => full_3,
      rd_en_0 => rd_en_0,
      rd_en_1 => rd_en_1,
      rd_en_2 => rd_en_2,
      rd_en_3 => rd_en_3,
      srst => srst,
      wr_en_0 => wr_en_0,
      wr_en_1 => wr_en_1,
      wr_en_2 => wr_en_2,
      wr_en_3 => wr_en_3
    );
end STRUCTURE;
