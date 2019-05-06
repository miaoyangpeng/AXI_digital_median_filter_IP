----------------------------------------------------------------------------------
-- Author: Yangpeng Miao
-- Design Name: AXI receiver
-- Module Name: Filter_receive - Behavioral
-- Description: 
-- AXI4-Stream Slave interface. Receivering data from "AXI DMA" IP. Make IP slave interface compatible with AXI4-stream protocol
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Filter_receive is
  Port ( 
        clk	: in std_logic;
        rst : in std_logic;
        
        data_out : out std_logic_vector(31 downto 0);
        keep_out : out std_logic_vector(3 downto 0);
        
        trans_start: out std_logic := '0';   
        trans_en : out std_logic := '0';
        
        buf_full : in std_logic;
        
        s00_axis_tready   : out std_logic;
        s00_axis_tdata    : in std_logic_vector(31 downto 0);
        s00_axis_tkeep    : in std_logic_vector(3 downto 0);
        s00_axis_tlast    : in std_logic;
        s00_axis_tvalid   : in std_logic
          );
end Filter_receive;

architecture Behavioral of Filter_receive is
    signal axi_get_ready : std_logic;
    
    signal sig_trans_start : std_logic := '0';
begin

    s00_axis_tready <= axi_get_ready;
    
    trans_start <= sig_trans_start;
    
    axi_get_ready <= (not buf_full);
    
    trans_en <= '1' when ((axi_get_ready = '1') and (s00_axis_tvalid = '1') and (sig_trans_start = '1')) else '0';
    
    sig_trans_start <= '1' when ((s00_axis_tlast = '0') and (axi_get_ready = '1') and (s00_axis_tvalid = '1') and (sig_trans_start = '0')) else
                       '0' when ((s00_axis_tlast = '1') and (sig_trans_start = '1'));
    
    data_out <= s00_axis_tdata;
    keep_out <= s00_axis_tkeep;
    
    
end Behavioral;
