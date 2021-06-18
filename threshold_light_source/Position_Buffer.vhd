library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.All;
use ieee.std_logic_unsigned.All;

entity Position_Buffer is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           VSYNC : in  STD_LOGIC;
           NOT_CLK : in STD_LOGIC;
           RST : in  STD_LOGIC;
           Pos_B : out  STD_LOGIC_VECTOR (9 downto 0));
end Position_Buffer;

architecture Behavioral of Position_Buffer is

signal pos : STD_LOGIC_VECTOR (9 downto 0);

begin

process(DATA, VSYNC, RST, NOT_CLK) 
begin
        if RST = '1' then
            pos <= (others => '0');
        elsif rising_edge (NOT_CLK) then
            pos <= DATA;
        end if;
    end process;

    Pos_B <= pos;

end Behavioral;
