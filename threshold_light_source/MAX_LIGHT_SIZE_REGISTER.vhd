library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity MAX_LIGHT_SIZE_REGISTER is
    Port ( A : in std_logic_vector(9 downto 0);
           B : in std_logic_vector(9 downto 0);
           BA  : inout std_logic;
           DATA : in STD_LOGIC_VECTOR (9 downto 0);
           CLK : in STD_LOGIC;
           VSYNC : in STD_LOGIC;
           RST : in STD_LOGIC;
           MAX_SIZE : out STD_LOGIC_VECTOR (9 downto 0));

end MAX_LIGHT_SIZE_REGISTER;

architecture Behavioral of MAX_LIGHT_SIZE_REGISTER is

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

    MAX_SIZE <= MAX;
end Behavioral;
