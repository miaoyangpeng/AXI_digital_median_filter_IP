----------------------------------------------------------------------------------
-- Author: Yangpeng Miao
-- Design Name: AXI sender
-- Module Name: Filter_send - Behavioral
-- Description: 
-- AXI4-Stream Master interface. Transmitting data to "AXI DMA" IP. Make IP master interface compatible with AXI4-stream protocol
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

entity Filter_send is
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
end Filter_send;

architecture Behavioral of Filter_send is
    
    type send_state is ( IDLE, INIT, SEND);
    
    signal axi_send_valid, axi_send_last : std_logic;
    signal axi_send_data : std_logic_vector(31 downto 0);
    signal axi_send_keep : std_logic_vector(3 downto 0);
    
    signal state_for_send : send_state;

    signal get_done : std_logic;
begin
    
    m00_axis_tvalid <= axi_send_valid;
    m00_axis_tdata <= axi_send_data;
    m00_axis_tkeep <= axi_send_keep;
    m00_axis_tlast <= axi_send_last;
    
    get_done_out <= get_done;
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                state_for_send <= IDLE;       
            else
                case (state_for_send) is
                when IDLE =>                
                    if (buf_empty = '0') then
                        state_for_send <= INIT;
                    else
                        state_for_send <= IDLE;
                    end if;
                when INIT =>
                    state_for_send <= SEND;
                when SEND =>
                    if (buf_empty = '1') then
                        state_for_send <= IDLE;
                    else                                               
                        state_for_send <= SEND;
                    end if;
                when others =>
                    state_for_send <= IDLE;
                end case;
            end if;        
        end if;
    end process;
    
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                axi_send_valid <= '0';
            else
                if ((state_for_send = SEND) and (m00_axis_tready = '1')) then -- and (axi_send_valid = '0')) then
                   axi_send_valid <= fifo_rd_en; -- '1';
                elsif (buf_empty = '1') then
                   axi_send_valid <= '0';
                end if; 
            end if;
        end if;
    end process;

    read_en <= '1' when ((state_for_send = SEND) and (m00_axis_tready = '1') and (buf_empty = '0')) else
                '0';
    axi_send_data <= data_in;
    axi_send_keep <= data_keep;
    
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                axi_send_last <= '1';
                get_done<= '0';
            else
                if (s00_axis_tlast = '1') then
                   get_done <= '1';
               end if;
               
                if ((axi_send_valid = '0') and (state_for_send = SEND) and (axi_send_last = '1')) then
                   axi_send_last <= '0'; 
                elsif ((buf_pre_empty = '1') and (get_done = '1')) then
                   axi_send_last <= '1';
                   get_done <= '0';
                end if;                
            end if;
        end if;
    end process;

end Behavioral;
