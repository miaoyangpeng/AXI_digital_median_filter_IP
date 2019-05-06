----------------------------------------------------------------------------------
-- Author: Yangpeng Miao
-- Design Name: DATA input BUFFER TOP file
-- Module Name: buf_ctr - Behavioral
-- Description: 
-- Top file of DATA input BUFFER, to connect Block RAM array, Memory Input controller and Memory Output controller.
-- To storage at least three lines image data. And distribute those data to Sorting Networks
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

entity buf_ctr is
    Port (           
    clk : in std_logic;
    rst : in std_logic;
    
    data_in : in std_logic_vector(31 downto 0);
    keep_in : in std_logic_vector(3 downto 0);
    
    trans_start: in std_logic;   --set as '0' 1 clock after the last data sent
    trans_en : in std_logic;
    
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
    data_e_out8: out std_logic_vector(7 downto 0);
    
    extra_filter_en: out std_logic;
    filter_start : out std_logic;
    r_filter_en : out std_logic;
    g_filter_en : out std_logic;
    b_filter_en : out std_logic;
    
    one_width_out : out integer range 0 to 18000
    );
end buf_ctr;
    
architecture Behavioral of buf_ctr is

    component mem_out_ctrl is
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
    end component mem_out_ctrl;
  
    component input_buf_top_wrapper is
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
    end component input_buf_top_wrapper;
    
    component mem_ctrl is
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
    end component mem_ctrl;
    
    signal din_a : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal din_b : STD_LOGIC_VECTOR ( 31 downto 0 );
    
    signal ram_data_out_a_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal ram_data_out_a_2 : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal ram_data_out_a_3 : STD_LOGIC_VECTOR ( 31 downto 0 );
    
    signal ram_data_out_b_1 : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal ram_data_out_b_2 : STD_LOGIC_VECTOR ( 31 downto 0 );
    signal ram_data_out_b_3 : STD_LOGIC_VECTOR ( 31 downto 0 );
    
    signal rd_add_a : STD_LOGIC_VECTOR ( 9 downto 0 );
    signal rd_add_b : STD_LOGIC_VECTOR ( 9 downto 0 );
    
    signal wr_add_a : STD_LOGIC_VECTOR ( 9 downto 0 );
    signal wr_add_b : STD_LOGIC_VECTOR ( 9 downto 0 );
    
    signal wr_en_a_1 : STD_LOGIC_VECTOR ( 3 downto 0 );
    signal wr_en_a_2 : STD_LOGIC_VECTOR ( 3 downto 0 );
    signal wr_en_a_3 : STD_LOGIC_VECTOR ( 3 downto 0 );
    signal wr_en_b_1 : STD_LOGIC_VECTOR ( 3 downto 0 );
    signal wr_en_b_2 : STD_LOGIC_VECTOR ( 3 downto 0 );
    signal wr_en_b_3 : STD_LOGIC_VECTOR ( 3 downto 0 );
    ------------------------------------------------------------
    signal mem_ctrl_data_in : std_logic_vector(31 downto 0);
    signal mem_ctrl_keep_in : std_logic_vector(3 downto 0);
    
    signal width : std_logic_vector(15 downto 0);
        
    signal buf_add_1 : std_logic_vector(15 downto 0);
    signal buf_add_2 : std_logic_vector(15 downto 0);
    signal buf_add_3 : std_logic_vector(15 downto 0);
    signal buf_add_4 : std_logic_vector(15 downto 0);
    signal wr_en :  std_logic;
    
    signal filter_position : std_logic_vector(15 downto 0);   
    signal rgb_first : std_logic_vector(1 downto 0); -- r: "00" g: "01" b:"10"
    signal rd_en : std_logic;
  -----------------------------------------------------------------
    type IRAM is array (0 to 10) of std_logic_vector(7 downto 0);
    signal sig_wh : IRAM;
    
    signal sig_buf_add: integer range 0 to 18000 := 17285;--17279;
    signal sig_buf_add_one : integer range 0 to 18000 := 17286;--17279;
    signal sig_buf_add_two : integer range 0 to 18000 := 17287;--17279;
    signal sig_buf_add_three : integer range 0 to 18000 := 17288;--17279;
    signal sig_buf_add_four : integer range 0 to 18000 := 0;--17279;
    signal sig_buf_add_obs : integer range 0 to 5760;
    signal sig_buf_add_wr: integer range 0 to 18000;
    
    signal sig_new_line : std_logic := '0';
    signal sig_new_line_coming : std_logic := '0';
    
    signal one_width : integer range 0 to 18000;--17279;
    signal two_width : integer range 0 to 18000;--17279;
    signal three_width : integer range 0 to 18000;--17279;
    
    signal sig_filter_position : integer range 0 to 5760; --1920 * 3;
    signal filter_next_position : integer range 0 to 5760; --1920 * 3;
    
    signal sig_filter_start : std_logic := '0';
    signal sig_r_filter_en : std_logic;    
    signal sig_g_filter_en : std_logic;    
    signal sig_b_filter_en : std_logic;    
    signal sig_extra_filter_en : std_logic;
    signal filter_start_expire : integer range 0 to 60000;

    signal buf_done : std_logic := '0';
    signal buf_idle : std_logic := '0';     
    signal buf_idle_0 : std_logic := '0';     
    
    signal width_got : std_logic;
 --------------------------------------------
 
 --------signal values of last clock cycle -------------------
        signal sig_buf_add_obs_0 : integer range 0 to 5760;
        signal sig_buf_add_0: integer range 0 to 18000;
    
    function get_buf_add_one(buf_address: integer range 0 to 18000;three_width : integer range 0 to 18000) return integer is
                             variable add_one : integer range 0 to 18000;
    begin
        if(buf_address < (three_width - 1)) then
            add_one := buf_address + 1;
        else
            add_one := 0;
        end if;
        return add_one;
    end function;
    
    function get_buf_add_two(buf_address: integer range 0 to 18000;three_width : integer range 0 to 18000) return integer is
                             variable add_two : integer range 0 to 18000;
    begin
        if(buf_address < (three_width - 2)) then
            add_two := buf_address + 2;
        elsif(buf_address < (three_width - 1)) then
            add_two := 0;
        else
            add_two := 1;
        end if;
        return add_two;
    end function;
    
    function get_buf_add_three(buf_address: integer range 0 to 18000;three_width : integer range 0 to 18000) return integer is
                             variable add_three : integer range 0 to 18000;
    begin
        if(buf_address < (three_width - 3)) then
            add_three := buf_address + 3;
        elsif(buf_address < (three_width - 2)) then
            add_three := 0;
        elsif(buf_address < (three_width - 1)) then
            add_three := 1;
        else
            add_three := 2;
        end if;
        return add_three;
    end function;
    
    function get_buf_add_four(buf_address: integer range 0 to 18000;
                                three_width : integer range 0 to 18000) 
                                return integer is variable add_four : integer range 0 to 18000;
    begin
        if(buf_address < (three_width - 4)) then
            add_four := buf_address + 4;
        elsif(buf_address < (three_width - 3)) then
            add_four := 0;
        elsif(buf_address < (three_width - 2)) then
            add_four := 1;
        elsif(buf_address < (three_width - 1)) then
            add_four := 2;
        else
            add_four := 3;
        end if;
        return add_four;
    end function;
  -----------------------------------------------------------------------------------------  
    function get_buf_add_obs(buf_address: integer range 0 to 18000;three_width : integer range 0 to 18000;
                              two_width : integer range 0 to 18000;one_width : integer range 0 to 18000
                               ) return integer is variable address_obs : integer range 0 to 5760;
    begin 
        if((buf_address < one_width) and (buf_address >= 0)) then
            address_obs := buf_address;
        elsif((buf_address < two_width) and (buf_address >= one_width)) then
            address_obs := (buf_address - one_width);
        else
            address_obs := (buf_address - two_width);
        end if;
        return address_obs;
    end function;
