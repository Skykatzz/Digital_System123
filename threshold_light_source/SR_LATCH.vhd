library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SR_LATCH is
    Port ( VSYNC : in STD_LOGIC; --Reset
           SET : in STD_LOGIC;
           RST : in STD_LOGIC; --Reset System
           Q : inout STD_LOGIC;
           READY : inout STD_LOGIC);
end SR_LATCH;

architecture Behavioral of SR_LATCH is

signal a : std_logic := '1';
signal b : std_logic := '0';

begin
    process(RST, VSYNC, SET, a, b)
    begin
        if RST = '1' then
             a <= '1';
             b <= '0';

        else a <= VSYNC nor b;
             b <= SET nor a;

        end if;

    end process;

    Q <= a;
    READY <= b;

end Behavioral;
