----------------------------------------------------------------------------------
-- Author: Yangpeng Miao
-- Design Name: Memory input controller
-- Module Name: mem_ctrl - Behavioral
-- Description: 
-- this model is responsible for writing data to Block RAM array. "DATA receive BUFFER controller" provides
-- BYTEs and address of each BYTE to "Memory input controller", "Memory input controller" need to figure out
-- the Block RAM array position that those BYTEs should be written in.
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

entity mem_ctrl is
  Port (
  
  
        clk : in std_logic;
        rst : in std_logic;
        
        width : in std_logic_vector(15 downto 0);
        one_width_out : out integer range 0 to 18000;--17279;
        two_width_out : out integer range 0 to 18000;--17279;
        three_width_out : out integer range 0 to 18000;--17279;
        
        data_in : in std_logic_vector(31 downto 0);
        keep_in : in std_logic_vector(3 downto 0);
        buf_add_1 : in std_logic_vector(15 downto 0);
        buf_add_2 : in std_logic_vector(15 downto 0);
        buf_add_3 : in std_logic_vector(15 downto 0);
        buf_add_4 : in std_logic_vector(15 downto 0);
        wr_en : in std_logic;
        
        din_a : out STD_LOGIC_VECTOR ( 31 downto 0 );
        din_b : out STD_LOGIC_VECTOR ( 31 downto 0 );
        wr_add_a : out STD_LOGIC_VECTOR ( 9 downto 0 );
        wr_add_b : out STD_LOGIC_VECTOR ( 9 downto 0 );
        wr_en_a_1 : out STD_LOGIC_VECTOR ( 3 downto 0 );
        wr_en_a_2 : out STD_LOGIC_VECTOR ( 3 downto 0 );
        wr_en_a_3 : out STD_LOGIC_VECTOR ( 3 downto 0 );
        wr_en_b_1 : out STD_LOGIC_VECTOR ( 3 downto 0 );
        wr_en_b_2 : out STD_LOGIC_VECTOR ( 3 downto 0 );
        wr_en_b_3 : out STD_LOGIC_VECTOR ( 3 downto 0 )
 );
end mem_ctrl;

