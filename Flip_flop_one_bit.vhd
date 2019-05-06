----------------------------------------------------------------------------------
-- Author: Yangpeng Miao
-- Design Name:1-bit flip flop 
-- Module Name: Flip_flop_one_bit - Behavioral
-- Description: 
-- 
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

entity Flip_flop_one_bit is
    Port ( clk : in STD_LOGIC;
           bit_in : in STD_LOGIC;
           bit_out : out STD_LOGIC);
end Flip_flop_one_bit;

architecture Behavioral of Flip_flop_one_bit is

begin

process(clk)
begin
    if(rising_edge(clk)) then
        bit_out <= bit_in;
    end if;
end process;
end Behavioral;
