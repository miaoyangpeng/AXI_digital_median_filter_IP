----------------------------------------------------------------------------------
-- Author: Yangpeng Miao
-- Design Name: Memory output controller 
-- Module Name: mem_out_ctrl - Behavioral
-- Description: 
-- It gets control signals from "DATA receive BUFFER controller", 
-- takes necessary data from "Block RAM array", and provides data 
-- and "filter_en" signal to sorting network.
-- Bugs:
-- one known bug, but I don't know how to explain that. 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mem_out_ctrl is
  Port ( 
    clk : in std_logic;
    rst : in std_logic;
  
    filter_position : in std_logic_vector(15 downto 0);
  
    rgb_first : in std_logic_vector(1 downto 0); -- r: "00" g: "01" b:"10"
    rd_en : in std_logic;
    
    r_filter_en : in std_logic;
    g_filter_en : in std_logic;
    b_filter_en : in std_logic;
    e_filter_en : in std_logic;
    
    r_filter_en_out : out std_logic;
    g_filter_en_out : out std_logic;
    b_filter_en_out : out std_logic;
    e_filter_en_out : out std_logic;
    
    rd_add_a : out STD_LOGIC_VECTOR ( 9 downto 0 );
    rd_add_b : out STD_LOGIC_VECTOR ( 9 downto 0 );
  
    rd_a_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    rd_a_2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    rd_a_3 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    rd_b_1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    rd_b_2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    rd_b_3 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    
    data_r_out0: out std_logic_vector(7 downto 0);
    data_r_out1: out std_logic_vector(7 downto 0);
    data_r_out2: out std_logic_vector(7 downto 0);
    data_r_out3: out std_logic_vector(7 downto 0);
    data_r_out4: out std_logic_vector(7 downto 0);
    data_r_out5: out std_logic_vector(7 downto 0);
    data_r_out6: out std_logic_vector(7 downto 0);
    data_r_out7: out std_logic_vector(7 downto 0);
    data_r_out8: out std_logic_vector(7 downto 0);
     
    data_g_out0: out std_logic_vector(7 downto 0);
    data_g_out1: out std_logic_vector(7 downto 0);
    data_g_out2: out std_logic_vector(7 downto 0);
    data_g_out3: out std_logic_vector(7 downto 0);
    data_g_out4: out std_logic_vector(7 downto 0);
    data_g_out5: out std_logic_vector(7 downto 0);
    data_g_out6: out std_logic_vector(7 downto 0);
    data_g_out7: out std_logic_vector(7 downto 0);
    data_g_out8: out std_logic_vector(7 downto 0);
               
    data_b_out0: out std_logic_vector(7 downto 0);
    data_b_out1: out std_logic_vector(7 downto 0);
    data_b_out2: out std_logic_vector(7 downto 0);
    data_b_out3: out std_logic_vector(7 downto 0);
    data_b_out4: out std_logic_vector(7 downto 0);
    data_b_out5: out std_logic_vector(7 downto 0);
    data_b_out6: out std_logic_vector(7 downto 0);
    data_b_out7: out std_logic_vector(7 downto 0);
    data_b_out8: out std_logic_vector(7 downto 0);
     
    data_e_out0: out std_logic_vector(7 downto 0);
    data_e_out1: out std_logic_vector(7 downto 0);
    data_e_out2: out std_logic_vector(7 downto 0);
    data_e_out3: out std_logic_vector(7 downto 0);
    data_e_out4: out std_logic_vector(7 downto 0);
    data_e_out5: out std_logic_vector(7 downto 0);
    data_e_out6: out std_logic_vector(7 downto 0);
    data_e_out7: out std_logic_vector(7 downto 0);
    data_e_out8: out std_logic_vector(7 downto 0)
    
  );
end mem_out_ctrl;

