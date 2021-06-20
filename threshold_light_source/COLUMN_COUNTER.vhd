library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity COLUMN_COUNTER is
    Port ( CLK : in  STD_LOGIC;
           HREF : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           COUNT_COLUMN : out  STD_LOGIC_VECTOR (9 downto 0));
end COLUMN_COUNTER;

architecture Behavioral of COLUMN_COUNTER is

signal column_rst: STD_LOGIC_VECTOR(9 downto 0);
signal column: STD_LOGIC_VECTOR(9 downto 0) := "0000000001";

begin

    process(CLK,HREF,RST) 
    begin
        if RST = '1' then
            column_rst <= "0000000001";--initial value of column_rst = 1
            column <= "0000000001";--initial value of column = 1
        elsif rising_edge(CLK)then
            if HREF = '1' then
                column <= column+1;
                column_rst <= column;
            elsif HREF = '0' then --back to initial condition
                column_rst <= "0000000001";
                column <= "0000000001";
            end if;
        end if;
    end process;

    COUNT_COLUMN <= column_rst-1;

end Behavioral;
