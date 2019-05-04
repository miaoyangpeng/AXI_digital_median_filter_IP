----------------------------------------------------------------------------------
-- Author: Yangpeng Miao
-- Design Name: Digital Image Filter TOP file
-- Module Name: Noise_Filter_Top - Behavioral
-- Description: 
-- Top file of this system
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

entity Noise_Filter_Top is
  Port (
  clk	: in std_logic;
  rst : in std_logic;
  
    -- Ports of Axi Slave Bus Interface S00_AXIS --get
  s00_axis_tready   : out std_logic;
  s00_axis_tdata    : in std_logic_vector(31 downto 0);
  s00_axis_tkeep    : in std_logic_vector(3 downto 0);
  s00_axis_tlast    : in std_logic;
  s00_axis_tvalid   : in std_logic;

  -- Ports of Axi Master Bus Interface M00_AXIS --send
  m00_axis_tvalid   : out std_logic;
  m00_axis_tdata    : out std_logic_vector(31 downto 0);
  m00_axis_tkeep    : out std_logic_vector(3 downto 0);
  m00_axis_tlast    : out std_logic;
  m00_axis_tready   : in std_logic
   );
end Noise_Filter_Top;

architecture Behavioral of Noise_Filter_Top is

component Filter_receive is
Port ( 
    clk	: in std_logic;
    rst : in std_logic;
    
    data_out : out std_logic_vector(31 downto 0);
    keep_out : out std_logic_vector(3 downto 0);
    
    trans_start: out std_logic := '0';   --set as '0' 1 clock after the last data sent
    trans_en : out std_logic := '0';
    
    buf_full : in std_logic;
    
    s00_axis_tready   : out std_logic;
    s00_axis_tdata    : in std_logic_vector(31 downto 0);
    s00_axis_tkeep    : in std_logic_vector(3 downto 0);
    s00_axis_tlast    : in std_logic;
    s00_axis_tvalid   : in std_logic
      );
end component Filter_receive;

component buf_ctr is
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
end component buf_ctr;

component Filter_SN is
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
end component Filter_SN;

component buf_send is
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
    m00_axis_tlast : in std_logic;   
    get_done : in std_logic;   
    one_width_get : in integer range 0 to 18000;
    fifo_rd_en : out STD_LOGIC;  
    
    data_out : out STD_LOGIC_VECTOR (31 downto 0);
    data_keep : out STD_LOGIC_VECTOR (3 downto 0);
    buf_pre_empty : out std_logic;
    buf_empty : out STD_LOGIC;
    buf_full : out std_logic
    );
end component buf_send;

component Filter_send is
Port ( 
    
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    
    data_in : in STD_LOGIC_VECTOR (31 downto 0);
    data_keep : in STD_LOGIC_VECTOR (3 downto 0);
    buf_pre_empty : in std_logic;
    buf_empty : in STD_LOGIC;
    
    s00_axis_tlast : in std_logic;
    read_en : out STD_LOGIC;
    get_done_out : out std_logic;
    fifo_rd_en : in STD_LOGIC;
    
    m00_axis_tvalid   : out std_logic;
    m00_axis_tdata    : out std_logic_vector(31 downto 0);
    m00_axis_tkeep    : out std_logic_vector(3 downto 0);
    m00_axis_tlast    : out std_logic;
    m00_axis_tready   : in std_logic
    );
end component Filter_send;

