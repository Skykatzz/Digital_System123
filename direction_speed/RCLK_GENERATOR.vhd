library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity RCLK_generator is
port(	CLK : IN STD_LOGIC;
		RST : IN STD_LOGIC;
		RCLK: OUT STD_LOGIC);
end RCLK_generator;

architecture Behavioral of RCLK_generator is

	SIGNAL COUNT: STD_LOGIC_VECTOR(2 DOWNTO 0);--membagi clock dengan 2^3 (dibagi 8)

begin

process(CLK, RST) --counter dan komparator
begin
		if RST = '1' then --kalo direset
			COUNT <= "000";
			RCLK <= '0';
		elsif rising_edge(CLK) then
			COUNT <= COUNT + 1;
			if COUNT < "100" then
				RCLK <= '1';
			else
				RCLK <= '0';
			END IF;
      end if;
end process;

end Behavioral;
