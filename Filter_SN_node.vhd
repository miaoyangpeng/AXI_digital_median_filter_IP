----------------------------------------------------------------------------------
-- Author: Yangpeng Miao
-- Design Name: Sorting Network Basic Node
-- Module Name: Filter_SN_node - Behavioral 
-- Description: 
-- A, B is two input data, if A > B, then the output higher <= A, lower <= B. If B > A, then higher <= B, lower <= A. 
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

entity Filter_SN_node is
  Port (
        clk : in std_logic;
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        
        MAX : out std_logic_vector(7 downto 0);
        MIN : out std_logic_vector(7 downto 0)
  );
end Filter_SN_node;

architecture Behavioral of Filter_SN_node is

begin

process(clk)
begin
    if(rising_edge(clk)) then
        if(A > B) then
            MAX <= A;
            MIN <= B;
        else
            MIN <= A;
            MAX <= B;
        end if;
    end if;
end process;

end Behavioral;
