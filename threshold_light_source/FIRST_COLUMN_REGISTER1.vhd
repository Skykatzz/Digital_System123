library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity FIRST_COLUMN_REGISTER1 is
    Port ( DATA : in STD_LOGIC_VECTOR (9 downto 0);
           LOAD_EN : in STD_LOGIC_VECTOR (9 downto 0);
           CLK : in STD_LOGIC;
           VSYNC : in STD_LOGIC;
           RST : in STD_LOGIC;
           F_CR1 : out STD_LOGIC_VECTOR (9 downto 0));
end FIRST_COLUMN_REGISTER1;

architecture Behavioral of FIRST_COLUMN_REGISTER1 is

signal COLUMN_REGISTER1_RST : STD_LOGIC_VECTOR (9 downto 0);
signal COLUMN_REGISTER1 : STD_LOGIC_VECTOR (9 downto 0) := "0000000001";

begin

process(RST, CLK, VSYNC, LOAD_EN) -- SENSITIVITY LIST
    begin 
        if RST = '1' then
            COLUMN_REGISTER1_RST <= "0000000000";
            COLUMN_REGISTER1 <= "0000000000";
        elsif rising_edge(CLK) then
            if VSYNC = '1' then
                COLUMN_REGISTER1_RST <= "0000000000";
                COLUMN_REGISTER1 <= "0000000000";
            elsif LOAD_EN = "1" then
                COLUMN_REGISTER1_RST <= DATA ;
            end if;
        end if;
    end process;

    F_CR1 <= COLUMN_REGISTER1_RST - 1 ;

end Behavioral;
