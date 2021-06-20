library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 
use IEEE.STD_LOGIC_unsigned.ALL;


entity FINAL_POSITION is
    Port ( F_CR2 : in STD_LOGIC_VECTOR (9 downto 0);
           MAX_SIZE : in STD_LOGIC_VECTOR (9 downto 0);
           F_POS : out STD_LOGIC_VECTOR (9 downto 0));
end FINAL_POSITION;

architecture Behavioral of FINAL_POSITION is


begin
        F_POS <= F_CR2 + ('0' & MAX_SIZE(9 downto 1));
 
end Behavioral;