architecture Behavioral of mem_ctrl is

    type MEM_EN is array (0 to 1,1 to 4) of std_logic_vector(3 downto 0);
    
    signal sig_mem_wen : MEM_EN :=((others => (others=>"0000")));
    signal sig_mem_en_sel : integer range 0 to 1 := 0;
    
    signal sig_wr_data :  std_logic_vector(63 downto 0) := (others => '0');
    
    signal sig_buf_add_1 : integer range 0 to 18000;--17279;
    signal sig_buf_add_2 : integer range 0 to 18000;--17279;
    signal sig_buf_add_3 : integer range 0 to 18000;--17279;    
    signal sig_buf_add_4 : integer range 0 to 18000;--17279;
    
    signal sig_mem_a_sel : integer range 1 to 3;
    signal sig_mem_b_sel : integer range 1 to 3;
    
    signal one_width : integer range 0 to 18000;--17279;
    signal two_width : integer range 0 to 18000;--17279;
    signal three_width : integer range 0 to 18000;--17279;
    
    signal sig_buf_add_obs_1 : integer range 0 to 5760;
    signal sig_buf_add_obs_2 : integer range 0 to 5760;
    signal sig_buf_add_obs_3 : integer range 0 to 5760;
    signal sig_buf_add_obs_4 : integer range 0 to 5760;
    
    signal log_buf_add_obs_1 : std_logic_vector(12 downto 0);
    signal log_buf_add_obs_2 : std_logic_vector(12 downto 0);
    signal log_buf_add_obs_3 : std_logic_vector(12 downto 0);
    signal log_buf_add_obs_4 : std_logic_vector(12 downto 0);
    -------------------------
    -----for pippe line-------------
    signal sig_mem_b_sel_1 : integer range 1 to 3;
    
    signal log_buf_add_obs_1_1 : std_logic_vector(12 downto 0);
    signal log_buf_add_obs_2_1 : std_logic_vector(12 downto 0);
    signal log_buf_add_obs_3_1 : std_logic_vector(12 downto 0);
    signal log_buf_add_obs_4_1 : std_logic_vector(12 downto 0);

    signal buf_add_1_1 : std_logic_vector(15 downto 0);
    signal buf_add_2_1 : std_logic_vector(15 downto 0);
    signal buf_add_3_1 : std_logic_vector(15 downto 0);
    signal buf_add_4_1 : std_logic_vector(15 downto 0);
    
    signal buf_add_1_2 : std_logic_vector(15 downto 0);
    signal buf_add_2_2 : std_logic_vector(15 downto 0);
    signal buf_add_3_2 : std_logic_vector(15 downto 0);
    signal buf_add_4_2 : std_logic_vector(15 downto 0);
    
    signal data_in_1 : std_logic_vector(31 downto 0);
    signal keep_in_1 : std_logic_vector(3 downto 0);
    signal wr_en_1 : std_logic;   
    ---------------------------------
    
    function get_wr_en (en_bit : std_logic) return integer is
        variable en_int : integer;
    begin
        if (en_bit = '1') then
            return 1;
        else 
            return 0;
        end if;
    end function;
    
    function get_wr_not_en (en_bit : std_logic) return integer is
        variable en_int : integer;
    begin
        if (en_bit = '1') then
            return 0;
        else 
            return 1;
        end if;
    end function;
    
    function get_wr_value (en_val : std_logic_vector(1 downto 0)) return std_logic_vector is
        variable en_bits : std_logic_vector(3 downto 0);
    begin
        case (en_val) is
            when "00" =>
                return "0001";
            when "01" =>
                return "0010";
            when "10" =>
                return "0100";
            when "11" =>
                return "1000";
        end case;
    end function;
   
begin

    one_width_out <= one_width;
    two_width_out <= two_width;
    three_width_out <= three_width;

    sig_buf_add_1 <= to_integer(unsigned(buf_add_1));
    sig_buf_add_2 <= to_integer(unsigned(buf_add_2));
    sig_buf_add_3 <= to_integer(unsigned(buf_add_3));
    sig_buf_add_4 <= to_integer(unsigned(buf_add_4));
    
    log_buf_add_obs_1 <= std_logic_vector(to_unsigned(sig_buf_add_obs_1, 13));
    log_buf_add_obs_2 <= std_logic_vector(to_unsigned(sig_buf_add_obs_2, 13));
    log_buf_add_obs_3 <= std_logic_vector(to_unsigned(sig_buf_add_obs_3, 13));
    log_buf_add_obs_4 <= std_logic_vector(to_unsigned(sig_buf_add_obs_4, 13));
    
