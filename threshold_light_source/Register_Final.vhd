library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity Register_Final is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           LOAD_EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           VSYNC : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           POS : out  STD_LOGIC_VECTOR (9 downto 0));
end Register_Final;

architecture Behavioral of Register_Final is

signal Final : STD_LOGIC_VECTOR (9 downto 0);

begin

process (RST, CLK, VSYNC, LOAD_EN, DATA)
    begin
        if RST = '1' then
            Final <= (others => '0');
        elsif rising_edge(CLK) then
            if VSYNC = '1' then
                Final <= (others => '0');
            elsif LOAD_EN = '1' then
                Final <= DATA ;
            end if;
        end if;
    end process;

    POS <= Final;

end Behavioral;
