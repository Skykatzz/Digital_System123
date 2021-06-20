library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.All;
use ieee.std_logic_unsigned.All;

entity SIZE_BUFFER is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           NOT_HREF : in STD_LOGIC;
           RST : in  STD_LOGIC;
           SIZE_B : out  STD_LOGIC_VECTOR (9 downto 0));
end SIZE_BUFFER;

architecture Behavioral of SIZE_BUFFER is

signal SIZE: STD_LOGIC_VECTOR (9 downto 0);

begin

process(DATA, NOT_HREF, RST) 
begin
        if RST = '1' then
            SIZE <= (others => '0');
        elsif rising_edge (NOT_HREF) then
            SIZE <= DATA;
        end if;
    end process;

    SIZE_B <= SIZE;

end Behavioral;
