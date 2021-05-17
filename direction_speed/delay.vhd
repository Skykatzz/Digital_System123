library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity delay is
port(
	RCLK		: in std_logic; -- 10 Hz
	timerreset	: in std_logic; -- reset asynchronous, dari light (jika 1 --> ada cahaya)
	startdelay	: in std_logic; -- dari DELAYOUT pada SRFFdelay
	RST		: in std_logic; -- async reset
	finishdelay	: out std_logic);
end entity;

architecture Behavioral of delay is
    signal ticks: std_logic_vector(7 downto 0);
begin
	
process(RCLK, RST) is
begin
	
if RST = '1' or timerreset = '1' then
	ticks <= "00000000";
	finishdelay <= '1';
	
elsif timerreset = '0' and startdelay = '1' and rising_edge(RCLK) then --kalo disuruh mulai oleh SRFFdelay
	if ticks = "01100011" then -- 100 tick (0 - 99) = 10 DETIK
		finishdelay <= '1';
		ticks <= "00000000";
	else
		finishdelay <= '0';
		ticks <= ticks + 1;
	end if;

end if;
	
end process;

end Behavioral;
