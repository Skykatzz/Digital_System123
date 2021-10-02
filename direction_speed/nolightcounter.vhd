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
	CLK : in  STD_LOGIC; -- 100 MHz
	RST : in  STD_LOGIC; -- asynchronous reset
	NLC_EN : in  STD_LOGIC; -- enable (or READY) from thresholding
	CAHAYA : in  STD_LOGIC_VECTOR(9 downto 0); -- from size 10 bit
	ROTATE : out STD_LOGIC); -- shows the desired state of robot
end nolightcounter;

architecture Behavioral of nolightcounter is
	signal ticks, clockcount : integer :=0;
	signal count_en, CCLK, b : std_logic;
begin

count_en <= '1' when CAHAYA < "0001100100" AND NLC_EN = '1' else '0';

-- clock divider: 100 Mhz to 1 MHz
process(RST,CLK, clockcount, b)
begin
if RST='1' then
    clockcount <= 0;
    b <= '0';
elsif rising_edge(CLK) then
    clockcount <= clockcount + 1;
    if (clockcount = 49999999) then
        b <= not b;
        clockcount <= 0;
    end if;
end if;
CCLK <= b;
end process;

-- COUNTER
process(RST, CCLK, count_en, ticks) is
begin
	if RST = '1' then -- asynchronous
		ticks <= 0; 
	elsif rising_edge(CCLK) then -- synchronous, 1 hz
		if count_en = '0' then
			ticks <= 0;
		else
			ticks <= ticks + 1; -- increment ticks
		end if;
	end if;
end process;

ROTATE <= '1' when ticks < 5 or count_en = '0' else '0';

end Behavioral;
