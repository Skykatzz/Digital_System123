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
entity i2cSender is
    Port ( sioc : out  STD_LOGIC;
           siod : out  STD_LOGIC;
           Value : in  STD_LOGIC_VECTOR(7 downto 0);
			  ID : in STD_LOGIC_VECTOR(7 downto 0);
			  RegAdd : in STD_LOGIC_VECTOR(7 downto 0);
           LOAD_EN : in  STD_LOGIC;
           SHIFT_EN : in  STD_LOGIC;
           COUNT_EN : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           SET_EN : in  STD_LOGIC;
           RESET_EN : in  STD_LOGIC;
			  Count : out  STD_LOGIC_VECTOR (4 downto 0);
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

component ov7670controller is
    Port ( Count_EN : out  STD_LOGIC;
           LOAD_EN : out  STD_LOGIC;
           SHIFT_EN : out  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
		   siod : in STD_LOGIC;
           Sioc : in  STD_LOGIC;
           SET_EN: out STD_LOGIC;
           stop_cond : in STD_LOGIC;
           RESET_EN: out STD_LOGIC
           ); 

end component;

component counter is
    Port ( CLK : in  STD_LOGIC;
           Count : out  STD_LOGIC_VECTOR (4 downto 0);
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

 signal data: STD_LOGIC_VECTOR(27 downto 0);
 signal counts: STD_LOGIC_VECTOR(4 downto 0);
 signal stop_cond : STD_LOGIC;
begin
	Datapath_ov7670controller: ov7670controller
	port map (
	Count_EN => Count_En,
	LOAD_EN => LOAD_EN,
	SHIFT_EN => SHIFT_EN,
	CLK => CLK,
	RST => RST,
	SIOD => SIOD,
	SET_EN => SET_EN,
   RESET_EN => RESET_EN,
	Sioc => SIOC,
	stop_cond => stop_cond
	);
	
	Datapath_shift_reg: Shift_reg
	port map (
	Data => data ,
	LOAD_EN => LOAD_EN,
	SHIFT_EN => SHIFT_EN,
	CLK => CLK,
	RST => RST,
	SIOD => SIOD);

	Datapath_counter: counter
	port map(
			  CLK => clk,
           Count => counts,
           RST => RST,
           COUNT_EN => COUNT_EN,
			  stop_cond => stop_cond);
			  
	Datapath_flipflop: Flipflop
	port map (
			  SET_EN => SET_EN,
           RST    => RST,
           RESET_EN => RESET_EN,
           CLK 	=> clk,
           sioc => sioc);
		
	data(27) <= '0';
	data(26 downto 19) <= id;
	data(18) <= '1' ;
	data(17 downto 10) <= value;
	data(9) <= '1' ;
	data(8 downto 1) <= REGADD;
	data(0) <= '0' ;

end Behavioral;