--------------3------------------------
    process(clk)
    begin
        if(rising_edge(clk)) then
            din_a <= sig_wr_data(31 downto 0);
            din_b <= sig_wr_data(63 downto 32);
        end if;
    end process;  
 ----------3----------------------   
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(buf_add_1_2(2) = '1') then
                wr_add_b <=  log_buf_add_obs_1_1(12 downto 3);
                
                if(buf_add_1_2(15 downto 3) /= buf_add_2_2(15 downto 3)) then
                    wr_add_a <= log_buf_add_obs_2_1(12 downto 3);
                elsif(buf_add_2_2(15 downto 3) /= buf_add_3_2(15 downto 3)) then
                    wr_add_a <= log_buf_add_obs_3_1(12 downto 3);
                elsif(buf_add_3_2(15 downto 3) /= buf_add_4_2(15 downto 3)) then
                    wr_add_a <= log_buf_add_obs_4_1(12 downto 3);
                end if;          
            else
                wr_add_a <= log_buf_add_obs_1_1(12 downto 3);
                wr_add_b <= log_buf_add_obs_1_1(12 downto 3);
            end if;
        end if;
    end process;
    
    
    --------------1---------------------------------------
    process(clk)
    begin
        if(rising_edge(clk)) then
            if((sig_buf_add_1 < one_width) and (sig_buf_add_1 >= 0)) then
                sig_buf_add_obs_1 <= sig_buf_add_1;
                sig_mem_b_sel <= 1;
            elsif ((sig_buf_add_1 < two_width) and (sig_buf_add_1 >= one_width)) then
                sig_buf_add_obs_1 <= (sig_buf_add_1 - one_width);
                sig_mem_b_sel <= 2;
            elsif ((sig_buf_add_1 < three_width) and (sig_buf_add_1 >= two_width)) then
                sig_buf_add_obs_1 <= (sig_buf_add_1 - two_width);
                sig_mem_b_sel <= 3;
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if(rising_edge(clk)) then
            if((sig_buf_add_2 < one_width) and (sig_buf_add_2 >= 0)) then
                sig_buf_add_obs_2 <= sig_buf_add_2;
            elsif ((sig_buf_add_2 < two_width) and (sig_buf_add_2 >= one_width)) then
                sig_buf_add_obs_2 <= (sig_buf_add_2 - one_width);
            elsif ((sig_buf_add_2 < three_width) and (sig_buf_add_2 >= two_width)) then
                sig_buf_add_obs_2 <= (sig_buf_add_2 - two_width);
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if(rising_edge(clk)) then
            if((sig_buf_add_3 < one_width) and (sig_buf_add_3 >= 0)) then
                sig_buf_add_obs_3 <= sig_buf_add_3;
            elsif ((sig_buf_add_3 < two_width) and (sig_buf_add_3 >= one_width)) then
                sig_buf_add_obs_3 <= (sig_buf_add_3 - one_width);
            elsif ((sig_buf_add_3 < three_width) and (sig_buf_add_3 >= two_width)) then
                sig_buf_add_obs_3 <= (sig_buf_add_3 - two_width);
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if(rising_edge(clk)) then
            if((sig_buf_add_4 < one_width) and (sig_buf_add_4 >= 0)) then
                sig_buf_add_obs_4 <= sig_buf_add_4;
            elsif ((sig_buf_add_4 < two_width) and (sig_buf_add_4 >= one_width)) then
                sig_buf_add_obs_4 <= (sig_buf_add_4 - one_width);
            elsif ((sig_buf_add_4 < three_width) and (sig_buf_add_4 >= two_width)) then
                sig_buf_add_obs_4 <= (sig_buf_add_4 - two_width);
            end if;
        end if;
    end process;
    
    --------------1---------------------------------------
    
    
  ------------2--------------------------------  
    process(clk) 
    begin
        if(rising_edge(clk)) then
            if ((sig_buf_add_obs_1 /= 0) and ((sig_buf_add_obs_2 = 0) or (sig_buf_add_obs_3 = 0) or (sig_buf_add_obs_4 = 0))) then--((buf_add_2 = B"0000_0000_0000_0000") or (buf_add_3 = B"0000_0000_0000_0000") or (buf_add_4 = B"0000_0000_0000_0000")) then
                if( sig_mem_b_sel = 1) then
                    sig_mem_a_sel <= 2;
                elsif (sig_mem_b_sel = 2) then
                    sig_mem_a_sel <= 3;
                else
                    sig_mem_a_sel <= 1;
                end if;
            else
                sig_mem_a_sel <= sig_mem_b_sel;
            end if;
        end if;        
    end process;
