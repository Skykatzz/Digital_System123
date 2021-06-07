----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:20:42 04/23/2021 
-- Design Name: 
-- Module Name:    Datapath - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
-- entity -> berhubungan dengan luar
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
-- entity -> berhubungan dengan luar
entity i2cSender is
    Port ( sioc : out  STD_LOGIC;
           siod : out  STD_LOGIC;
           reset : out   STD_LOGIC;
           pwdn  : out   STD_LOGIC;
           xclk  : out   STD_LOGIC;
           clk : in  STD_LOGIC;
           config_finished : out STD_LOGIC;
           RST : in  STD_LOGIC);
           
end i2cSender;

architecture Behavioral of i2cSender is


component Shift_reg is
    Port ( Data : in  STD_LOGIC_VECTOR (27 downto 0);
           LOAD_EN : in  STD_LOGIC;
           SHIFT_EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Siod : out  STD_LOGIC);
			  
end component;

component ov7670_controller is
    Port ( Count_EN : out  STD_LOGIC;
           LOAD_EN : out  STD_LOGIC;
           SHIFT_EN : out  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           SET_EN: out STD_LOGIC;
           stop_cond : in STD_LOGIC;
           advance : out STD_LOGIC;
           RESET_EN: out STD_LOGIC
           ); 

end component;

component counter is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           COUNT_EN : in  STD_LOGIC;
			  stop_cond : out STD_LOGIC
			  );
end component;

component Flipflop is
    Port ( SET_EN : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           RESET_EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           sioc : out  STD_LOGIC);
end component;
        
        COMPONENT ov7670_registers
PORT(
        clk      : IN std_logic;
        advance  : IN std_logic;
        rst   : in STD_LOGIC;
        command  : OUT std_logic_vector(15 downto 0);
        finished : OUT std_logic
        );
END COMPONENT;


 signal internal_data: STD_LOGIC_VECTOR(27 downto 0);
 signal internal_count_en: STD_LOGIC;
 signal internal_stop_cond : STD_LOGIC;
 signal internal_load_en: STD_LOGIC;
 signal internal_shift_en: STD_LOGIC;
 signal internal_set_en: STD_LOGIC; 
 signal internal_reset_en: STD_LOGIC;
 signal sys_clk  : std_logic := '0';
 signal command  : std_logic_vector(15 downto 0);
 signal finished : std_logic := '0';
 signal taken    : std_logic := '0';
 signal send     : std_logic;
 signal internal_advance: std_logic;
 signal Data_in : std_logic;
         constant camera_address : std_logic_vector(7 downto 0) := x"42";
begin
       config_finished <= finished;

       reset <= '1';                                           -- Normal mode
       pwdn  <= '0';                                           -- Power device up
       xclk  <= sys_clk;
       Inst_ov7670_registers: ov7670_registers PORT MAP(
                      clk      => clk,
                      advance  => internal_advance,
                      command  => command,
                      finished => finished,
                      rst   => rst
              );
      
       process(clk)
       begin
            if rising_edge(clk) then
                              sys_clk <= not sys_clk;
            end if;
      end process;
	Datapath_ov7670controller: ov7670_controller
	port map (
	Count_EN => internal_Count_En,
	LOAD_EN => internal_load_en,
	SHIFT_EN => internal_shift_en,
	CLK => CLK,
	RST => RST,
	SET_EN => internal_SET_EN,
   RESET_EN => internal_RESET_EN,
   advance => internal_advance,
	stop_cond => internal_stop_cond
	);
	
	Datapath_shift_reg: Shift_reg
	port map (
	Data =>  internal_data,
	LOAD_EN => internal_LOAD_EN,
	SHIFT_EN => internal_SHIFT_EN,
	CLK => CLK,
	RST => RST,
	SIOD => SIOD);

	Datapath_counter: counter
	port map(
		   CLK => clk,
           RST => RST,
           COUNT_EN =>internal_COUNT_EN,
		   stop_cond => internal_stop_cond);
			  
	Datapath_flipflop: Flipflop
	port map (
		   SET_EN => internal_SET_EN,
           RST    => RST,
           RESET_EN => internal_RESET_EN,
           CLK 	=> clk,
           sioc => sioc);
    
	internal_data(27) <= '0';
	internal_data(26 downto 19) <= camera_address;
	internal_data(18) <= '1' ;
	internal_data(17 downto 10) <= command(15 downto 8);
	internal_data(9) <= '1' ;
	internal_data(8 downto 1) <= command(7 downto 0);
	internal_data(0) <= '0' ;
    
end Behavioral;

