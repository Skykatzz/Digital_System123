library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter_Collumn is
    Port ( CLK : in  STD_LOGIC;
           HREF : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           COUNT_COLLUMN : out  STD_LOGIC_VECTOR (9 downto 0));
end Counter_Collumn;

architecture Behavioral of Counter_Collumn is

signal collumn_rst: STD_LOGIC_VECTOR(9 downto 0);
signal collumn: STD_LOGIC_VECTOR(9 downto 0) := "0000000001";

begin

    process(CLK,HREF,RST) 
    begin
        if RST = '1' then
            collumn_rst <= "0000000001";
            collumn <= "0000000001";
        elsif rising_edge(CLK)then
            if HREF = '1' then
                collumn <= collumn+1;
                collumn_rst <= collumn;
            elsif HREF = '0' then
                collumn_rst <= "0000000001";
                collumn <= "0000000001";
            end if;
        end if;
    end process;

    COUNT_COLLUMN <= collumn_rst-1;

end Behavioral;
