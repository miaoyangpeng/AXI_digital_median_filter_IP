----------------------------------------------------------------------------------
-- Author: Yangpeng Miao
-- Design Name: DATA output FIFO
-- Module Name: buf_send - Behavioral
-- Description: 
-- The main purpose of this FIFO is to save some output data, in case DMA channel slave is stopped. 
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

entity buf_send is
  Port (
  
  
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        
        data_r : in STD_LOGIC_VECTOR (7 downto 0);
        data_g : in STD_LOGIC_VECTOR (7 downto 0);
        data_b : in STD_LOGIC_VECTOR (7 downto 0);
        data_e : in STD_LOGIC_VECTOR (7 downto 0);
        
        data_r_keep : in STD_LOGIC;
        data_g_keep : in STD_LOGIC;
        data_b_keep : in STD_LOGIC;
        data_e_keep : in STD_LOGIC;
        
        read_en : in STD_LOGIC;    
        fifo_rd_en : out STD_LOGIC;
        
        m00_axis_tlast : in std_logic;
        
        get_done : in std_logic;
        
        one_width_get : in integer range 0 to 18000;
        
        data_out : out STD_LOGIC_VECTOR (31 downto 0);
        data_keep : out STD_LOGIC_VECTOR (3 downto 0);
        buf_pre_empty : out std_logic;
        buf_empty : out STD_LOGIC;
        buf_full : out std_logic
   );
end buf_send;

architecture Behavioral of buf_send is

component block_ram_wrapper is
  port (
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    
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
    
    wr_en_0 : in STD_LOGIC;
    wr_en_1 : in STD_LOGIC;
    wr_en_2 : in STD_LOGIC;
    wr_en_3 : in STD_LOGIC;
    
    almost_empty_0 : out STD_LOGIC;
    almost_empty_1 : out STD_LOGIC;
    almost_empty_2 : out STD_LOGIC;
    almost_empty_3 : out STD_LOGIC
  );
end component block_ram_wrapper;
type WR_DATA  is array (0 to 3) of std_logic_vector(7 downto 0);
type WR_ENABLE  is array (0 to 3) of std_logic;

    signal wr_din : WR_DATA;
    signal wr_en : WR_ENABLE;  
    
    signal n_rst : std_logic;
    
    signal dout_0 : STD_LOGIC_VECTOR ( 7 downto 0 );
    signal dout_1 : STD_LOGIC_VECTOR ( 7 downto 0 );
    signal dout_2 : STD_LOGIC_VECTOR ( 7 downto 0 );
    signal dout_3 : STD_LOGIC_VECTOR ( 7 downto 0 );
    
    signal empty_0 : STD_LOGIC;
    signal empty_1 : STD_LOGIC;
    signal empty_2 : STD_LOGIC;
    signal empty_3 : STD_LOGIC;
    
    signal full_0 : STD_LOGIC;
    signal full_1 : STD_LOGIC;
    signal full_2 : STD_LOGIC;
    signal full_3 : STD_LOGIC;
    
    signal rd_en_0 : STD_LOGIC;
    signal rd_en_1 : STD_LOGIC;
    signal rd_en_2 : STD_LOGIC;
    signal rd_en_3 : STD_LOGIC;
    
    
    signal almost_empty_0 : STD_LOGIC;
    signal almost_empty_1 : STD_LOGIC;
    signal almost_empty_2 : STD_LOGIC;
    signal almost_empty_3 : STD_LOGIC;
-------------------------------------
    type DATA_RGBE is array (0 to 3) of std_logic_vector(7 downto 0); 
    

    signal rgbe_arrange : DATA_RGBE;
    
    signal rgbe_sel : integer range 0 to 2;
    signal rgbe_sel_one : integer range 0 to 2;
    signal rgbe_sel_two : integer range 0 to 2;
    signal rgbe_sel_three : integer range 0 to 2;
    signal rgbe_sel_four : integer range 0 to 2;
    
    signal buf_position : unsigned(1 downto 0);
    signal buf_position_one : unsigned(1 downto 0);
    signal buf_position_two : unsigned(1 downto 0);
    signal buf_position_three : unsigned(1 downto 0);
    signal buf_position_four : unsigned(1 downto 0);
    
    signal sig_buf_position : integer range 0 to 3;
    signal sig_buf_position_one : integer range 0 to 3;
    signal sig_buf_position_two : integer range 0 to 3;
    signal sig_buf_position_three : integer range 0 to 3;
    signal sig_buf_position_four : integer range 0 to 3;
    

    signal sig_buf_empty, sig_buf_full : std_logic;
    
    signal buf_done : std_logic := '0';
    signal buf_idle : std_logic := '0';
    signal buf_idle_0 : std_logic := '0';
    
    signal one_width : integer range 0 to 18000;
    signal width_count : integer range 0 to 18000;
    -------------------------------

