----------------------------------------------------------------------------------
-- Author: Yangpeng Miao
-- Design Name: Sorting Network TOP file
-- Module Name: Filter_SN - Behavioral
-- Description: 
-- TOP file of Sorting Network. 9 input data, output is their Median Value.
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

entity Filter_SN is
  Port ( 
        clk : in std_logic;
        
        data_out : out std_logic_vector(7 downto 0);
        
        data_0: in std_logic_vector(7 downto 0);
        data_1: in std_logic_vector(7 downto 0);
        data_2: in std_logic_vector(7 downto 0);
        data_3: in std_logic_vector(7 downto 0);
        data_4: in std_logic_vector(7 downto 0);
        data_5: in std_logic_vector(7 downto 0);
        data_6: in std_logic_vector(7 downto 0);
        data_7: in std_logic_vector(7 downto 0);
        data_8: in std_logic_vector(7 downto 0);
        
        filter_in_keep : in std_logic;
        filter_out_keep : out std_logic
  );
end Filter_SN;

architecture Behavioral of Filter_SN is

    component Filter_SN_node is
    Port (
        clk : in std_logic;
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        
        MAX : out std_logic_vector(7 downto 0);
        MIN : out std_logic_vector(7 downto 0)
    );
    end component Filter_SN_node;

    component Flip_Flop is
    Port ( clk : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (7 downto 0);
           data_out : out STD_LOGIC_VECTOR (7 downto 0)
           );
    end component Flip_Flop;
    
    component Flip_flop_one_bit is
        Port ( clk : in STD_LOGIC;
               bit_in : in STD_LOGIC;
               bit_out : out STD_LOGIC);
    end component Flip_flop_one_bit;

    signal sig_1_0, sig_1_1, sig_1_2, sig_1_3, sig_1_4, sig_1_5, sig_1_6, sig_1_7, sig_1_8 : std_logic_vector(7 downto 0);
    signal sig_2_0, sig_2_1, sig_2_2, sig_2_3, sig_2_4, sig_2_5, sig_2_6, sig_2_7, sig_2_8 : std_logic_vector(7 downto 0);
    signal sig_3_0, sig_3_1, sig_3_2, sig_3_3, sig_3_4, sig_3_5, sig_3_6, sig_3_7, sig_3_8 : std_logic_vector(7 downto 0);
    signal sig_4_0, sig_4_1, sig_4_2, sig_4_3, sig_4_4, sig_4_5, sig_4_6 : std_logic_vector(7 downto 0);
    signal sig_5_0, sig_5_1, sig_5_2, sig_5_3 : std_logic_vector(7 downto 0);
    signal sig_6_0, sig_6_1, sig_6_2 : std_logic_vector(7 downto 0);
    signal sig_7_0, sig_7_1, sig_7_2 : std_logic_vector(7 downto 0);
    signal sig_8_0, sig_8_1 : std_logic_vector(7 downto 0);
    
    signal sig_keep_1, sig_keep_2, sig_keep_3, sig_keep_4, sig_keep_5, sig_keep_6, sig_keep_7, sig_keep_8: std_logic;
