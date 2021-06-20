library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.All;
use ieee.std_logic_unsigned.All;

entity POSITION_BUFFER is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           NOT_HREF : in STD_LOGIC;
           RST : in  STD_LOGIC;
           POS_B : out  STD_LOGIC_VECTOR (9 downto 0));
end POSITION_BUFFER;

architecture Behavioral of POSITION_BUFFER is

signal POS : STD_LOGIC_VECTOR (9 downto 0);

begin

process(DATA, NOT_HREF, RST) 
begin
        if RST = '1' then
            POS <= (others => '0');
        elsif rising_edge (NOT_HREF) then
            POS <= DATA;
        end if;
    end process;

    POS_B <= POS;

end Behavioral;
