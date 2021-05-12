library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity Counter is
    Port ( RCLK : in  STD_LOGIC; --misal 10 Hz
           RST : in  STD_LOGIC;
           COUNT_EN : in  STD_LOGIC;
           STR_DELAY : out STD_LOGIC);
end Counter;

architecture Count of Counter is
-- 5 detik --> 50 counting
Signal counting : std_logic_vector (5 downto 0);
begin
	
    Process(RCLK, RST)
    begin
        if RST = '1' or rising_edge(COUNT_EN) then --kalo direset
            	counting <= "000000";
		STR_DELAY <= '0';
        elsif rising_edge(RCLK) and COUNT_EN = '1' then
            	if counting = "110001" then -- 50 counting (0 sampai 49)
                	counting <= "000000";
            	else
                	counting <= counting + 1;
            	end if;
        end if;
    end process;
    
    STR_DELAY <= '1' when counting = "110001" else '0'; -- kalo udah 50 counting baru mulai delay
    
end Count;