----------------------------------------
    
    -----------3------------------------
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(sig_mem_a_sel = 1) then
                wr_en_a_1 <= (sig_mem_wen(0,4) or sig_mem_wen(0,1) or sig_mem_wen(0,2) or sig_mem_wen(0,3));
                wr_en_a_2 <= "0000";
                wr_en_a_3 <= "0000";
            elsif(sig_mem_a_sel = 2) then
                wr_en_a_1 <= "0000";
                wr_en_a_2 <= (sig_mem_wen(0,4) or sig_mem_wen(0,1) or sig_mem_wen(0,2) or sig_mem_wen(0,3));
                wr_en_a_3 <= "0000";
            else--if(sig_mem_a_sel = 3)
                wr_en_a_1 <= "0000";
                wr_en_a_2 <= "0000";
                wr_en_a_3 <= (sig_mem_wen(0,4) or sig_mem_wen(0,1) or sig_mem_wen(0,2) or sig_mem_wen(0,3));
            end if;
            
            if(sig_mem_b_sel_1 = 1) then
                wr_en_b_1 <= (sig_mem_wen(1,4) or sig_mem_wen(1,1) or sig_mem_wen(1,2) or sig_mem_wen(1,3));
                wr_en_b_2 <= "0000";
                wr_en_b_3 <= "0000";
            elsif(sig_mem_b_sel_1 = 2) then
                wr_en_b_1 <= "0000";
                wr_en_b_2 <= (sig_mem_wen(1,4) or sig_mem_wen(1,1) or sig_mem_wen(1,2) or sig_mem_wen(1,3));
                wr_en_b_3 <= "0000";
            else--if(sig_mem_a_sel = 3)
                wr_en_b_1 <= "0000";
                wr_en_b_2 <= "0000";
                wr_en_b_3 <= (sig_mem_wen(1,4) or sig_mem_wen(1,1) or sig_mem_wen(1,2) or sig_mem_wen(1,3));
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if(rising_edge(clk)) then
            one_width <= to_integer(unsigned(width)) * 3;
            two_width <= one_width + one_width; 
            three_width <= one_width * 3;
        end if;
    end process;
   
    ----------------------2---------------------------
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (wr_en_1 = '1') then           
                if(keep_in_1(0) = '1') then
                    sig_wr_data((get_wr_en(log_buf_add_obs_1(2)) * 32 + (((to_integer(unsigned(log_buf_add_obs_1(1 downto 0))) + 1) * 8) - 1)) 
                                downto get_wr_en(log_buf_add_obs_1(2)) * 32 + to_integer(unsigned(log_buf_add_obs_1(1 downto 0))) * 8)
                                <= data_in_1 (7 downto 0);
                    sig_mem_wen(get_wr_en(log_buf_add_obs_1(2)),1) <= get_wr_value(log_buf_add_obs_1(1 downto 0));
                    sig_mem_wen(get_wr_not_en(log_buf_add_obs_1(2)),1) <= "0000";     
                else
                    sig_mem_wen(0,1) <= (others => '0');
                    sig_mem_wen(1,1) <= (others => '0');
                end if;
                
                if(keep_in_1(1) = '1') then
                    sig_wr_data((get_wr_en(log_buf_add_obs_2(2)) * 32 + (((to_integer(unsigned(log_buf_add_obs_2(1 downto 0))) + 1) * 8) - 1)) 
                                downto get_wr_en(log_buf_add_obs_2(2)) * 32 + to_integer(unsigned(log_buf_add_obs_2(1 downto 0))) * 8)
                                <= data_in_1 (15 downto 8);
                    sig_mem_wen(get_wr_en(log_buf_add_obs_2(2)),2) <= get_wr_value(log_buf_add_obs_2(1 downto 0)); 
                    sig_mem_wen(get_wr_not_en(log_buf_add_obs_2(2)),2) <= "0000";
                else
                    sig_mem_wen(0,2) <= (others => '0');
                    sig_mem_wen(1,2) <= (others => '0');
                end if;
                
                if(keep_in_1(2) = '1') then
                    sig_wr_data((get_wr_en(log_buf_add_obs_3(2)) * 32 + (((to_integer(unsigned(log_buf_add_obs_3(1 downto 0))) + 1) * 8) - 1)) 
                                downto get_wr_en(log_buf_add_obs_3(2)) * 32 + to_integer(unsigned(log_buf_add_obs_3(1 downto 0))) * 8)
                                <= data_in_1 (23 downto 16);
                    sig_mem_wen(get_wr_en(log_buf_add_obs_3(2)),3) <= get_wr_value(log_buf_add_obs_3(1 downto 0)); 
                    sig_mem_wen(get_wr_not_en(log_buf_add_obs_3(2)),3) <= "0000";
                else
                    sig_mem_wen(0,3) <= (others => '0');
                    sig_mem_wen(1,3) <= (others => '0');
                end if;
                
                if(keep_in_1(3) = '1') then
                    sig_wr_data((get_wr_en(log_buf_add_obs_4(2)) * 32 + (((to_integer(unsigned(log_buf_add_obs_4(1 downto 0))) + 1) * 8) - 1)) 
                                downto get_wr_en(log_buf_add_obs_4(2)) * 32 + to_integer(unsigned(log_buf_add_obs_4(1 downto 0))) * 8)
                                <= data_in_1 (31 downto 24);
                    sig_mem_wen(get_wr_en(log_buf_add_obs_4(2)),4) <= get_wr_value(log_buf_add_obs_4(1 downto 0));
                    sig_mem_wen(get_wr_not_en(log_buf_add_obs_4(2)),4) <= "0000";
                else
                    sig_mem_wen(0,4) <= (others => '0');
                    sig_mem_wen(1,4) <= (others => '0');
                end if;
            else
                sig_mem_wen(0,1) <= (others => '0');
                sig_mem_wen(1,1) <= (others => '0');
                
                sig_mem_wen(0,2) <= (others => '0');
                sig_mem_wen(1,2) <= (others => '0');
                
                sig_mem_wen(0,3) <= (others => '0');
                sig_mem_wen(1,3) <= (others => '0');
                
                sig_mem_wen(0,4) <= (others => '0');
                sig_mem_wen(1,4) <= (others => '0');
            end if;
        end if;
    end process;
