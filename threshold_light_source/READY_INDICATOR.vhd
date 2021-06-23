library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity READY_INDICATOR is
    Port ( R : in STD_LOGIC; --srl_rst
           S : in STD_LOGIC; --srl_set
           RST : in STD_LOGIC; --Reset System
           READY : out STD_LOGIC);--finish
end READY_INDICATOR;

architecture Behavioral of READY_INDICATOR is

signal Q : std_logic := '1';
signal QBAR : std_logic := '0';

begin
    process(RST, R, S, Q, QBAR)
    begin
        if RST = '1' then
             Q <= '1';
             QBAR <= '0';

        else Q <= R nor QBAR;
             QBAR <= S nor Q;

        end if;

    end process;

    READY <= QBAR;

end Behavioral;
