-- Made by: Richard Medyanto
-- https://www.instructables.com/member/richardmedyanto/
-- https://www.instructables.com/PART-4-the-Absence-of-Light/
-- This module works only if light source is not detected.
-- Remember to reset the robot when you first turn it on.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity nolightcounter is
Port (
	CLK : in  STD_LOGIC; -- 62.5 Hz, from VSYNC
	RST : in  STD_LOGIC; -- asynchronous reset
	NLC_EN : in  STD_LOGIC; -- enable (or READY) from thresholding
	CAHAYA : in  STD_LOGIC_VECTOR(9 downto 0); -- from size 10 bit
	ROTATE : out STD_LOGIC); -- shows the desired state of robot
end nolightcounter;

architecture Behavioral of nolightcounter is
	signal ticks : std_logic_vector(9 downto 0);
	signal count_en : std_logic;
begin

count_en <= '1' when CAHAYA < "0001100100" AND NLC_EN = '1' else '0';

-- COUNTER
process(RST, CLK, count_en, ticks) is
begin
	if RST = '1' then -- asynchronous
		ticks <= (others => '0'); 
	elsif rising_edge(CLK) then -- synchronous
		if count_en = '0' then
			ticks <= (others => '0');
		else
			ticks <= ticks + 1; -- increment ticks
		end if;
	end if;
end process;

ROTATE <= '1' when ticks < "0100111001" or count_en = '0' else '0';

end Behavioral;
