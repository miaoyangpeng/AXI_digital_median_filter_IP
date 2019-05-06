--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Sun Mar 31 01:21:23 2019
--Host        : DESKTOP-59BA03F running 64-bit major release  (build 9200)
--Command     : generate_target input_buf_top.bd
--Design      : input_buf_top
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity input_buf_top is
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
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of input_buf_top : entity is "input_buf_top,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=input_buf_top,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=6,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of input_buf_top : entity is "input_buf_top.hwdef";
end input_buf_top;

architecture STRUCTURE of input_buf_top is
  component input_buf_top_blk_mem_gen_1_0 is
  port (
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clkb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component input_buf_top_blk_mem_gen_1_0;
  component input_buf_top_blk_mem_gen_2_0 is
  port (
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clkb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component input_buf_top_blk_mem_gen_2_0;
  component input_buf_top_blk_mem_gen_3_0 is
  port (
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clkb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component input_buf_top_blk_mem_gen_3_0;
  component input_buf_top_blk_mem_gen_4_0 is
  port (
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clkb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component input_buf_top_blk_mem_gen_4_0;
  component input_buf_top_blk_mem_gen_5_0 is
  port (
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clkb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component input_buf_top_blk_mem_gen_5_0;
  component input_buf_top_blk_mem_gen_6_0 is
  port (
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 9 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    clkb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 9 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component input_buf_top_blk_mem_gen_6_0;
  signal Net : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal Net2 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal Net4 : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal addra_0_1 : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal blk_mem_gen_1_doutb : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal blk_mem_gen_2_doutb : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal blk_mem_gen_3_doutb : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal blk_mem_gen_4_doutb : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal blk_mem_gen_5_doutb : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal blk_mem_gen_6_doutb : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal clka_0_1 : STD_LOGIC;
  signal dina_0_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal wea_0_1 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal wea_0_2 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal wea_0_3 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal wea_0_4 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal wea_0_5 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal wea_1_1 : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal wr_add : STD_LOGIC_VECTOR ( 9 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN input_buf_top_clka_0, FREQ_HZ 100000000, PHASE 0.000";
begin
  Net(9 downto 0) <= rd_add_b(9 downto 0);
  Net2(31 downto 0) <= din_a(31 downto 0);
  Net4(9 downto 0) <= rd_add_a(9 downto 0);
  addra_0_1(9 downto 0) <= wr_add_b(9 downto 0);
  clka_0_1 <= clk;
  dina_0_1(31 downto 0) <= din_b(31 downto 0);
  dout_a_1(31 downto 0) <= blk_mem_gen_1_doutb(31 downto 0);
  dout_a_2(31 downto 0) <= blk_mem_gen_3_doutb(31 downto 0);
  dout_a_3(31 downto 0) <= blk_mem_gen_5_doutb(31 downto 0);
  dout_b_1(31 downto 0) <= blk_mem_gen_2_doutb(31 downto 0);
  dout_b_2(31 downto 0) <= blk_mem_gen_4_doutb(31 downto 0);
  dout_b_3(31 downto 0) <= blk_mem_gen_6_doutb(31 downto 0);
  wea_0_1(3 downto 0) <= wr_en_a_1(3 downto 0);
  wea_0_2(3 downto 0) <= wr_en_a_2(3 downto 0);
  wea_0_3(3 downto 0) <= wr_en_a_3(3 downto 0);
  wea_0_4(3 downto 0) <= wr_en_b_2(3 downto 0);
  wea_0_5(3 downto 0) <= wr_en_b_3(3 downto 0);
  wea_1_1(3 downto 0) <= wr_en_b_1(3 downto 0);
  wr_add(9 downto 0) <= wr_add_a(9 downto 0);
blk_mem_gen_1: component input_buf_top_blk_mem_gen_1_0
     port map (
      addra(9 downto 0) => wr_add(9 downto 0),
      addrb(9 downto 0) => Net4(9 downto 0),
      clka => clka_0_1,
      clkb => clka_0_1,
      dina(31 downto 0) => Net2(31 downto 0),
      doutb(31 downto 0) => blk_mem_gen_1_doutb(31 downto 0),
      wea(3 downto 0) => wea_0_1(3 downto 0)
    );
blk_mem_gen_2: component input_buf_top_blk_mem_gen_2_0
     port map (
      addra(9 downto 0) => addra_0_1(9 downto 0),
      addrb(9 downto 0) => Net(9 downto 0),
      clka => clka_0_1,
      clkb => clka_0_1,
      dina(31 downto 0) => dina_0_1(31 downto 0),
      doutb(31 downto 0) => blk_mem_gen_2_doutb(31 downto 0),
      wea(3 downto 0) => wea_1_1(3 downto 0)
    );
blk_mem_gen_3: component input_buf_top_blk_mem_gen_3_0
     port map (
      addra(9 downto 0) => wr_add(9 downto 0),
      addrb(9 downto 0) => Net4(9 downto 0),
      clka => clka_0_1,
      clkb => clka_0_1,
      dina(31 downto 0) => Net2(31 downto 0),
      doutb(31 downto 0) => blk_mem_gen_3_doutb(31 downto 0),
      wea(3 downto 0) => wea_0_2(3 downto 0)
    );
blk_mem_gen_4: component input_buf_top_blk_mem_gen_4_0
     port map (
      addra(9 downto 0) => addra_0_1(9 downto 0),
      addrb(9 downto 0) => Net(9 downto 0),
      clka => clka_0_1,
      clkb => clka_0_1,
      dina(31 downto 0) => dina_0_1(31 downto 0),
      doutb(31 downto 0) => blk_mem_gen_4_doutb(31 downto 0),
      wea(3 downto 0) => wea_0_4(3 downto 0)
    );
blk_mem_gen_5: component input_buf_top_blk_mem_gen_5_0
     port map (
      addra(9 downto 0) => wr_add(9 downto 0),
      addrb(9 downto 0) => Net4(9 downto 0),
      clka => clka_0_1,
      clkb => clka_0_1,
      dina(31 downto 0) => Net2(31 downto 0),
      doutb(31 downto 0) => blk_mem_gen_5_doutb(31 downto 0),
      wea(3 downto 0) => wea_0_3(3 downto 0)
    );
blk_mem_gen_6: component input_buf_top_blk_mem_gen_6_0
     port map (
      addra(9 downto 0) => addra_0_1(9 downto 0),
      addrb(9 downto 0) => Net(9 downto 0),
      clka => clka_0_1,
      clkb => clka_0_1,
      dina(31 downto 0) => dina_0_1(31 downto 0),
      doutb(31 downto 0) => blk_mem_gen_6_doutb(31 downto 0),
      wea(3 downto 0) => wea_0_5(3 downto 0)
    );
end STRUCTURE;