architecture Behavioral of mem_out_ctrl is

    type OUT_DATA_BUF is array (0 to 9, 0 to 3) of std_logic_vector(7 downto 0);
    
    signal data_buf: OUT_DATA_BUF;
    signal sel_line : integer range 0 to 2:= 0;
    signal sel_line_pre : integer range 0 to 2:= 2;
    signal place_r : integer range 0 to 2;
    signal place_g : integer range 0 to 2;
    signal place_b : integer range 0 to 2;
    
    signal rd_1_data : std_logic_vector(63 downto 0);
    signal rd_2_data : std_logic_vector(63 downto 0);
    signal rd_3_data : std_logic_vector(63 downto 0);
    
    signal rd_1_simp : std_logic_vector(31 downto 0);
    signal rd_2_simp : std_logic_vector(31 downto 0);
    signal rd_3_simp : std_logic_vector(31 downto 0);
    
    signal rd_row_1_col_1 : std_logic_vector(7 downto 0);
    signal rd_row_1_col_2 : std_logic_vector(7 downto 0);
    signal rd_row_1_col_3 : std_logic_vector(7 downto 0);
    signal rd_row_1_col_4 : std_logic_vector(7 downto 0);
    
    signal rd_row_2_col_1 : std_logic_vector(7 downto 0);
    signal rd_row_2_col_2 : std_logic_vector(7 downto 0);
    signal rd_row_2_col_3 : std_logic_vector(7 downto 0);
    signal rd_row_2_col_4 : std_logic_vector(7 downto 0);
    
    signal rd_row_3_col_1 : std_logic_vector(7 downto 0);
    signal rd_row_3_col_2 : std_logic_vector(7 downto 0);
    signal rd_row_3_col_3 : std_logic_vector(7 downto 0);
    signal rd_row_3_col_4 : std_logic_vector(7 downto 0);
    
    -----------------------------------
    signal filter_position_1 : std_logic_vector(15 downto 0);
    signal filter_position_2 : std_logic_vector(15 downto 0);
    signal filter_position_3 : std_logic_vector(15 downto 0);
    signal filter_position_4 : std_logic_vector(15 downto 0);
    signal filter_position_5 : std_logic_vector(15 downto 0);
    signal filter_position_6 : std_logic_vector(15 downto 0);
    signal filter_position_7 : std_logic_vector(15 downto 0);
    signal filter_position_8 : std_logic_vector(15 downto 0);
    signal sig_filter_position : std_logic_vector(15 downto 0);
    signal filter_new_start : std_logic;
    
    signal rgb_first_1 : std_logic_vector(1 downto 0); -- r: "00" g: "01" b:"10"
    signal rgb_first_2 : std_logic_vector(1 downto 0);
    signal rgb_first_3 : std_logic_vector(1 downto 0);
    signal rgb_first_4 : std_logic_vector(1 downto 0);
    signal rgb_first_5 : std_logic_vector(1 downto 0);
    signal rgb_first_6 : std_logic_vector(1 downto 0);
    signal rgb_first_7 : std_logic_vector(1 downto 0);
    signal rgb_first_8 : std_logic_vector(1 downto 0);
    signal sig_rgb_first : std_logic_vector(1 downto 0);
    signal sig_rgb_first_next : std_logic_vector(1 downto 0);
    
    signal rd_1_data_1 : std_logic_vector(63 downto 0);
    signal rd_1_data_2 : std_logic_vector(63 downto 0);
    
    signal rd_2_data_1 : std_logic_vector(63 downto 0);
    signal rd_2_data_2 : std_logic_vector(63 downto 0);
    
    signal rd_3_data_1 : std_logic_vector(63 downto 0);
    signal rd_3_data_2 : std_logic_vector(63 downto 0);
    
    signal rd_en_1 : std_logic;
    signal rd_en_2 : std_logic;
    signal rd_en_3 : std_logic;
    signal rd_en_4 : std_logic;
    signal rd_en_5 : std_logic;
    signal rd_en_6 : std_logic;
    signal rd_en_7 : std_logic;
    signal rd_en_8 : std_logic;   
    signal sig_rd_en : std_logic;
    
    signal r_filter_en_1 : std_logic;
    signal r_filter_en_2 : std_logic;
    signal r_filter_en_3 : std_logic;
    signal r_filter_en_4 : std_logic;   
    signal r_filter_en_5 : std_logic;
    signal r_filter_en_6 : std_logic;
    signal r_filter_en_7 : std_logic;
    signal r_filter_en_8 : std_logic;
    signal r_filter_en_9 : std_logic;
    
    signal g_filter_en_1 : std_logic;
    signal g_filter_en_2 : std_logic;
    signal g_filter_en_3 : std_logic;
    signal g_filter_en_4 : std_logic;
    signal g_filter_en_5 : std_logic;
    signal g_filter_en_6 : std_logic;
    signal g_filter_en_7 : std_logic;
    signal g_filter_en_8 : std_logic;
    signal g_filter_en_9 : std_logic;
    
    signal b_filter_en_1 : std_logic;
    signal b_filter_en_2 : std_logic;
    signal b_filter_en_3 : std_logic;
    signal b_filter_en_4 : std_logic;
    signal b_filter_en_5 : std_logic;
    signal b_filter_en_6 : std_logic;
    signal b_filter_en_7 : std_logic;
    signal b_filter_en_8 : std_logic;
    signal b_filter_en_9 : std_logic;
    
    signal e_filter_en_1 : std_logic;
    signal e_filter_en_2 : std_logic;
    signal e_filter_en_3 : std_logic;
    signal e_filter_en_4 : std_logic;
    signal e_filter_en_5 : std_logic;
    signal e_filter_en_6 : std_logic;
    signal e_filter_en_7 : std_logic;
    signal e_filter_en_8 : std_logic;
    signal e_filter_en_9 : std_logic;
    --------------------------------------
