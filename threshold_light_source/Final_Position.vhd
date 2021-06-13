library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FINAL_POSITION is
    Port ( POS : in STD_LOGIC_VECTOR (9 downto 0);
           REGMAX : in STD_LOGIC_VECTOR (9 downto 0);
           F_POS : out STD_LOGIC_VECTOR (9 downto 0));
end FINAL_POSITION;

architecture Behavioral of FINAL_POSITION is


begin
        F_POS <= POS+ ('0' & REGMAX (9 downto 1));
 
end Behavioral;
