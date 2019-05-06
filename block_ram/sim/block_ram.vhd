--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Thu Apr 11 10:27:13 2019
--Host        : DESKTOP-59BA03F running 64-bit major release  (build 9200)
--Command     : generate_target block_ram.bd
--Design      : block_ram
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity block_ram is
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
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of block_ram : entity is "block_ram,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=block_ram,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=4,numReposBlks=4,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of block_ram : entity is "block_ram.hwdef";
end block_ram;

architecture STRUCTURE of block_ram is
  component block_ram_fifo_generator_0_0 is
  port (
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC;
    almost_empty : out STD_LOGIC
  );
  end component block_ram_fifo_generator_0_0;
  component block_ram_fifo_generator_0_1 is
  port (
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC;
    almost_empty : out STD_LOGIC
  );
  end component block_ram_fifo_generator_0_1;
  component block_ram_fifo_generator_0_2 is
  port (
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC;
    almost_empty : out STD_LOGIC
  );
  end component block_ram_fifo_generator_0_2;
  component block_ram_fifo_generator_0_3 is
  port (
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 7 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC;
    almost_empty : out STD_LOGIC
  );
  end component block_ram_fifo_generator_0_3;
  signal Net : STD_LOGIC;
  signal din_0_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal din_1_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal din_2_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal din_3_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal fifo_generator_0_almost_empty : STD_LOGIC;
  signal fifo_generator_0_dout : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal fifo_generator_0_empty : STD_LOGIC;
  signal fifo_generator_0_full : STD_LOGIC;
  signal fifo_generator_1_almost_empty : STD_LOGIC;
  signal fifo_generator_1_dout : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal fifo_generator_1_empty : STD_LOGIC;
  signal fifo_generator_1_full : STD_LOGIC;
  signal fifo_generator_2_almost_empty : STD_LOGIC;
  signal fifo_generator_2_dout : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal fifo_generator_2_empty : STD_LOGIC;
  signal fifo_generator_2_full : STD_LOGIC;
  signal fifo_generator_3_almost_empty : STD_LOGIC;
  signal fifo_generator_3_dout : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal fifo_generator_3_empty : STD_LOGIC;
  signal fifo_generator_3_full : STD_LOGIC;
  signal rd_en_0_1 : STD_LOGIC;
  signal rd_en_1_1 : STD_LOGIC;
  signal rd_en_2_1 : STD_LOGIC;
  signal rd_en_3_1 : STD_LOGIC;
  signal srst_1 : STD_LOGIC;
  signal wr_en_0_1 : STD_LOGIC;
  signal wr_en_1_1 : STD_LOGIC;
  signal wr_en_2_1 : STD_LOGIC;
  signal wr_en_3_1 : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 CLK.CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN block_ram_clk, FREQ_HZ 100000000, PHASE 0.000";
  attribute X_INTERFACE_INFO of srst : signal is "xilinx.com:signal:reset:1.0 RST.SRST RST";
  attribute X_INTERFACE_PARAMETER of srst : signal is "XIL_INTERFACENAME RST.SRST, POLARITY ACTIVE_HIGH";
begin
  Net <= clk;
  almost_empty_0 <= fifo_generator_0_almost_empty;
  almost_empty_1 <= fifo_generator_1_almost_empty;
  almost_empty_2 <= fifo_generator_2_almost_empty;
  almost_empty_3 <= fifo_generator_3_almost_empty;
  din_0_1(7 downto 0) <= din_0(7 downto 0);
  din_1_1(7 downto 0) <= din_1(7 downto 0);
  din_2_1(7 downto 0) <= din_2(7 downto 0);
  din_3_1(7 downto 0) <= din_3(7 downto 0);
  dout_0(7 downto 0) <= fifo_generator_0_dout(7 downto 0);
  dout_1(7 downto 0) <= fifo_generator_1_dout(7 downto 0);
  dout_2(7 downto 0) <= fifo_generator_2_dout(7 downto 0);
  dout_3(7 downto 0) <= fifo_generator_3_dout(7 downto 0);
  empty_0 <= fifo_generator_0_empty;
  empty_1 <= fifo_generator_1_empty;
  empty_2 <= fifo_generator_2_empty;
  empty_3 <= fifo_generator_3_empty;
  full_0 <= fifo_generator_0_full;
  full_1 <= fifo_generator_1_full;
  full_2 <= fifo_generator_2_full;
  full_3 <= fifo_generator_3_full;
  rd_en_0_1 <= rd_en_0;
  rd_en_1_1 <= rd_en_1;
  rd_en_2_1 <= rd_en_2;
  rd_en_3_1 <= rd_en_3;
  srst_1 <= srst;
  wr_en_0_1 <= wr_en_0;
  wr_en_1_1 <= wr_en_1;
  wr_en_2_1 <= wr_en_2;
  wr_en_3_1 <= wr_en_3;
fifo_generator_0: component block_ram_fifo_generator_0_0
     port map (
      almost_empty => fifo_generator_0_almost_empty,
      clk => Net,
      din(7 downto 0) => din_0_1(7 downto 0),
      dout(7 downto 0) => fifo_generator_0_dout(7 downto 0),
      empty => fifo_generator_0_empty,
      full => fifo_generator_0_full,
      rd_en => rd_en_0_1,
      srst => srst_1,
      wr_en => wr_en_0_1
    );
fifo_generator_1: component block_ram_fifo_generator_0_1
     port map (
      almost_empty => fifo_generator_1_almost_empty,
      clk => Net,
      din(7 downto 0) => din_1_1(7 downto 0),
      dout(7 downto 0) => fifo_generator_1_dout(7 downto 0),
      empty => fifo_generator_1_empty,
      full => fifo_generator_1_full,
      rd_en => rd_en_1_1,
      srst => srst_1,
      wr_en => wr_en_1_1
    );
fifo_generator_2: component block_ram_fifo_generator_0_2
     port map (
      almost_empty => fifo_generator_2_almost_empty,
      clk => Net,
      din(7 downto 0) => din_2_1(7 downto 0),
      dout(7 downto 0) => fifo_generator_2_dout(7 downto 0),
      empty => fifo_generator_2_empty,
      full => fifo_generator_2_full,
      rd_en => rd_en_2_1,
      srst => srst_1,
      wr_en => wr_en_2_1
    );
fifo_generator_3: component block_ram_fifo_generator_0_3
     port map (
      almost_empty => fifo_generator_3_almost_empty,
      clk => Net,
      din(7 downto 0) => din_3_1(7 downto 0),
      dout(7 downto 0) => fifo_generator_3_dout(7 downto 0),
      empty => fifo_generator_3_empty,
      full => fifo_generator_3_full,
      rd_en => rd_en_3_1,
      srst => srst_1,
      wr_en => wr_en_3_1
    );
end STRUCTURE;
