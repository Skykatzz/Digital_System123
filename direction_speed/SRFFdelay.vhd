library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SRFFdelay is
    Port ( set : in  STD_LOGIC;
           CLOCK : in  STD_LOGIC;
			  RST_EN : in std_logic;
           Q : out  STD_LOGIC;
           RST : in  STD_LOGIC);
end SRFFdelay;

architecture Behavioral of SRFFdelay is

begin

process(RST, CLOCK)
begin
    if RST = '1' then
        Q <= '0';
    elsif rising_edge(CLOCK) then
		  if RST_EN = '1' then
				Q <= '0';
        elsif set = '1' then
            Q <= '1';
        end if;
    end if;
end process;

end Behavioral;