begin

    data_r_out0 <= data_buf(0,0);
    data_r_out1 <= data_buf(1,0);
    data_r_out2 <= data_buf(2,0);
    data_r_out3 <= data_buf(3,0);
    data_r_out4 <= data_buf(4,0);
    data_r_out5 <= data_buf(5,0);
    data_r_out6 <= data_buf(6,0);
    data_r_out7 <= data_buf(7,0);
    data_r_out8 <= data_buf(8,0);
     
    data_g_out0 <= data_buf(0,1);
    data_g_out1 <= data_buf(1,1);
    data_g_out2 <= data_buf(2,1);
    data_g_out3 <= data_buf(3,1);
    data_g_out4 <= data_buf(4,1);
    data_g_out5 <= data_buf(5,1);
    data_g_out6 <= data_buf(6,1);
    data_g_out7 <= data_buf(7,1);
    data_g_out8 <= data_buf(8,1);
    
    data_b_out0 <= data_buf(0,2);
    data_b_out1 <= data_buf(1,2);
    data_b_out2 <= data_buf(2,2);
    data_b_out3 <= data_buf(3,2);
    data_b_out4 <= data_buf(4,2);
    data_b_out5 <= data_buf(5,2);
    data_b_out6 <= data_buf(6,2);
    data_b_out7 <= data_buf(7,2);
    data_b_out8 <= data_buf(8,2);
     
    data_e_out0 <= data_buf(0,3);
    data_e_out1 <= data_buf(1,3);
    data_e_out2 <= data_buf(2,3);
    data_e_out3 <= data_buf(3,3);
    data_e_out4 <= data_buf(4,3);
    data_e_out5 <= data_buf(5,3);
    data_e_out6 <= data_buf(6,3);
    data_e_out7 <= data_buf(7,3);
    data_e_out8 <= data_buf(8,3);

    --1---
    process(clk)
    begin
        if(rising_edge(clk)) then
            rd_add_b <= filter_position_4(12 downto 3);
            if(filter_position_4(2) = '0') then
                rd_add_a <= filter_position_4(12 downto 3);
            else
                rd_add_a <= std_logic_vector(unsigned(filter_position_4(12 downto 3)) + 1);
            end if;
        end if;
    end process;
    
    --2--
    -- No operation, "Block RAM array" take one clock cycle's time to provide data.
    --3--
    process(clk)
    begin
        if(rising_edge(clk)) then       
            if (filter_position_6(2) = '0') then
                rd_1_data <= (rd_b_1 & rd_a_1);
            else
                rd_1_data <= (rd_a_1 & rd_b_1);
            end if;
            
            if (filter_position_6(2) = '0') then
                rd_2_data <= (rd_b_2 & rd_a_2);
            else
                rd_2_data <= (rd_a_2 & rd_b_2);
            end if;
            
            if (filter_position_6(2) = '0') then
                rd_3_data <= (rd_b_3 & rd_a_3);
            else
                rd_3_data <= (rd_a_3 & rd_b_3);
            end if;
        end if;
    end process;
    
    ----4---
    process(clk)
    begin   
        if(rising_edge(clk)) then 
        rd_1_simp <= rd_1_data((to_integer(unsigned(filter_position_7(1 downto 0))) * 8) + 31 
                                downto (to_integer(unsigned(filter_position_7(1 downto 0))) * 8));
        rd_2_simp <= rd_2_data((to_integer(unsigned(filter_position_7(1 downto 0))) * 8) + 31 
                                downto (to_integer(unsigned(filter_position_7(1 downto 0))) * 8));
        rd_3_simp <= rd_3_data((to_integer(unsigned(filter_position_7(1 downto 0))) * 8) + 31 
                                downto (to_integer(unsigned(filter_position_7(1 downto 0))) * 8));
        end if;
    end process;
    
    --5--
    process(clk)
    begin
        if(rising_edge(clk)) then 
            rd_row_1_col_1 <= rd_1_simp(7 downto 0);
            rd_row_1_col_2 <= rd_1_simp(15 downto 8);
            rd_row_1_col_3 <= rd_1_simp(23 downto 16);
            rd_row_1_col_4 <= rd_1_simp(31 downto 24);
            
            rd_row_2_col_1 <= rd_2_simp(7 downto 0);
            rd_row_2_col_2 <= rd_2_simp(15 downto 8);
            rd_row_2_col_3 <= rd_2_simp(23 downto 16);
            rd_row_2_col_4 <= rd_2_simp(31 downto 24);     
            
            rd_row_3_col_1 <= rd_3_simp(7 downto 0);
            rd_row_3_col_2 <= rd_3_simp(15 downto 8);
            rd_row_3_col_3 <= rd_3_simp(23 downto 16);
            rd_row_3_col_4 <= rd_3_simp(31 downto 24);
        end if;
    end process;
    
    
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rgb_first_8 = "01") then
                place_r <= 1;
                place_g <= 2;
                place_b <= 0;
            elsif(rgb_first_8 = "10") then
                place_r <= 2;
                place_g <= 0;
                place_b <= 1;
            else --if(sig_rgb_first = "00") then
                place_r <= 0;
                place_g <= 1;
                place_b <= 2;
            end if;
        end if;
    end process;

  ----------6------------------------
    process(clk)
    begin
        if(rising_edge(clk)) then
            r_filter_en_out <= r_filter_en_9;
            g_filter_en_out <= g_filter_en_9;
            b_filter_en_out <= b_filter_en_9;
            e_filter_en_out <= e_filter_en_9;
        end if;
    end process;
  
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '0' ) then
                sel_line <= 0;
                sel_line_pre <= 2;
                
                filter_new_start <= '0';
            elsif (sig_filter_position = B"0000_0000_0000_0000") then
                data_buf(1,0) <= rd_1_data_2 (7 downto 0);
                data_buf(1,1) <= rd_1_data_2 (15 downto 8);                
                data_buf(1,2) <= rd_1_data_2 (23 downto 16);                
                data_buf(0,0) <= rd_1_data_2 (31 downto 24);               
                data_buf(0,1) <= rd_1_data_2 (39 downto 32);               
                data_buf(0,2) <= rd_1_data_2 (47 downto 40);
                
                data_buf(4,0) <= rd_2_data_2 (7 downto 0);               
                data_buf(4,1) <= rd_2_data_2 (15 downto 8);                
                data_buf(4,2) <= rd_2_data_2 (23 downto 16);                
                data_buf(3,0) <= rd_2_data_2 (31 downto 24);               
                data_buf(3,1) <= rd_2_data_2 (39 downto 32);               
                data_buf(3,2) <= rd_2_data_2 (47 downto 40);
                
                data_buf(7,0) <= rd_3_data_2 (7 downto 0);               
                data_buf(7,1) <= rd_3_data_2 (15 downto 8);                
                data_buf(7,2) <= rd_3_data_2 (23 downto 16);                
                data_buf(6,0) <= rd_3_data_2 (31 downto 24);               
                data_buf(6,1) <= rd_3_data_2 (39 downto 32);               
                data_buf(6,2) <= rd_3_data_2 (47 downto 40);
                
                filter_new_start <= '1';
                
            elsif(sig_rd_en = '1') then
                
                data_buf(0,place_r) <= rd_row_1_col_1;
                data_buf(0,place_g) <= rd_row_1_col_2;
                data_buf(0,place_b) <= rd_row_1_col_3;
                
                data_buf(3,place_r) <= rd_row_2_col_1;
                data_buf(3,place_g) <= rd_row_2_col_2;
                data_buf(3,place_b) <= rd_row_2_col_3;
                
                data_buf(6,place_r) <= rd_row_3_col_1;
                data_buf(6,place_g) <= rd_row_3_col_2;
                data_buf(6,place_b) <= rd_row_3_col_3;
                
                
                if((sig_rgb_first = sig_rgb_first_next) or (filter_new_start = '1')) then
                    data_buf(1,0) <= data_buf(0,0);
                    data_buf(2,0) <= data_buf(1,0);
                    data_buf(4,0) <= data_buf(3,0);
                    data_buf(5,0) <= data_buf(4,0);
                    data_buf(7,0) <= data_buf(6,0);
                    data_buf(8,0) <= data_buf(7,0);
                    
                    data_buf(1,1) <= data_buf(0,1);
                    data_buf(2,1) <= data_buf(1,1);
                    data_buf(4,1) <= data_buf(3,1);
                    data_buf(5,1) <= data_buf(4,1);
                    data_buf(7,1) <= data_buf(6,1);
                    data_buf(8,1) <= data_buf(7,1);
                    
                    data_buf(1,2) <= data_buf(0,2);
                    data_buf(2,2) <= data_buf(1,2);
                    data_buf(4,2) <= data_buf(3,2);
                    data_buf(5,2) <= data_buf(4,2);
                    data_buf(7,2) <= data_buf(6,2);
                    data_buf(8,2) <= data_buf(7,2);
                    
                    filter_new_start <= '0';
                elsif(place_r = 1) then  -- this time is green, means last time extra is red
                    data_buf(1,0) <= data_buf(6,3);
                    data_buf(4,0) <= data_buf(7,3);
                    data_buf(7,0) <= data_buf(8,3);
                    
                    data_buf(2,0) <= data_buf(0,0);
                    data_buf(5,0) <= data_buf(3,0);
                    data_buf(8,0) <= data_buf(6,0);
                    
                    data_buf(1,1) <= data_buf(0,1);
                    data_buf(2,1) <= data_buf(1,1);
                    data_buf(4,1) <= data_buf(3,1);
                    data_buf(5,1) <= data_buf(4,1);
                    data_buf(7,1) <= data_buf(6,1);
                    data_buf(8,1) <= data_buf(7,1);
                    
                    data_buf(1,2) <= data_buf(0,2);
                    data_buf(2,2) <= data_buf(1,2);
                    data_buf(4,2) <= data_buf(3,2);
                    data_buf(5,2) <= data_buf(4,2);
                    data_buf(7,2) <= data_buf(6,2);
                    data_buf(8,2) <= data_buf(7,2);
                elsif(place_r = 2) then -- last time is green, this time is blue
                    data_buf(1,1) <= data_buf(6,3);
                    data_buf(4,1) <= data_buf(7,3);
                    data_buf(7,1) <= data_buf(8,3);
                    
                    data_buf(2,1) <= data_buf(0,1);
                    data_buf(5,1) <= data_buf(3,1);
                    data_buf(8,1) <= data_buf(6,1);
                    
                    data_buf(1,0) <= data_buf(0,0);
                    data_buf(2,0) <= data_buf(1,0);
                    data_buf(4,0) <= data_buf(3,0);
                    data_buf(5,0) <= data_buf(4,0);
                    data_buf(7,0) <= data_buf(6,0);
                    data_buf(8,0) <= data_buf(7,0);
                    
                    data_buf(1,2) <= data_buf(0,2);
                    data_buf(2,2) <= data_buf(1,2);
                    data_buf(4,2) <= data_buf(3,2);
                    data_buf(5,2) <= data_buf(4,2);
                    data_buf(7,2) <= data_buf(6,2);
                    data_buf(8,2) <= data_buf(7,2);
                else
                    data_buf(1,2) <= data_buf(6,3);
                    data_buf(4,2) <= data_buf(7,3);
                    data_buf(7,2) <= data_buf(8,3);
                    
                    data_buf(2,2) <= data_buf(0,2);
                    data_buf(5,2) <= data_buf(3,2);
                    data_buf(8,2) <= data_buf(6,2);
                    
                    data_buf(1,1) <= data_buf(0,1);
                    data_buf(2,1) <= data_buf(1,1);
                    data_buf(4,1) <= data_buf(3,1);
                    data_buf(5,1) <= data_buf(4,1);
                    data_buf(7,1) <= data_buf(6,1);
                    data_buf(8,1) <= data_buf(7,1);
                    
                    data_buf(1,0) <= data_buf(0,0);
                    data_buf(2,0) <= data_buf(1,0);
                    data_buf(4,0) <= data_buf(3,0);
                    data_buf(5,0) <= data_buf(4,0);
                    data_buf(7,0) <= data_buf(6,0);
                    data_buf(8,0) <= data_buf(7,0);
                end if;

                data_buf(6,3) <= rd_row_1_col_4;
                data_buf(7,3) <= rd_row_2_col_4;
                data_buf(8,3) <= rd_row_3_col_4;

                data_buf(0,3) <= data_buf(0,to_integer(unsigned(sig_rgb_first)));
                data_buf(1,3) <= data_buf(3,to_integer(unsigned(sig_rgb_first)));
                data_buf(2,3) <= data_buf(6,to_integer(unsigned(sig_rgb_first)));
            
                data_buf(3,3) <= rd_row_1_col_1;
                data_buf(4,3) <= rd_row_2_col_1;
                data_buf(5,3) <= rd_row_3_col_1;
                
                if(sel_line = 0) then
                    sel_line <= 1;
                    sel_line_pre <= 0;
                elsif(sel_line = 1) then
                    sel_line <= 2;
                    sel_line_pre <= 1;
                else
                    sel_line <= 0;
                    sel_line_pre <= 2;
                end if;
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '0') then
                filter_position_1 <= (others => '0');
                filter_position_2 <= (others => '0');
                filter_position_3 <= (others => '0');
                filter_position_4 <= (others => '0');
                filter_position_5 <= (others => '0');
                filter_position_6 <= (others => '0');
                filter_position_7 <= (others => '0');
                sig_filter_position <= (others => '0');
                
                rgb_first_1 <= (others => '0');
                rgb_first_2 <= (others => '0');
                rgb_first_3 <= (others => '0');
                rgb_first_4 <= (others => '0');
                rgb_first_5 <= (others => '0');
                rgb_first_6 <= (others => '0');
                rgb_first_7 <= (others => '0');
                rgb_first_8 <= (others => '0');
                sig_rgb_first <= (others => '0');
                sig_rgb_first_next <= (others => '0');
                
                rd_1_data_1 <= (others => '0');
                rd_1_data_2 <= (others => '0');
                  
                rd_2_data_1 <= (others => '0');
                rd_2_data_2 <= (others => '0');
                  
                rd_3_data_1 <= (others => '0');
                rd_3_data_2 <= (others => '0');
                
                rd_en_1 <= '0';
                rd_en_2 <= '0';
                rd_en_3 <= '0';
                rd_en_4 <= '0';
                rd_en_5 <= '0';                
                rd_en_6 <= '0';
                rd_en_7 <= '0';
                sig_rd_en <= '0';
                
                r_filter_en_1 <= '0';
                r_filter_en_2 <= '0';
                r_filter_en_3 <= '0';
                r_filter_en_4 <= '0';
                r_filter_en_5 <= '0';
                r_filter_en_6 <= '0';
                r_filter_en_7 <= '0';
                r_filter_en_8 <= '0';
                
                g_filter_en_1 <= '0';
                g_filter_en_2 <= '0';
                g_filter_en_3 <= '0';
                g_filter_en_4 <= '0';
                g_filter_en_5 <= '0';
                g_filter_en_6 <= '0';
                g_filter_en_7 <= '0';
                g_filter_en_8 <= '0';
                
                b_filter_en_1 <= '0';
                b_filter_en_2 <= '0';
                b_filter_en_3 <= '0';
                b_filter_en_4 <= '0';
                b_filter_en_5 <= '0';
                b_filter_en_6 <= '0';
                b_filter_en_7 <= '0';
                b_filter_en_8 <= '0';
                
                e_filter_en_1 <= '0';
                e_filter_en_2 <= '0';
                e_filter_en_3 <= '0';
                e_filter_en_4 <= '0';
                e_filter_en_5 <= '0';
                e_filter_en_6 <= '0';
                e_filter_en_7 <= '0';
                e_filter_en_8 <= '0';
            else
                sig_filter_position <= filter_position_8;
                filter_position_8 <= filter_position_7;
                filter_position_7 <= filter_position_6;
                filter_position_6 <= filter_position_5;
                filter_position_5 <= filter_position_4;
                filter_position_4 <= filter_position_3;
                filter_position_3 <= filter_position_2;
                filter_position_2 <= filter_position_1;
                filter_position_1 <= filter_position;
                
                sig_rgb_first_next <= sig_rgb_first;
                sig_rgb_first <= rgb_first_8;
                rgb_first_8 <= rgb_first_7;
                rgb_first_7 <= rgb_first_6;
                rgb_first_6 <= rgb_first_5;
                rgb_first_5 <= rgb_first_4;
                rgb_first_4 <= rgb_first_3;
                rgb_first_3 <= rgb_first_2;
                rgb_first_2 <= rgb_first_1;
                rgb_first_1 <= rgb_first;
                
                rd_1_data_1 <= rd_1_data;
                rd_1_data_2 <= rd_1_data_1;
                  
                rd_2_data_1 <= rd_2_data;
                rd_2_data_2 <= rd_2_data_1;
                  
                rd_3_data_1 <= rd_3_data;
                rd_3_data_2 <= rd_3_data_1;
                
                sig_rd_en <= rd_en_8;
                rd_en_8 <= rd_en_7;
                rd_en_7 <= rd_en_6;
                rd_en_6 <= rd_en_5;
                rd_en_5 <= rd_en_4;
                rd_en_4 <= rd_en_3;
                rd_en_3 <= rd_en_2;
                rd_en_2 <= rd_en_1;
                rd_en_1 <= rd_en;
                
                r_filter_en_9 <= r_filter_en_8;
                r_filter_en_8 <= r_filter_en_7;
                r_filter_en_7 <= r_filter_en_6;
                r_filter_en_6 <= r_filter_en_5;
                r_filter_en_5 <= r_filter_en_4;
                r_filter_en_4 <= r_filter_en_3;
                r_filter_en_3 <= r_filter_en_2;
                r_filter_en_2 <= r_filter_en_1;
                r_filter_en_1 <= r_filter_en;
                
                g_filter_en_9 <= g_filter_en_8;
                g_filter_en_8 <= g_filter_en_7;
                g_filter_en_7 <= g_filter_en_6;
                g_filter_en_6 <= g_filter_en_5;
                g_filter_en_5 <= g_filter_en_4;
                g_filter_en_4 <= g_filter_en_3;
                g_filter_en_3 <= g_filter_en_2;
                g_filter_en_2 <= g_filter_en_1;
                g_filter_en_1 <= g_filter_en;
                
                b_filter_en_9 <= b_filter_en_8;
                b_filter_en_8 <= b_filter_en_7;
                b_filter_en_7 <= b_filter_en_6;
                b_filter_en_6 <= b_filter_en_5;
                b_filter_en_5 <= b_filter_en_4;
                b_filter_en_4 <= b_filter_en_3;
                b_filter_en_3 <= b_filter_en_2;
                b_filter_en_2 <= b_filter_en_1;
                b_filter_en_1 <= b_filter_en;   
                
                e_filter_en_9 <= e_filter_en_8;
                e_filter_en_8 <= e_filter_en_7;
                e_filter_en_7 <= e_filter_en_6;
                e_filter_en_6 <= e_filter_en_5;
                e_filter_en_5 <= e_filter_en_4;
                e_filter_en_4 <= e_filter_en_3;
                e_filter_en_3 <= e_filter_en_2;
                e_filter_en_2 <= e_filter_en_1;
                e_filter_en_1 <= e_filter_en;  
            end if;
      end if;
    end process;
    
    

end Behavioral;
