library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity error is
    Port ( GOAL : in  STD_LOGIC_VECTOR (8 downto 0);-- 
           FEEDBACK : in  STD_LOGIC_VECTOR (8 downto 0);
           action : out  STD_LOGIC_VECTOR (8 downto 0);
			  R_CLOCK : in STD_LOGIC;
			  rst : in std_logic);
end error;

architecture Behavioral of error is

signal IN_action: std_logic_vector (8 downto 0);
signal temp_action: std_logic_vector (8 downto 0);

begin
	process(GOAL,FEEDBACK,IN_ACTION)
	begin
		temp_action <= GOAL - FEEDBACK; 
		if (GOAL(8) = 1 and FEEDBACK(8) = 0 and temp_action(8) = 0) then
			IN_action <= "100000001";
		elsif( GOAL(8) = 0 and FEEDBACK(8) = 1 and temp_action(8) = 1) then
			IN_action <= "011111111";
		else
			IN_action <= temp_action;
		end if;	
	end process;
	
	process(rst,R_CLOCK)
	begin
		if (rst = '1')then
			action <= "00000000";
		elsif (rising_edge(R_CLOCK)) then
			action <= IN_action;
		end if;
	end process;
end Behavioral;
