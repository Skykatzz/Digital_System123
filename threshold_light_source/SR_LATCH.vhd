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
    Port ( VSYNC : in STD_LOGIC;
           GND : in STD_LOGIC;
           RST : in STD_LOGIC;
           Q : inout STD_LOGIC;
           QBAR : inout STD_LOGIC);
end SR_LATCH;

architecture Behavioral of SR_LATCH is

signal a : std_logic := '1';
signal b : std_logic := '0';

begin
    process(RST, VSYNC, GND, a, b)
    begin
        if RST = '1' then
             a <= '1';
             b <= '0';

        else a <= VSYNC nor b;
             b <= GND nor a;

        end if;

    end process;

    Q <= a;
    QBAR <= b;

end Behavioral;