begin

FIFO_BLOCK: block_ram_wrapper
  port map (
    clk => clk,
    srst => n_rst,
    
    din_0 => wr_din(0),
    din_1 => wr_din(1),
    din_2 => wr_din(2),
    din_3 => wr_din(3),
    
    dout_0 => dout_0,
    dout_1 => dout_1,
    dout_2 => dout_2,
    dout_3 => dout_3,
    
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
    
    wr_en_0 => wr_en(0),
    wr_en_1 => wr_en(1),
    wr_en_2 => wr_en(2),
    wr_en_3 => wr_en(3),
    
    almost_empty_0 => almost_empty_0,
    almost_empty_1 => almost_empty_1,
    almost_empty_2 => almost_empty_2,
    almost_empty_3 => almost_empty_3
  );

    fifo_rd_en <= rd_en_0 or rd_en_1 or rd_en_2 or rd_en_3;
    buf_empty <= sig_buf_empty;
    buf_full <= sig_buf_full;
    buf_pre_empty <= '1' when ((almost_empty_0 = '1') and (data_r_keep = '0') and (data_g_keep = '0') and (data_b_keep = '0') and (data_e_keep = '0') and 
                                (wr_en(0) = '0') and (wr_en(1) = '0') and (wr_en(2) = '0') and (wr_en(3) = '0')) else
                    '0';-- almost_empty_0;
    
    sig_buf_empty <= empty_0 and empty_1 and empty_2 and empty_3;
                    
    sig_buf_full <= full_0 or full_1 or full_2 or full_3;

    rgbe_arrange(0) <= data_r;
    rgbe_arrange(1) <= data_g;
    rgbe_arrange(2) <= data_b;
    rgbe_arrange(3) <= data_e;
    

    process(buf_position)
    begin
        buf_position_one <= buf_position + 1;
        buf_position_two <= buf_position + 2;
        buf_position_three <= buf_position + 3;
        buf_position_four <= buf_position + 4;
    end process;

    process(rgbe_sel)
    begin
        if(rgbe_sel = 0) then
            rgbe_sel_one <= 1;
            rgbe_sel_two <= 2;
            rgbe_sel_three <= 0;
            rgbe_sel_four <= 1;
        elsif(rgbe_sel = 1) then
            rgbe_sel_one <= 2;
            rgbe_sel_two <= 0;
            rgbe_sel_three <= 1;
            rgbe_sel_four <= 2;
        else --if(rgbe_sel = 2) then
            rgbe_sel_one <= 0;
            rgbe_sel_two <= 1;
            rgbe_sel_three <= 2;
            rgbe_sel_four <= 0;
        end if;
    end process;
    
    sig_buf_position <= to_integer(buf_position);
    sig_buf_position_one <= to_integer(buf_position_one);
    sig_buf_position_two <= to_integer(buf_position_two);
    sig_buf_position_three <= to_integer(buf_position_three);
    sig_buf_position_four <= to_integer(buf_position_four);
     
    data_out <= dout_3 & dout_2 & dout_1 & dout_0;
    
    process(clk)
    begin
        if(rising_edge(clk)) then
        if((rst <= '0') or (buf_done = '1')) then
            data_keep <= "1111";
        else
            if((rd_en_0 and rd_en_1 and rd_en_2 and rd_en_3) = '1') then
                data_keep <= "1111";
            elsif((rd_en_0 and rd_en_1 and rd_en_2) = '1') then
                data_keep <= "0111";
            elsif((rd_en_0 and rd_en_1) = '1') then
                data_keep <= "0011";
            elsif((rd_en_0) = '1') then
                data_keep <= "0001";
            else
                
            end if;
        end if;
        end if;
    end process;
    
    process(empty_0,empty_1,empty_2,empty_3,sig_buf_empty,read_en,almost_empty_0,data_r_keep,data_g_keep,data_b_keep,data_e_keep)
    begin
        if((read_en = '1') and sig_buf_empty = '0') then
            if((empty_0 or empty_1 or empty_2 or empty_3) = '0') then
                rd_en_0 <= '1';
                rd_en_1 <= '1';
                rd_en_2 <= '1';
                rd_en_3 <= '1';
            elsif((get_done = '1') and (wr_en(0) = '0') and (wr_en(1) = '0') and (wr_en(2) = '0') and (wr_en(3) = '0') and 
                    (almost_empty_0 = '1') and (data_r_keep = '0') and (data_g_keep = '0') and (data_b_keep = '0') and (data_e_keep = '0')) then
                if((empty_0 or empty_1 or empty_2) = '0') then
                    rd_en_0 <= '1';
                    rd_en_1 <= '1';
                    rd_en_2 <= '1';
                    rd_en_3 <= '0';
                elsif((empty_0 or empty_1) = '0') then
                    rd_en_0 <= '1';
                    rd_en_1 <= '1';
                    rd_en_2 <= '0';
                    rd_en_3 <= '0';
                else --if((empty_0) = '0') then
                    rd_en_0 <= '1';
                    rd_en_1 <= '0';
                    rd_en_2 <= '0';
                    rd_en_3 <= '0';
                end if;
            else
                rd_en_0 <= '0';
                rd_en_1 <= '0';
                rd_en_2 <= '0';
                rd_en_3 <= '0';         
            end if;
        else
            rd_en_0 <= '0';
            rd_en_1 <= '0';
            rd_en_2 <= '0';
            rd_en_3 <= '0';
        end if;

    end process;
    
    
    process (clk)
    begin
    if(rising_edge(clk)) then
        if((rst = '0') or (buf_done = '1')) then
            one_width <= 0;
        else
            if(one_width = 0) then
                if(data_r_keep ='1') then
                    one_width <= one_width_get;
                end if;
            end if;
        end if;
    end if;
    
    end process;
    process (clk)
    begin
    if(rising_edge(clk)) then
        if((rst = '0') or (buf_done = '1')) then
            rgbe_sel <= 0;
            buf_position <= "00";
            wr_en(0) <= '0';
            wr_en(1) <= '0';
            wr_en(2) <= '0';
            wr_en(3) <= '0';
            width_count <= 0;
        elsif((sig_buf_full = '0')) then
            if ((data_r_keep ='1') and (data_g_keep = '1') and (data_b_keep = '1') and (data_e_keep = '1')) then 
                wr_din(sig_buf_position) <= rgbe_arrange(rgbe_sel);
                wr_din(sig_buf_position_one) <= rgbe_arrange(rgbe_sel_one);
                wr_din(sig_buf_position_two) <= rgbe_arrange(rgbe_sel_two);
                wr_din(sig_buf_position_three) <= rgbe_arrange(3);
                
                wr_en(0) <= '1';
                wr_en(1) <= '1';
                wr_en(2) <= '1';
                wr_en(3) <= '1';
                
                buf_position <= buf_position_four;
                rgbe_sel <= rgbe_sel_one;
                width_count <= width_count + 4;
            elsif ((data_r_keep ='1') and (data_g_keep = '1') and (data_b_keep = '1') and (data_e_keep = '0')) then 
                wr_din(sig_buf_position) <= rgbe_arrange(rgbe_sel);
                wr_din(sig_buf_position_one) <= rgbe_arrange(rgbe_sel_one);
                wr_din(sig_buf_position_two) <= rgbe_arrange(rgbe_sel_two);
                
                wr_en(sig_buf_position) <= '1';
                wr_en(sig_buf_position_one) <= '1';
                wr_en(sig_buf_position_two) <= '1';
                wr_en(sig_buf_position_three) <= '0';
                
                buf_position <= buf_position_three;
                width_count <= width_count + 3;
            elsif ((data_r_keep ='0') and (data_g_keep = '1') and (data_b_keep = '1') and (data_e_keep = '0')) then  
                wr_din(sig_buf_position) <= rgbe_arrange(1);
                wr_din(sig_buf_position_one) <= rgbe_arrange(2);
                
                rgbe_sel <= 0;
                
                if(width_count >= one_width - 8) then
                    wr_din(sig_buf_position_two) <= (others => '0');
                    wr_din(sig_buf_position_three) <= (others => '0');
                    buf_position <= buf_position_four;
                    wr_en(0) <= '1';
                    wr_en(1) <= '1';
                    wr_en(2) <= '1';
                    wr_en(3) <= '1';                  
                    width_count <= width_count + 4;
                else
                    buf_position <= buf_position_two;                  
                    wr_en(sig_buf_position) <= '1';
                    wr_en(sig_buf_position_one) <= '1';
                    wr_en(sig_buf_position_two) <= '0';
                    wr_en(sig_buf_position_three) <= '0';
                    width_count <= width_count + 2;
                end if;
                
            elsif ((data_r_keep ='0') and (data_g_keep = '0') and (data_b_keep = '1') and (data_e_keep = '0')) then 
                wr_din(sig_buf_position) <= rgbe_arrange(2);
                
                rgbe_sel <= 0;
                
                if(width_count >= one_width - 7) then
                    wr_din(sig_buf_position_one) <= (others => '0');
                    wr_din(sig_buf_position_two) <= (others => '0');
                    wr_din(sig_buf_position_three) <= (others => '0');
                    buf_position <= buf_position_four;
                    wr_en(0) <= '1';
                    wr_en(1) <= '1';
                    wr_en(2) <= '1';
                    wr_en(3) <= '1';                  
                    width_count <= width_count + 4;
                else
                    buf_position <= buf_position_one;                  
                    wr_en(sig_buf_position) <= '1';
                    wr_en(sig_buf_position_one) <= '0';
                    wr_en(sig_buf_position_two) <= '0';
                    wr_en(sig_buf_position_three) <= '0';
                    width_count <= width_count + 1;
                end if;
            else
            
                if(width_count >= one_width - 6) then
                    wr_din(sig_buf_position) <= (others => '0');
                    wr_din(sig_buf_position_one) <= (others => '0');
                    wr_din(sig_buf_position_two) <= (others => '0');
                    wr_din(sig_buf_position_three) <= (others => '0');
                    
                    if(width_count >= one_width) then
                        wr_en(0) <= '0';
                        wr_en(1) <= '0';
                        wr_en(2) <= '0';
                        wr_en(3) <= '0';
                        width_count <= 0;
                    elsif(width_count >= one_width - 1) then
                        wr_en(sig_buf_position) <= '1';
                        wr_en(sig_buf_position_one) <= '0';
                        wr_en(sig_buf_position_two) <= '0';
                        wr_en(sig_buf_position_three) <= '0';
                        buf_position <= buf_position_one;
                        width_count <= 0;
                    elsif(width_count >= one_width - 2) then
                        wr_en(sig_buf_position) <= '1';
                        wr_en(sig_buf_position_one) <= '1';
                        wr_en(sig_buf_position_two) <= '0';
                        wr_en(sig_buf_position_three) <= '0';
                        buf_position <= buf_position_two;
                        width_count <= 0;
                    elsif(width_count >= one_width - 3) then
                        wr_en(sig_buf_position) <= '1';
                        wr_en(sig_buf_position_one) <= '1';
                        wr_en(sig_buf_position_two) <= '1';
                        wr_en(sig_buf_position_three) <= '0';
                        buf_position <= buf_position_three;
                        width_count <= 0;
                    elsif(width_count >= one_width - 4) then
                        wr_en(sig_buf_position) <= '1';
                        wr_en(sig_buf_position_one) <= '1';
                        wr_en(sig_buf_position_two) <= '1';
                        wr_en(sig_buf_position_three) <= '1';
                        buf_position <= buf_position_four;
                        width_count <= 0;
                    else
                        wr_en(sig_buf_position) <= '1';
                        wr_en(sig_buf_position_one) <= '1';
                        wr_en(sig_buf_position_two) <= '1';
                        wr_en(sig_buf_position_three) <= '1';
                        buf_position <= buf_position_four;
                        width_count <= width_count + 4;
                    end if;
                else                
                    wr_en(0) <= '0';
                    wr_en(1) <= '0';
                    wr_en(2) <= '0';
                    wr_en(3) <= '0';
                end if;
                
                
                
            end if;
        else
            wr_en(0) <= '0';
            wr_en(1) <= '0';
            wr_en(2) <= '0';
            wr_en(3) <= '0';  
        end if;
    end if;
    end process;
    
    process(clk)
    begin
    if(rising_edge(clk)) then
        if(rst = '0') then
            buf_idle <= '0';
        elsif((m00_axis_tlast = '1')) then
            buf_idle <= '1';
        elsif(m00_axis_tlast = '0') then
            buf_idle <= '0';
        end if;
        
        buf_idle_0 <= buf_idle;
    end if;
    
    end process;
    
    process(clk)
    begin
    if(rising_edge(clk)) then
        if((buf_idle_0 = '0') and (buf_idle = '1')) then
            buf_done <= '1';
        else
            buf_done <= '0';
        end if;
    end if;
    end process;

    process(clk)
    begin
    if(rising_edge(clk)) then
        if((rst = '0') or(buf_done = '1'))  then
            n_rst <= '1';
        else
            n_rst <= '0';
        end if;
    end if;
    end process;
end Behavioral;
