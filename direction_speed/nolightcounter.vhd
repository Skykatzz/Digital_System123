-- Made by: Richard Medyanto
-- https://www.instructables.com/member/richardmedyanto/
-- https://www.instructables.com/PART-4-the-Absence-of-Light/
-- This module only works if light source is not detected.
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
	signal ticks: std_logic_vector(9 downto 0);
	signal srl_set, srl_rst, Q, QBAR: std_logic;
begin

	process(VSYNC, RST, NLC_EN, CAHAYA) is  -- PROCESS FOR COUNTING
	begin
		if RST = '1' or NLC_EN = '0' or CAHAYA = '1' then -- if robot is reset, camera not ready, or light is detected
			ticks <= "0000000000";
			srl_rst <= '0';
			srl_set <= '1';
			-- if light is detected, ticks, srl_set, and srl_rst will set to default,
			-- and this module is ignored.
		else -- if RST = '0' or NLC_EN = '1' or CAHAYA = '0'
			if rising_edge(VSYNC) then -- when the clock changes from 0 to 1
				if ticks = "0100111001" then -- after roughly 5 seconds (0 - 313, 313 ticks/62.5 Hz = 5 seconds)
					srl_rst <= '1'; -- resets the latch, causing FINISH => 0, tells the robot to stop moving
					ticks <= ticks + 1; -- increment ticks again
				elsif ticks = "1110101010" then -- after roughly 10 seconds (314 - 938)
					srl_set <= '1' ; -- sets the latch, causing FINISH => 1, tells the robot to rotate again
			   		ticks <= "0000000000"; -- resets the value of ticks
				else
	    		   		srl_rst <= '0';
					srl_set <= '0'; -- the latch will remember the latest values of the outputs
					ticks <= ticks + 1; -- increment ticks
				end if;
			end if;
		end if;
	end process;
	
	-- SR LATCH:	
	QBAR <= srl_rst nor Q;
	Q <= srl_set nor QBAR;
	
	FINISH <= QBAR;

	
end Behavioral;
