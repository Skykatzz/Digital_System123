library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity READY_INDICATOR is
    Port ( S : in STD_LOGIC; --Set '0'
           R : in STD_LOGIC;--Reset
           CLK : in STD_LOGIC; 
           RST : in STD_LOGIC; --Reset System
           Q : inout STD_LOGIC;
           READY : inout STD_LOGIC);

end READY_INDICATOR;

architecture Behavioral of READY_INDICATOR is

--Initial value of S and R
signal a : std_logic := '1';
signal b : std_logic := '0';

begin
    process(RST, R, S, a, b)
    begin
        if RST = '1' then
             a <= '1';
             b <= '0';

        else a <= R nor b;
             b <= S nor a;

        end if;

    end process;

    Q <= a;
    READY <= b;

end Behavioral;