begin
    ------------------------------
    C1_1 : Filter_SN_node port map( clk => clk, A => data_0, B => data_1, MAX => sig_1_0, MIN => sig_1_1 );   
    R1_1 : Flip_Flop port map( clk => clk, data_in => data_2, data_out => sig_1_2 );    
    C1_2 : Filter_SN_node port map( clk => clk, A => data_3, B => data_4, MAX => sig_1_3, MIN => sig_1_4 );   
    R1_2 : Flip_Flop port map( clk => clk, data_in => data_5, data_out => sig_1_5 );
    C1_3 : Filter_SN_node port map( clk => clk, A => data_6, B => data_7, MAX => sig_1_6, MIN => sig_1_7 );   
    R1_3 : Flip_Flop port map( clk => clk, data_in => data_8, data_out => sig_1_8 );
    -----------------------------------
    R2_1 : Flip_Flop port map( clk => clk, data_in => sig_1_0, data_out => sig_2_0 );    
    C2_1 : Filter_SN_node port map( clk => clk, A => sig_1_1, B => sig_1_2, MAX => sig_2_1, MIN => sig_2_2 ); 
    R2_2 : Flip_Flop port map( clk => clk, data_in => sig_1_3, data_out => sig_2_3 );
    C2_2 : Filter_SN_node port map( clk => clk, A => sig_1_4, B => sig_1_5, MAX => sig_2_4, MIN => sig_2_5 );   
    R2_3 : Flip_Flop port map( clk => clk, data_in => sig_1_6, data_out => sig_2_6 );
    C2_3 : Filter_SN_node port map( clk => clk, A => sig_1_7, B => sig_1_8, MAX => sig_2_7, MIN => sig_2_8 );   
    ----------------------------------
    C3_1 : Filter_SN_node port map( clk => clk, A => sig_2_0, B => sig_2_1, MAX => sig_3_0, MIN => sig_3_1 );   
    R3_1 : Flip_Flop port map( clk => clk, data_in => sig_2_2, data_out => sig_3_2 );    
    C3_2 : Filter_SN_node port map( clk => clk, A => sig_2_3, B => sig_2_4, MAX => sig_3_3, MIN => sig_3_4 );   
    R3_2 : Flip_Flop port map( clk => clk, data_in => sig_2_5, data_out => sig_3_5 );
    C3_3 : Filter_SN_node port map( clk => clk, A => sig_2_6, B => sig_2_7, MAX => sig_3_6, MIN => sig_3_7 );   
    R3_3 : Flip_Flop port map( clk => clk, data_in => sig_2_8, data_out => sig_3_8 );
    ----------------------------------
    C4_1 : Filter_SN_node port map( clk => clk, A => sig_3_0, B => sig_3_3, MIN => sig_4_0 );   
    R4_1 : Flip_Flop port map( clk => clk, data_in => sig_3_6, data_out => sig_4_1 );    
    C4_2 : Filter_SN_node port map( clk => clk, A => sig_3_1, B => sig_3_4, MAX => sig_4_2, MIN => sig_4_3 );   
    R4_2 : Flip_Flop port map( clk => clk, data_in => sig_3_7, data_out => sig_4_4 );
    R4_3 : Flip_Flop port map( clk => clk, data_in => sig_3_2, data_out => sig_4_5 );
    C4_3 : Filter_SN_node port map( clk => clk, A => sig_3_5, B => sig_3_8, MAX => sig_4_6 );
    ---------------------------------
    C5_1 : Filter_SN_node port map( clk => clk, A => sig_4_0, B => sig_4_1, MIN => sig_5_0 );  
    R5_1 : Flip_Flop port map( clk => clk, data_in => sig_4_2, data_out => sig_5_1 );
    C5_2 : Filter_SN_node port map( clk => clk, A => sig_4_3, B => sig_4_4, MAX => sig_5_2 );   
    C5_3 : Filter_SN_node port map( clk => clk, A => sig_4_5, B => sig_4_6, MAX => sig_5_3 );
    ----------------------------------    
    R6_1 : Flip_Flop port map( clk => clk, data_in => sig_5_0, data_out => sig_6_0 ); 
    C6_1 : Filter_SN_node port map( clk => clk, A => sig_5_1, B => sig_5_2, MIN => sig_6_1 );
    R6_2 : Flip_Flop port map( clk => clk, data_in => sig_5_3, data_out => sig_6_2 );
    --------------------------------
    C7_1 : Filter_SN_node port map( clk => clk, A => sig_6_0, B => sig_6_1, MAX => sig_7_0, MIN => sig_7_1 );  
    R7_1 : Flip_Flop port map( clk => clk, data_in => sig_6_2, data_out => sig_7_2 );
    -----------------
    R8_1 : Flip_Flop port map( clk => clk, data_in => sig_7_0, data_out => sig_8_0 );
    C8_1 : Filter_SN_node port map( clk => clk, A => sig_7_1, B => sig_7_2, MAX => sig_8_1 );  
    ------------------
    C9_1 : Filter_SN_node port map( clk => clk, A => sig_8_0, B => sig_8_1, MIN => data_out ); 
    -----------------------------------
    
    Rkeep_0 : Flip_flop_one_bit port map( clk => clk, bit_in => filter_in_keep, bit_out => sig_keep_1 );
    Rkeep_1 : Flip_flop_one_bit port map( clk => clk, bit_in => sig_keep_1, bit_out => sig_keep_2 );
    Rkeep_2 : Flip_flop_one_bit port map( clk => clk, bit_in => sig_keep_2, bit_out => sig_keep_3 );
    Rkeep_3 : Flip_flop_one_bit port map( clk => clk, bit_in => sig_keep_3, bit_out => sig_keep_4 );
    Rkeep_4 : Flip_flop_one_bit port map( clk => clk, bit_in => sig_keep_4, bit_out => sig_keep_5 );
    Rkeep_5 : Flip_flop_one_bit port map( clk => clk, bit_in => sig_keep_5, bit_out => sig_keep_6 );
    Rkeep_6 : Flip_flop_one_bit port map( clk => clk, bit_in => sig_keep_6, bit_out => sig_keep_7 );
    Rkeep_7 : Flip_flop_one_bit port map( clk => clk, bit_in => sig_keep_7, bit_out => sig_keep_8 );
    Rkeep_8 : Flip_flop_one_bit port map( clk => clk, bit_in => sig_keep_8, bit_out => filter_out_keep );
    
end Behavioral;