----------------------------------------------------------------------------------
    function get_next_filter_position(position: integer range 0 to 5760;
                                        buf_address : integer range 0 to 18000;
                                        address_obs : integer range 0 to 5760;
                                        address_obs_0 : integer range 0 to 5760;
                                        one_width : integer range 0 to 18000;
                                        two_width : integer range 0 to 18000
                               ) return integer is variable nposition : integer range 0 to 5760;
    begin
        if((position < (one_width - 3)) and (address_obs_0 > (one_width - 5)) and (address_obs < 5)) then
            nposition := position + 4;
        elsif((position < (one_width - 3)) and (position >= (address_obs - 3))) then
            nposition := position + 3;
        elsif((position < (one_width - 3)) and (position < (address_obs - 3))) then
            nposition := position + 4;
        else
            nposition := 0;
        end if;   
        
        return nposition;
    end function;
    
begin

    filter_position <=  std_logic_vector(to_unsigned(sig_filter_position,16));
    
    Block_Ram: input_buf_top_wrapper
    port map(
        clk => clk,
        din_a => din_a,
        din_b => din_b,
        dout_a_1 => ram_data_out_a_1,
        dout_a_2 => ram_data_out_a_2,
        dout_a_3 => ram_data_out_a_3,
        dout_b_1 => ram_data_out_b_1,
        dout_b_2 => ram_data_out_b_2,
        dout_b_3 => ram_data_out_b_3,
        rd_add_a => rd_add_a,
        rd_add_b => rd_add_b,
        wr_add_a => wr_add_a,
        wr_add_b => wr_add_b,
        
        wr_en_a_1 => wr_en_a_1,
        wr_en_a_2 => wr_en_a_2,
        wr_en_a_3 => wr_en_a_3,
        wr_en_b_1 => wr_en_b_1,
        wr_en_b_2 => wr_en_b_2,
        wr_en_b_3 => wr_en_b_3
    );
    
    RAM_IN_C: component mem_ctrl 
    Port Map ( 
    clk => clk,
    rst => rst,
    
    width => width,
    one_width_out => one_width,
    two_width_out => two_width,
    three_width_out => three_width,
    
    data_in => mem_ctrl_data_in,
    keep_in => mem_ctrl_keep_in,
    buf_add_1 => buf_add_1,
    buf_add_2 => buf_add_2,
    buf_add_3 => buf_add_3,
    buf_add_4 => buf_add_4,
    wr_en => wr_en,
    
    din_a => din_a,
    din_b => din_b,
    wr_add_a => wr_add_a,
    wr_add_b => wr_add_b,
    wr_en_a_1 => wr_en_a_1,
    wr_en_a_2 => wr_en_a_2,
    wr_en_a_3 => wr_en_a_3,
    wr_en_b_1 => wr_en_b_1,
    wr_en_b_2 => wr_en_b_2,
    wr_en_b_3 => wr_en_b_3
    );
    
    RAM_OUT_C: mem_out_ctrl 
    Port Map(
    clk => clk,
    rst => rst,
    
    filter_position =>filter_position,
    
    rgb_first => rgb_first,
    rd_en => rd_en,
    
    r_filter_en => sig_r_filter_en,
    g_filter_en => sig_g_filter_en,
    b_filter_en => sig_b_filter_en,
    e_filter_en => sig_extra_filter_en,
    
    r_filter_en_out => r_filter_en,
    g_filter_en_out => g_filter_en,
    b_filter_en_out => b_filter_en,
    e_filter_en_out => extra_filter_en,
  
    rd_add_a => rd_add_a,
    rd_add_b => rd_add_b,
    
    rd_a_1 => ram_data_out_a_1,
    rd_a_2 => ram_data_out_a_2,
    rd_a_3 => ram_data_out_a_3,
    rd_b_1 => ram_data_out_b_1,
    rd_b_2 => ram_data_out_b_2,
    rd_b_3 => ram_data_out_b_3,
    
    data_r_out0 => data_r_out0,
    data_r_out1 => data_r_out1,
    data_r_out2 => data_r_out2,
    data_r_out3 => data_r_out3,
    data_r_out4 => data_r_out4,
    data_r_out5 => data_r_out5,
    data_r_out6 => data_r_out6,
    data_r_out7 => data_r_out7,
    data_r_out8 => data_r_out8,
    
    data_g_out0 => data_g_out0,
    data_g_out1 => data_g_out1,
    data_g_out2 => data_g_out2,
    data_g_out3 => data_g_out3,
    data_g_out4 => data_g_out4,
    data_g_out5 => data_g_out5,
    data_g_out6 => data_g_out6,
    data_g_out7 => data_g_out7,
    data_g_out8 => data_g_out8,
    
    data_b_out0 => data_b_out0,
    data_b_out1 => data_b_out1,
    data_b_out2 => data_b_out2,
    data_b_out3 => data_b_out3,
    data_b_out4 => data_b_out4,
    data_b_out5 => data_b_out5,
    data_b_out6 => data_b_out6,
    data_b_out7 => data_b_out7,
    data_b_out8 => data_b_out8,
    
    data_e_out0 => data_e_out0,
    data_e_out1 => data_e_out1,
    data_e_out2 => data_e_out2,
    data_e_out3 => data_e_out3,
    data_e_out4 => data_e_out4,
    data_e_out5 => data_e_out5,
    data_e_out6 => data_e_out6,
    data_e_out7 => data_e_out7,
    data_e_out8 => data_e_out8
    );
  ---------------------------------------------------  
  one_width_out <= one_width;
  -------------------------
    filter_start <= sig_filter_start;
    
        process(clk)
        begin
        if (rising_edge(clk)) then
            width <= (sig_wh(1) & sig_wh(0)); --"0000000000001000"; --
        end if;
        end process;
    
         process(clk)
         begin
         if (rising_edge(clk)) then
             if ((rst = '0') or (buf_done = '1')) then
                 width_got <= '0';
             elsif((sig_buf_add >= 0) and (sig_buf_add <4)) then
                 width_got <= '1';
             end if;
         end if;
         end process;
    
    process(clk)
    begin
        if (rising_edge(clk)) then
            if ((rst = '0') or (buf_done = '1')) then
                sig_new_line <= '0';
            elsif((sig_buf_add_obs_0 > (one_width - 5)) and (sig_buf_add_obs < 5)) then
                sig_new_line <= '1';
            elsif(sig_filter_position = 0) then
                sig_new_line <= '0';
            end if;
        end if;
    end process;
          
    
     process(clk)
     begin
         if (rising_edge(clk)) then
             if ((rst = '0') or (buf_done = '1')) then
                 sig_filter_position <= 0;
                 sig_r_filter_en  <= '0';
                 sig_g_filter_en  <= '0';
                 sig_b_filter_en  <= '0';
                 sig_extra_filter_en  <= '0';
                 filter_next_position <= 0;
             elsif((width_got = '1') and (sig_filter_position = 0) and (sig_buf_add_obs_0 >= 8) and ((sig_filter_start = '1') or (sig_buf_add_0 > two_width))) then
                sig_filter_position <= 6;            
                filter_next_position <= get_next_filter_position(6, sig_buf_add, sig_buf_add_obs, sig_buf_add_obs_0, one_width, two_width);
                rd_en <= '1';
                if(sig_buf_add_obs > 8) then --(keep_in /= "0000") then
                    sig_r_filter_en  <= '1';
                    sig_g_filter_en  <= '1';
                    sig_b_filter_en  <= '1';
                    if(sig_buf_add_obs > 9) then --((keep_in /= "0001") and (keep_in /= "0010") and (keep_in /= "0100") and (keep_in /= "1000")) then
                        sig_extra_filter_en <= '1';
                    else 
                        sig_extra_filter_en <= '0';
                    end if;
                else
                    sig_r_filter_en  <= '0';
                    sig_g_filter_en  <= '0';
                    sig_b_filter_en  <= '0';
                    sig_extra_filter_en <= '0';
                end if;
             elsif((sig_filter_start = '1') and (sig_buf_add_obs_0 > (sig_filter_position + 2)) and (sig_filter_position /= 0)) then
                sig_filter_position <= filter_next_position;
                filter_next_position <= get_next_filter_position(filter_next_position, sig_buf_add, sig_buf_add_obs, sig_buf_add_obs_0, one_width, two_width);
                rd_en <= '1';
                sig_r_filter_en  <= '1';
                sig_g_filter_en  <= '1';
                sig_b_filter_en  <= '1';
                if(((filter_next_position < (one_width - 3)) and (filter_next_position < (sig_buf_add_obs - 3))) or 
                   ((filter_next_position < (one_width - 3)) and (sig_buf_add_obs_0 > (one_width - 5)) and (sig_buf_add_obs < 5))) then--(filter_next_position = (sig_filter_position + 4)) then --(sig_buf_add_obs > (filter_next_position + 3)) then
                    sig_extra_filter_en <= '1';
                else
                    sig_extra_filter_en <= '0';
                end if;
             elsif((sig_filter_start = '1') and (sig_new_line = '1') and (sig_filter_position < one_width) and (sig_filter_position /= 0)) then --(((sig_r_filter_en = '1') or (sig_g_filter_en = '1') or (sig_b_filter_en = '1')) and (width_got = '1') and (sig_filter_position /= 0)) then --(width_got = '1') then--((sig_filter_start = '1') and ((sig_buf_add_obs > (sig_filter_position + 2)) or (sig_new_line = '1'))) then --
                 sig_filter_position <= filter_next_position; 
                 filter_next_position <= get_next_filter_position(filter_next_position, sig_buf_add, sig_buf_add_obs, sig_buf_add_obs_0, one_width, two_width);
                 rd_en <= '1';
                 
                 if(filter_next_position /= 0) then                
                     sig_b_filter_en <= '1';
                     if(filter_next_position < (one_width - 1)) then
                        sig_g_filter_en <= '1';
                     else
                        sig_g_filter_en <= '0';
                     end if;
                     
                     if(filter_next_position < (one_width - 2)) then
                        sig_r_filter_en  <= '1';
                     else
                        sig_r_filter_en  <= '0';
                     end if;
                     
                     if(filter_next_position < (one_width - 3)) then
                        sig_extra_filter_en  <= '1';
                     else
                        sig_extra_filter_en  <= '0';
                     end if;
                 else
                       sig_r_filter_en  <= '0';
                       sig_g_filter_en  <= '0';
                       sig_b_filter_en  <= '0';
                       sig_extra_filter_en  <= '0';
                 end if;
             else
                sig_r_filter_en  <= '0';
                sig_g_filter_en  <= '0';
                sig_b_filter_en  <= '0';
                sig_extra_filter_en  <= '0';
                rd_en <= '0';
             end if;
         end if;
     end process;
     
     process(clk)
     begin
         if (rising_edge(clk)) then
             if ((rst = '0') or (buf_done = '1')) then
                rgb_first <= "00";
             elsif(sig_filter_position = 0) then
                rgb_first <= "00";
             elsif ((sig_extra_filter_en = '1') and (width_got = '1')) then
               if(rgb_first = "00") then
                    rgb_first <= "01";
               elsif(rgb_first = "01") then
                    rgb_first <= "10";
               else --if(rgb_first = "01") then
                    rgb_first <= "00";
                end if;
             end if;
         end if;
     end process;
     
     process(clk) 
     begin
        if(rising_edge(clk)) then
            if((trans_start = '1') and (trans_en = '1') and (sig_buf_add > two_width) and (sig_buf_add < 17280) and (sig_filter_start = '0')) then --((trans_start = '1') and (trans_en = '1') and (sig_buf_add > two_width + 8) and (sig_buf_add < 17280) and (sig_filter_start = '0')) then
                sig_filter_start <= '1';
            elsif((trans_start = '0') and (sig_filter_start = '1') and (filter_start_expire >= 10000)) then
                sig_filter_start <= '0';
            elsif((trans_start = '0') and (sig_filter_start = '1') and (sig_filter_position = 0)) then
                sig_filter_start <= '0';
            end if;
        end if;
     end process;
     
    process(clk)
    begin
    if (rising_edge(clk)) then
        if ((rst = '0') or (buf_done = '1')) then
            filter_start_expire <= 0;
        elsif(filter_start_expire >= 10000) then
            filter_start_expire <= filter_start_expire;
        elsif((trans_start = '0') and (sig_filter_start = '1')) then
            filter_start_expire <= filter_start_expire + 1;
        else
            filter_start_expire <= 0;
        end if;
    end if;
    
    end process;
