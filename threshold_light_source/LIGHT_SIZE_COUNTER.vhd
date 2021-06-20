library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity LIGHT_SIZE_COUNTER is
    Port ( Y : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           HREF : in STD_LOGIC;
           RST : in STD_LOGIC;
           YTHD : inout STD_LOGIC;
           COUNT_LIGHT_SIZE : out STD_LOGIC_VECTOR (9 downto 0));
end LIGHT_SIZE_COUNTER;

architecture Behavioral of LIGHT_SIZE_COUNTER is
constant THD : STD_LOGIC_VECTOR (7 downto 0) := "10000000";--128
signal LIGHT_SIZE : STD_LOGIC_VECTOR (9 downto 0);

begin
    YTHD <= '1' when (Y >= THD)
            else '0';

    process(RST, CLK, HREF) --Sensitivity List
    begin
        if RST = '1' then --Asynchronously
            LIGHT_SIZE <= (others => '0');
        elsif rising_edge(CLK) then --Synchronously
                 if HREF = '1' AND YTHD = '1' then
                    LIGHT_SIZE <= LIGHT_SIZE + 1;
                 elsif YTHD = '0' OR HREF = '0' then
                    LIGHT_SIZE <= (others => '0');
                 end if;
        end if;
    end process;
    COUNT_LIGHT_SIZE <= LIGHT_SIZE;

end Behavioral;
