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
	VSYNC : in  STD_LOGIC; -- 62.5 Hz, from clock
	RST : in  STD_LOGIC; -- asynchronous reset
	NLC_EN : in  STD_LOGIC; -- enable (or READY) from thresholding
	CAHAYA : in  STD_LOGIC; -- availability of light
	FINISH : out STD_LOGIC); -- shows the desired state of robot
end nolightcounter;

architecture Behavioral of nolightcounter is
	signal ticks, tix: std_logic_vector(9 downto 0);
	signal srl_set, srl_rst, Q, QBAR: std_logic;
begin

process(VSYNC, RST, NLC_EN, CAHAYA, tix) is  -- PROCESS FOR COUNTING
begin
	if RST = '1' or NLC_EN = '0' or CAHAYA = '1' then -- if robot is reset, camera not ready, or light is detected
		ticks <= "0000000000";
	elsif rising_edge(VSYNC) then -- counter
		if tix = "1110101010" then -- when ticks = 938
			ticks <= "0000000000"; -- resets the value of ticks
		else
			ticks <= ticks + "0000000001"; -- increment ticks when ticks =/= 938
		end if;
	end if;
end process;

-- register the value of ticks to tix
tix <= ticks;		
		
-- resets the latch when ticks = 313
-- (note: 313 ticks / 62.5 Hz = 5 seconds)
-- causing the robot to STAY in place
srl_rst <= '1' when ticks = "0100111001" else '0';

-- sets the latch when ticks = 938
-- (note: 938 ticks / 62.5 Hz = 15 seconds, or 10 seconds after the first 313 ticks)
-- causing the robot to ROTATE in place
srl_set <= '1' when RST = '1' or NLC_EN = '0' or CAHAYA = '1' or ticks = "1110101010" else '0';


-- SR LATCH:	
QBAR <= srl_rst nor Q;
Q <= srl_set nor QBAR;
	
FINISH <= QBAR;

	
end Behavioral;