--------------------------------------------------------------------------------------------------     

    process(clk)
    begin
        if (rising_edge(clk)) then
            if ((rst = '0') or (buf_done = '1')) then
                sig_buf_add_obs_0 <= 0;
                sig_buf_add_0 <= 0;
            else
                sig_buf_add_obs_0 <= sig_buf_add_obs;
                sig_buf_add_0 <= sig_buf_add_obs;
            end if;
        end if;
    end process;

    process(clk)---------------1--------------------------
    begin
      if (rising_edge(clk)) then
          if ((rst = '0') or (buf_done = '1')) then
              sig_buf_add <= 17285;--0;
              sig_wh(1) <= "00000111";
              sig_wh(0) <= "10000001";
              mem_ctrl_keep_in <= (others => '0');
              mem_ctrl_data_in <= (others => '0');
              wr_en <= '0';
              
              sig_buf_add_one <= 17286;
              sig_buf_add_two <= 17287;
              sig_buf_add_three <= 17288;
              sig_buf_add_four <= 0;
              sig_buf_add_obs <= 5759;
              
          elsif (trans_start = '1' and trans_en = '1') then
              case (keep_in) is
              when "0000" =>
                  mem_ctrl_keep_in <= "0000";
              when "0001" =>
                  sig_buf_add <= sig_buf_add_one;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_one,three_width);
                  sig_buf_add_two <= get_buf_add_two(sig_buf_add_one,three_width);
                  sig_buf_add_three <= get_buf_add_three(sig_buf_add_one,three_width);
                  sig_buf_add_four <= get_buf_add_four(sig_buf_add_one,three_width);
                  sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_one,three_width,two_width,one_width);
                                    
                  mem_ctrl_data_in (7 downto 0) <= data_in (7 downto 0);
                  mem_ctrl_keep_in <= "0001";
              when "0010" =>
                  sig_buf_add <= sig_buf_add_one;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_one,three_width);
                  sig_buf_add_two <= get_buf_add_two(sig_buf_add_one,three_width);
                  sig_buf_add_three <= get_buf_add_three(sig_buf_add_one,three_width);
                  sig_buf_add_four <= get_buf_add_four(sig_buf_add_one,three_width);
                  sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_one,three_width,two_width,one_width);                  
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (15 downto 8);
                  mem_ctrl_keep_in <= "0001";
              when "0011" =>
                  sig_buf_add <= sig_buf_add_two;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_two,three_width);
                  sig_buf_add_two <= get_buf_add_two(sig_buf_add_two,three_width);
                  sig_buf_add_three <= get_buf_add_three(sig_buf_add_two,three_width);
                  sig_buf_add_four <= get_buf_add_four(sig_buf_add_two,three_width);
                  sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_two,three_width,two_width,one_width);
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (7 downto 0);
                  mem_ctrl_data_in (15 downto 8) <= data_in (15 downto 8);
                  mem_ctrl_keep_in <= "0011";
              when "0100" =>
                  sig_buf_add <= sig_buf_add_one;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_one,three_width);
                  sig_buf_add_two <= get_buf_add_two(sig_buf_add_one,three_width);
                  sig_buf_add_three <= get_buf_add_three(sig_buf_add_one,three_width);
                  sig_buf_add_four <= get_buf_add_four(sig_buf_add_one,three_width);
                  sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_one,three_width,two_width,one_width);
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (23 downto 16);
                  mem_ctrl_keep_in <= "0001";
              when "0101" =>
                  sig_buf_add <= sig_buf_add_two;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_two,three_width);
                  sig_buf_add_two <= get_buf_add_two(sig_buf_add_two,three_width);
                  sig_buf_add_three <= get_buf_add_three(sig_buf_add_two,three_width);
                  sig_buf_add_four <= get_buf_add_four(sig_buf_add_two,three_width);
                  sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_two,three_width,two_width,one_width);
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (7 downto 0);
                mem_ctrl_data_in (15 downto 8) <= data_in (23 downto 16);
                mem_ctrl_keep_in <= "0011";
              when "0110" =>
                  sig_buf_add <= sig_buf_add_two;
                    sig_buf_add_one <= get_buf_add_one(sig_buf_add_two,three_width);
                    sig_buf_add_two <= get_buf_add_two(sig_buf_add_two,three_width);
                    sig_buf_add_three <= get_buf_add_three(sig_buf_add_two,three_width);
                    sig_buf_add_four <= get_buf_add_four(sig_buf_add_two,three_width);
                    sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_two,three_width,two_width,one_width);
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (15 downto 8);
                  mem_ctrl_data_in (15 downto 8) <= data_in (23 downto 16);
                  mem_ctrl_keep_in <= "0011";
              when "0111" =>
                  sig_buf_add <= sig_buf_add_three;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_three,three_width);
                  sig_buf_add_two <= get_buf_add_two(sig_buf_add_three,three_width);
                  sig_buf_add_three <= get_buf_add_three(sig_buf_add_three,three_width);
                  sig_buf_add_four <= get_buf_add_four(sig_buf_add_three,three_width);
                  sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_three,three_width,two_width,one_width);
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (7 downto 0);
                mem_ctrl_data_in (15 downto 8) <= data_in (15 downto 8);
                mem_ctrl_data_in (23 downto 16) <= data_in (23 downto 16);
                mem_ctrl_keep_in <= "0111";
              when "1000" =>
                  sig_buf_add <= sig_buf_add_one;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_one,three_width);
                  sig_buf_add_two <= get_buf_add_two(sig_buf_add_one,three_width);
                  sig_buf_add_three <= get_buf_add_three(sig_buf_add_one,three_width);
                  sig_buf_add_four <= get_buf_add_four(sig_buf_add_one,three_width);
                  sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_one,three_width,two_width,one_width);
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (31 downto 24);
                  mem_ctrl_keep_in <= "0001";
              when "1001" =>
                  sig_buf_add <= sig_buf_add_two;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_two,three_width);
                    sig_buf_add_two <= get_buf_add_two(sig_buf_add_two,three_width);
                    sig_buf_add_three <= get_buf_add_three(sig_buf_add_two,three_width);
                    sig_buf_add_four <= get_buf_add_four(sig_buf_add_two,three_width);
                    sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_two,three_width,two_width,one_width);
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (7 downto 0);
                  mem_ctrl_data_in (15 downto 8) <= data_in (31 downto 24);
                    mem_ctrl_keep_in <= "0011";
              when "1010" =>
                  sig_buf_add <= sig_buf_add_two;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_two,three_width);
                    sig_buf_add_two <= get_buf_add_two(sig_buf_add_two,three_width);
                    sig_buf_add_three <= get_buf_add_three(sig_buf_add_two,three_width);
                    sig_buf_add_four <= get_buf_add_four(sig_buf_add_two,three_width);
                    sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_two,three_width,two_width,one_width);
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (15 downto 8);
                  mem_ctrl_data_in (15 downto 8) <= data_in (31 downto 24);
                  mem_ctrl_keep_in <= "0011";
              when "1011" =>
                  sig_buf_add <= sig_buf_add_three;                 
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_three,three_width);
                    sig_buf_add_two <= get_buf_add_two(sig_buf_add_three,three_width);
                    sig_buf_add_three <= get_buf_add_three(sig_buf_add_three,three_width);
                    sig_buf_add_four <= get_buf_add_four(sig_buf_add_three,three_width);
                    sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_three,three_width,two_width,one_width);
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (7 downto 0);
                mem_ctrl_data_in (15 downto 8) <= data_in (15 downto 8);
                mem_ctrl_data_in (23 downto 16) <= data_in (31 downto 24);                
                mem_ctrl_keep_in <= "0111";
              when "1100" =>
                  sig_buf_add <= sig_buf_add_two;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_two,three_width);
                    sig_buf_add_two <= get_buf_add_two(sig_buf_add_two,three_width);
                    sig_buf_add_three <= get_buf_add_three(sig_buf_add_two,three_width);
                    sig_buf_add_four <= get_buf_add_four(sig_buf_add_two,three_width);
                    sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_two,three_width,two_width,one_width);
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (23 downto 16);
                  mem_ctrl_data_in (15 downto 8) <= data_in (31 downto 24);             
                  mem_ctrl_keep_in <= "0011";
              when "1101" =>
                  sig_buf_add <= sig_buf_add_three;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_three,three_width);
                    sig_buf_add_two <= get_buf_add_two(sig_buf_add_three,three_width);
                    sig_buf_add_three <= get_buf_add_three(sig_buf_add_three,three_width);
                    sig_buf_add_four <= get_buf_add_four(sig_buf_add_three,three_width);
                    sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_three,three_width,two_width,one_width);
                  
                  mem_ctrl_data_in (7 downto 0) <= data_in (7 downto 0);
                  mem_ctrl_data_in (15 downto 8) <= data_in (15 downto 8);
                  mem_ctrl_data_in (23 downto 16) <= data_in (31 downto 24);                
                  mem_ctrl_keep_in <= "0111";
              when "1110" =>
                  sig_buf_add <= sig_buf_add_three;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_three,three_width);
                    sig_buf_add_two <= get_buf_add_two(sig_buf_add_three,three_width);
                    sig_buf_add_three <= get_buf_add_three(sig_buf_add_three,three_width);
                    sig_buf_add_four <= get_buf_add_four(sig_buf_add_three,three_width);
                    sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_three,three_width,two_width,one_width);
                  
                   mem_ctrl_data_in (7 downto 0) <= data_in (15 downto 8);
                   mem_ctrl_data_in (15 downto 8) <= data_in (23 downto 16);
                   mem_ctrl_data_in (23 downto 16) <= data_in (31 downto 24);                
                   mem_ctrl_keep_in <= "0111";
              when "1111" =>
                  sig_buf_add <= sig_buf_add_four;
                  sig_buf_add_one <= get_buf_add_one(sig_buf_add_four,three_width);
                    sig_buf_add_two <= get_buf_add_two(sig_buf_add_four,three_width);
                    sig_buf_add_three <= get_buf_add_three(sig_buf_add_four,three_width);
                    sig_buf_add_four <= get_buf_add_four(sig_buf_add_four,three_width);
                    sig_buf_add_obs <= get_buf_add_obs(sig_buf_add_four,three_width,two_width,one_width);
                  
                   mem_ctrl_data_in (7 downto 0) <= data_in (7 downto 0);
                   mem_ctrl_data_in (15 downto 8) <= data_in (15 downto 8);
                   mem_ctrl_data_in (23 downto 16) <= data_in (23 downto 16);             
                   mem_ctrl_data_in (31 downto 24) <= data_in (31 downto 24);                                   
                   mem_ctrl_keep_in <= "1111";
              when others =>
                  mem_ctrl_keep_in <= "0000";
              end case;
                buf_add_1 <= std_logic_vector(to_unsigned(sig_buf_add,16));
                buf_add_2 <= std_logic_vector(to_unsigned(sig_buf_add_one,16));
                buf_add_3 <= std_logic_vector(to_unsigned(sig_buf_add_two,16));
                buf_add_4 <= std_logic_vector(to_unsigned(sig_buf_add_three,16));
                
                wr_en <= '1';
                
                if((buf_add_1 = B"0100_0011_1000_0101") and (mem_ctrl_keep_in(0) = '1') and (mem_ctrl_keep_in(1) = '1') and (buf_add_2 = B"0100_0011_1000_0110")) then
                    sig_wh(0) <= mem_ctrl_data_in (7 downto 0);
                    sig_wh(1) <= mem_ctrl_data_in (15 downto 8);
                elsif(buf_add_1 = B"0100_0011_1000_0101") and (mem_ctrl_keep_in(0) = '1') then                     
                    sig_wh(0) <= mem_ctrl_data_in (7 downto 0);
                elsif((buf_add_1 = B"0100_0011_1000_0110") and (mem_ctrl_keep_in(0) = '1')) then
                    sig_wh(0) <= mem_ctrl_data_in (7 downto 0);
                end if;
          else
             wr_en <= '0';
             mem_ctrl_keep_in <= "0000";
          end if;
      end if;
    end process;
    
    -------------------------------------------------
    process(clk)
    begin
        if (rising_edge(clk)) then
            if ((sig_filter_start = '0') and (sig_r_filter_en = '0') and (sig_g_filter_en = '0') and (sig_b_filter_en = '0') 
                and (sig_extra_filter_en = '0') and (trans_start = '0') and (trans_en = '0')) then
                buf_idle <= '1';
            else
                buf_idle <= '0';         
            end if;
            buf_idle_0 <= buf_idle;
        end if;
    end process;

    process(clk)
    begin
        if(rising_edge(clk)) then          
            if ((buf_idle_0 = '0') and (buf_idle = '1')) then
                buf_done <= '1';
            else --if(buf_done = '1') then
                buf_done <= '0';
            end if;
        end if;
    end process;
     
end Behavioral;
