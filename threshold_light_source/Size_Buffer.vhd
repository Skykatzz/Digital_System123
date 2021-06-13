library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.All;
use ieee.std_logic_unsigned.All;

entity Size_Buffer is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           VSYNC : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Size_B : out  STD_LOGIC_VECTOR (9 downto 0));
end Size_Buffer;

architecture Behavioral of Size_Buffer is

signal size: STD_LOGIC_VECTOR (9 downto 0);

begin

process(DATA, VSYNC, RST) 
begin
        if RST = '1' then
            size <= (others => '0');
        elsif VSYNC = '1' then
            size <= DATA;
      end if;
    end process;

    Size_B <= size;

end Behavioral;
