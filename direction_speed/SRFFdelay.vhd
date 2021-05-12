library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SRFFdelay is
    Port ( SETEN : in  STD_LOGIC;
           RCLK : in  STD_LOGIC;
	   RSTEN : in std_logic;
           DELAYOUT : out  STD_LOGIC;
           RST : in  STD_LOGIC);
end SRFFdelay;

architecture Behavioral of SRFFdelay is

begin
process(RST, RCLK)
begin
    if RST = '1' then
        DELAYOUT <= '0';
    elsif rising_edge(RCLK) then
	if rising_edge(RSTEN) then
		DELAYOUT <= '0';
        elsif SETEN = '1' then
		DELAYOUT <= '1';
        end if;
    end if;
end process;

end Behavioral;
