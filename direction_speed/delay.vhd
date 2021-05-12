library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity delay is
port(
	RCLK		: in std_logic; -- anggap 10 Hz
	timerreset	: in std_logic; -- reset asynchronous
	startdelay	: in std_logic; -- dari Q pada SRFFdelay
	RST		: in std_logic; -- async reset
	finishdelay	: out std_logic);
end entity;

architecture Behavioral of delay is
    signal ticks: std_logic_vector(3 downto 0);
    signal seconds: std_logic_vector(3 downto 0);
begin
process(RCLK, RST) is
begin
	
if RST = '1' then
	ticks <= "0000";
        seconds <= "0000";
	finishdelay <= '1';
elsif timerreset = '1' then
	ticks <= "0000";
        seconds <= "0000";
	finishdelay <= '0';
elsif startdelay = '1' then --kalo disuruh mulai oleh SRFFdelay
        if rising_edge(RCLK) then
            	if ticks = "1001" then --10 hz
                	if seconds = "1001" then --10 detik delay
                    		seconds <= "0000";
                    		finishdelay <= '1';
                	else
                    		finishdelay <= '0';
		    		seconds <= seconds + 1;
                	end if;
                ticks <= "0000";
            	else
			ticks <= ticks + 1; -- 
            	end if;
	end if; 
end if;
end process;

end Behavioral;