--------------------
    signal in_data : std_logic_vector(31 downto 0);
    signal in_keep : std_logic_vector(3 downto 0);
    
    signal trans_start: std_logic := '0';   --set as '0' 1 clock after the last data sent
    signal trans_en : std_logic := '0';

    signal data_r_out0: std_logic_vector(7 downto 0);
    signal data_r_out1: std_logic_vector(7 downto 0);
    signal data_r_out2: std_logic_vector(7 downto 0);
    signal data_r_out3: std_logic_vector(7 downto 0);
    signal data_r_out4: std_logic_vector(7 downto 0);
    signal data_r_out5: std_logic_vector(7 downto 0);
    signal data_r_out6: std_logic_vector(7 downto 0);
    signal data_r_out7: std_logic_vector(7 downto 0);
    signal data_r_out8: std_logic_vector(7 downto 0);
    
    signal data_g_out0: std_logic_vector(7 downto 0);
    signal data_g_out1: std_logic_vector(7 downto 0);
    signal data_g_out2: std_logic_vector(7 downto 0);
    signal data_g_out3: std_logic_vector(7 downto 0);
    signal data_g_out4: std_logic_vector(7 downto 0);
    signal data_g_out5: std_logic_vector(7 downto 0);
    signal data_g_out6: std_logic_vector(7 downto 0);
    signal data_g_out7: std_logic_vector(7 downto 0);
    signal data_g_out8: std_logic_vector(7 downto 0);
            
    signal data_b_out0: std_logic_vector(7 downto 0);
    signal data_b_out1: std_logic_vector(7 downto 0);
    signal data_b_out2: std_logic_vector(7 downto 0);
    signal data_b_out3: std_logic_vector(7 downto 0);
    signal data_b_out4: std_logic_vector(7 downto 0);
    signal data_b_out5: std_logic_vector(7 downto 0);
    signal data_b_out6: std_logic_vector(7 downto 0);
    signal data_b_out7: std_logic_vector(7 downto 0);
    signal data_b_out8: std_logic_vector(7 downto 0);
    
    signal data_e_out0: std_logic_vector(7 downto 0);
    signal data_e_out1: std_logic_vector(7 downto 0);
    signal data_e_out2: std_logic_vector(7 downto 0);
    signal data_e_out3: std_logic_vector(7 downto 0);
    signal data_e_out4: std_logic_vector(7 downto 0);
    signal data_e_out5: std_logic_vector(7 downto 0);
    signal data_e_out6: std_logic_vector(7 downto 0);
    signal data_e_out7: std_logic_vector(7 downto 0);
    signal data_e_out8: std_logic_vector(7 downto 0);
      
    signal extra_filter_en: std_logic;
    signal filter_start : std_logic;
    signal r_filter_en : std_logic;
    signal g_filter_en : std_logic;
    signal b_filter_en : std_logic;
     
    signal data_r : STD_LOGIC_VECTOR (7 downto 0);
    signal data_g : STD_LOGIC_VECTOR (7 downto 0);
    signal data_b : STD_LOGIC_VECTOR (7 downto 0);
    signal data_e : STD_LOGIC_VECTOR (7 downto 0);
    
    signal data_r_keep : STD_LOGIC;
    signal data_g_keep : STD_LOGIC;
    signal data_b_keep : STD_LOGIC;
    signal data_e_keep : STD_LOGIC;
       
    signal read_en : STD_LOGIC;

    signal out_data : STD_LOGIC_VECTOR (31 downto 0);
    signal out_keep : STD_LOGIC_VECTOR (3 downto 0);
    signal buf_pre_empty : std_logic;
    signal buf_empty : STD_LOGIC;
    signal buf_full : std_logic;
    
    signal sig_m00_axis_tlast : std_logic;
    
    signal one_width : integer range 0 to 18000;
    signal get_done : std_logic;
    signal fifo_rd_en : STD_LOGIC;
begin

m00_axis_tlast <= sig_m00_axis_tlast;

AXI_REC: Filter_receive 
Port map ( 
    clk	=> clk,
    rst => rst, 
    
    data_out => in_data,
    keep_out => in_keep,
    
    trans_start => trans_start,
    trans_en => trans_en,
    
    buf_full => buf_full,
    
    s00_axis_tready => s00_axis_tready,
    s00_axis_tdata => s00_axis_tdata,
    s00_axis_tkeep => s00_axis_tkeep,
    s00_axis_tlast => s00_axis_tlast,
    s00_axis_tvalid => s00_axis_tvalid
);

