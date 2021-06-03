----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:00:39 04/23/2021 
-- Design Name: 
-- Module Name:    Flipflop - Behavioral 
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

entity Flipflop is
    Port ( SET_EN : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           RESET_EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           sioc : out  STD_LOGIC);
end Flipflop;

architecture Behavioral of Flipflop is

begin

	process(RST, CLK)
		begin 
		if RST = '1' then
			sioc <= '1' ; 
		elsif rising_edge(clk) then 
			if SET_EN = '1' then
				sioc <= '1' ;
			elsif RESET_EN = '0' then
				sioc <= '0';
			end if;
		end if;
	end process;
end Behavioral;

