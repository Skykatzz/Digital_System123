library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity COUNTER_LEBAR is
    Port ( Y : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           HREF : in STD_LOGIC;
           RST : in STD_LOGIC;
           YTHD : inout STD_LOGIC;
           COUNT_LEBAR : out STD_LOGIC_VECTOR (9 downto 0));
end COUNTER_LEBAR;

architecture Behavioral of COUNTER_LEBAR is
constant THD : STD_LOGIC_VECTOR (7 downto 0) := "10000000";--128
signal lebar : STD_LOGIC_VECTOR (9 downto 0);

begin
    YTHD <= '1' when (Y >= THD)
            else '0';

    process(RST, CLK, HREF) --Sensitivity List
    begin
        if RST = '1' then --Asynchronously
            lebar <= (others => '0');
        elsif rising_edge(CLK) then --Synchronously
                 if HREF = '1' AND YTHD = '1' then
                    lebar <= lebar + 1;
                 elsif YTHD = '0' OR HREF = '0' then
                    lebar <= (others => '0');
                 end if;
        end if;
    end process;
    COUNT_LEBAR <= lebar;

end Behavioral;