-----------------------------------------


    process(clk)
    begin
        if(rising_edge(clk)) then
            if (rst = '0') then
                sig_mem_b_sel_1 <= 1;
                
                log_buf_add_obs_1_1 <= (others => '0');
                log_buf_add_obs_2_1 <= (others => '0');
                log_buf_add_obs_3_1 <= (others => '0');
                log_buf_add_obs_4_1 <= (others => '0');

                buf_add_1_1 <= (others => '0');
                buf_add_2_1 <= (others => '0');
                buf_add_3_1 <= (others => '0');
                buf_add_4_1 <= (others => '0');
                
                buf_add_1_2 <= (others => '0');
                buf_add_2_2 <= (others => '0');
                buf_add_3_2 <= (others => '0');
                buf_add_4_2 <= (others => '0');
                
                data_in_1 <= (others => '0');
                keep_in_1 <= (others => '0');
                wr_en_1 <= '0';
            else
                sig_mem_b_sel_1 <= sig_mem_b_sel;
                
                log_buf_add_obs_1_1 <= log_buf_add_obs_1;
                log_buf_add_obs_2_1 <= log_buf_add_obs_2;
                log_buf_add_obs_3_1 <= log_buf_add_obs_3;
                log_buf_add_obs_4_1 <= log_buf_add_obs_4;
                
                buf_add_1_1 <= buf_add_1;
                buf_add_2_1 <= buf_add_2;
                buf_add_3_1 <= buf_add_3;
                buf_add_4_1 <= buf_add_4;
                
                buf_add_1_2 <= buf_add_1_1;
                buf_add_2_2 <= buf_add_2_1;
                buf_add_3_2 <= buf_add_3_1;
                buf_add_4_2 <= buf_add_4_1;
                
                data_in_1 <= data_in;
                keep_in_1 <= keep_in;
                wr_en_1 <= wr_en;
            end if;
        end if;    
    end process;


end Behavioral;
