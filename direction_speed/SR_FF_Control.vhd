----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:45:06 04/28/2021 
-- Design Name: 
-- Module Name:    SR_FF_Control - Behavioral 
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

entity SR_FF_Control is
    Port ( SET_EN : in  STD_LOGIC; --from delay FIN_DELAY
			  RST_EN : in STD_LOGIC; --from ocunter STR_DELAY
			  CLOCK : in STD_LOGIC; --original clock
			  RST : in STD_LOGIC; --asynchronous reset
           Q : out  STD_LOGIC);
end SR_FF_Control;

architecture Mem of SR_FF_Control is

begin
	process(RST, CLOCK)
	begin
		if RST = '1' then 
			Q <= '1';
		elsif rising_edge(CLOCK) then
			if RST_EN = '1' then 
				Q <= '0';
			elsif SET_EN = '1' then
				Q <= '1'; 
			end if;
		end if;
	end process;

end Mem;

