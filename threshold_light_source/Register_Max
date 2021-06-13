library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REGISTER_MAX is
    Port ( A : in std_logic_vector(9 downto 0);
           B : in std_logic_vector(9 downto 0);
           BA  : inout std_logic;
           DATA : in STD_LOGIC_VECTOR (9 downto 0);
           CLK : in STD_LOGIC;
           VSYNC : in STD_LOGIC;
           RST : in STD_LOGIC;
           REGMAX : out STD_LOGIC_VECTOR (9 downto 0));

end REGISTER_MAX;

architecture Behavioral of REGISTER_MAX is

signal MAX : STD_LOGIC_VECTOR (9 downto 0);

begin
    BA <= '1' when (B >= A)
            else '0';
process(DATA, RST, CLK, VSYNC) -- SENSITIVITY LIST
    begin 
        if RST = '1' then
            MAX <= (others => '0');
        elsif rising_edge(CLK) then
            if VSYNC = '1' then
                MAX <= (others => '0');
            elsif BA = '1' then
                MAX <= DATA;
            end if;
        end if;
    end process;

    REGMAX <= MAX;
end Behavioral;