F_BUF: buf_ctr 
Port map ( 

     clk => clk,
     rst => rst,
     
     data_in => in_data,
     keep_in => in_keep,
     
     trans_start  => trans_start,
     trans_en  => trans_en,          
     
     data_r_out0  => data_r_out0, data_r_out1  => data_r_out1, data_r_out2  => data_r_out2, data_r_out3  => data_r_out3,
     data_r_out4  => data_r_out4, data_r_out5  => data_r_out5, data_r_out6  => data_r_out6, data_r_out7  => data_r_out7, data_r_out8  => data_r_out8,
     
     data_g_out0 => data_g_out0, data_g_out1 => data_g_out1, data_g_out2 => data_g_out2, data_g_out3 => data_g_out3,
     data_g_out4 => data_g_out4, data_g_out5 => data_g_out5, data_g_out6 => data_g_out6, data_g_out7 => data_g_out7, data_g_out8 => data_g_out8,
               
     data_b_out0 => data_b_out0, data_b_out1 => data_b_out1, data_b_out2 => data_b_out2, data_b_out3 => data_b_out3,
     data_b_out4 => data_b_out4, data_b_out5 => data_b_out5, data_b_out6 => data_b_out6, data_b_out7 => data_b_out7, data_b_out8 => data_b_out8,
     
     data_e_out0 => data_e_out0, data_e_out1 => data_e_out1, data_e_out2 => data_e_out2, data_e_out3 => data_e_out3,
     data_e_out4 => data_e_out4, data_e_out5 => data_e_out5, data_e_out6 => data_e_out6, data_e_out7 => data_e_out7, data_e_out8 => data_e_out8,
     
     extra_filter_en => extra_filter_en,
     filter_start => filter_start,
     r_filter_en => r_filter_en,
     g_filter_en => g_filter_en,
     b_filter_en => b_filter_en,
    
    one_width_out => one_width
);

F_SN_R: Filter_SN
Port map( 
    clk => clk,    
    data_out => data_r,
    
    data_0 => data_r_out0, data_1 => data_r_out1, data_2 => data_r_out2, data_3 => data_r_out3, 
    data_4 => data_r_out4, data_5 => data_r_out5, data_6 => data_r_out6, data_7 => data_r_out7, data_8 => data_r_out8, 
        
    filter_in_keep => r_filter_en,
    filter_out_keep => data_r_keep
);

F_SN_G: Filter_SN
Port map( 
    clk => clk,    
    data_out => data_g,
    
    data_0 => data_g_out0, data_1 => data_g_out1, data_2 => data_g_out2, data_3 => data_g_out3, 
    data_4 => data_g_out4, data_5 => data_g_out5, data_6 => data_g_out6, data_7 => data_g_out7, data_8 => data_g_out8, 
        
    filter_in_keep => g_filter_en,
    filter_out_keep => data_g_keep
);

F_SN_B: Filter_SN
Port map( 
    clk => clk,    
    data_out => data_b,
    
    data_0 => data_b_out0, data_1 => data_b_out1, data_2 => data_b_out2, data_3 => data_b_out3, 
    data_4 => data_b_out4, data_5 => data_b_out5, data_6 => data_b_out6, data_7 => data_b_out7, data_8 => data_b_out8, 
        
    filter_in_keep => b_filter_en,
    filter_out_keep => data_b_keep
);

F_SN_E: Filter_SN
Port map( 
    clk => clk,    
    data_out => data_e,
    
    data_0 => data_e_out0, data_1 => data_e_out1, data_2 => data_e_out2, data_3 => data_e_out3, 
    data_4 => data_e_out4, data_5 => data_e_out5, data_6 => data_e_out6, data_7 => data_e_out7, data_8 => data_e_out8, 
        
    filter_in_keep => extra_filter_en,
    filter_out_keep => data_e_keep
);

F_SEND_BUF: buf_send
Port map (
    clk => clk,
    rst => rst,
    
    data_r => data_r,
    data_g => data_g,
    data_b => data_b,
    data_e => data_e,
    
    data_r_keep => data_r_keep,
    data_g_keep => data_g_keep,
    data_b_keep => data_b_keep,
    data_e_keep => data_e_keep,
    
    read_en => read_en,     
    m00_axis_tlast => sig_m00_axis_tlast,   
    get_done => get_done,  
    one_width_get => one_width,
    fifo_rd_en => fifo_rd_en,
    
    data_out => out_data,
    data_keep => out_keep,
    buf_pre_empty => buf_pre_empty,
    buf_empty => buf_empty,
    buf_full => buf_full
);

F_SEND: Filter_send 
Port map 
(  
    clk => clk,
    rst => rst,
    
    data_in => out_data,
    data_keep => out_keep,
    buf_pre_empty => buf_pre_empty,
    buf_empty => buf_empty,
    
    s00_axis_tlast => s00_axis_tlast,
    read_en => read_en, 
    get_done_out => get_done,
    fifo_rd_en => fifo_rd_en,
    
    m00_axis_tvalid => m00_axis_tvalid,
    m00_axis_tdata => m00_axis_tdata,
    m00_axis_tkeep => m00_axis_tkeep,
    m00_axis_tlast => sig_m00_axis_tlast,
    m00_axis_tready => m00_axis_tready
    );

end Behavioral;
