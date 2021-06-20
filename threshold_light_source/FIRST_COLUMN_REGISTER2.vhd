library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity FIRST_COLUMN_REGISTER2 is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           LOAD_EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           VSYNC : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           F_CR2 : out  STD_LOGIC_VECTOR (9 downto 0));
end FIRST_COLUMN_REGISTER2;

architecture Behavioral of FIRST_COLUMN_REGISTER2 is

signal COLUMN_REGISTER2 : STD_LOGIC_VECTOR (9 downto 0);

begin

process (RST, CLK, VSYNC, LOAD_EN, DATA)
    begin
        if RST = '1' then
            COLUMN_REGISTER2 <= (others => '0');
        elsif rising_edge(CLK) then
            if VSYNC = '1' then
                COLUMN_REGISTER2 <= (others => '0');
            elsif LOAD_EN = '1' then
                COLUMN_REGISTER2 <= DATA ;
            end if;
        end if;
    end process;

    F_CR2 <= COLUMN_REGISTER2;

end Behavioral;
