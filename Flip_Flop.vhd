----------------------------------------------------------------------------------
-- Author: Yangpeng Miao
-- Design Name: 8-bit flip flop
-- Module Name: Flip_Flop - Behavioral
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

entity Flip_Flop is
    Port ( clk : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0)
           );
end Flip_Flop;

architecture Behavioral of Flip_Flop is

begin

process(clk)
begin
    if(rising_edge(clk)) then
        data_out <= data_in;
    end if;
end process;

end Behavioral;
