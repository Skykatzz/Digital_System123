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

entity REGISTER_COLLUMN_AWAL is
    Port ( DATA : in STD_LOGIC_VECTOR (9 downto 0);
           LOAD_EN : in STD_LOGIC_VECTOR (9 downto 0);
           CLK : in STD_LOGIC;
           VSYNC : in STD_LOGIC;
           RST : in STD_LOGIC;
           COLLUMN_AWAL : out STD_LOGIC_VECTOR (9 downto 0));
end REGISTER_COLLUMN_AWAL;

architecture Behavioral of REGISTER_COLLUMN_AWAL is

signal AWAL_RST : STD_LOGIC_VECTOR (9 downto 0);
signal AWAL : STD_LOGIC_VECTOR (9 downto 0) := "0000000001";

begin

process(RST, CLK, VSYNC, LOAD_EN) -- SENSITIVITY LIST
    begin 
        if RST = '1' then
            AWAL_RST <= "0000000000";
            AWAL <= "0000000000";
        elsif rising_edge(CLK) then
            if VSYNC = '1' then
                AWAL_RST <= "0000000000";
                AWAL <= "0000000000";
            elsif LOAD_EN = "1" then
                AWAL_RST <= DATA ;
            end if;
        end if;
    end process;

    COLLUMN_AWAL <= AWAL_RST - 1 ;

end Behavioral;
