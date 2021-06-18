library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.all;

entity Ctrl is
 Port ( POSITION : in  STD_LOGIC_VECTOR (9 downto 0);
          SIZE : in  STD_LOGIC_VECTOR (9 downto 0);
          FIN_DELAY : in  STD_LOGIC;
          CTRL_EN : in  STD_LOGIC;
          LIGHT : out STD_LOGIC;
          GOAL_LEFT : out  STD_LOGIC_VECTOR (8 downto 0);
          GOAL_RIGHT : out  STD_LOGIC_VECTOR (8 downto 0)
          );
end Ctrl;

architecture Control of Ctrl is

signal a, b: STD_LOGIC_VECTOR (9 downto 0);
signal TGL, TGR: STD_LOGIC_VECTOR (9 downto 0);
signal TTGL, TTGR: STD_LOGIC_VECTOR (9 downto 0);

begin
    a <= POSITION - "0101000000"; --posisi - 320 (posisi tengah)
    b <= "0101011110" - SIZE; --350 (threshold size) - size pada saat itu 
    
    TGR <= b - a;
    TGL <= b + a;
    
    process(a, b, TGR) --mencegah overflow goal right
    begin
        if (a(9) = '0' and b(9) = '1' and TGR(9) = '0') then 
            TTGR <= "1000000001"; --mentok ke -511
        
        elsif (a(9) = '1' and b(9) = '0' and TGR(9) = '1') then 
            TTGR <= "0111111111"; --mentok ke 511
        else 
            TTGR <= TGR; --kalo bener, langsung
        end if; 
    end process;
    
    process(a, b, TGL) --mencegah overflow goal left
    begin
        if (a(9) = '1' and b(9) = '1' and TGL(9) = '0') then 
            TTGL <= "1000000001"; --mentok ke -511
        
        elsif (a(9) = '0' and b(9) = '0' and TGL(9) = '1') then 
            TTGL <= "0111111111"; --mentok ke 511
        else
            TTGL <= TGL; --kalo bener, langsung
        end if; 
    end process;
    
    process(SIZE, CTRL_EN, FIN_DELAY, TTGL, TTGR) --selector goal speed
    begin
        if ((FIN_DELAY = '0' AND SIZE = "0000000000") OR CTRL_EN = '0') then
            GOAL_LEFT <= (others => '0');
            GOAL_RIGHT <= (others => '0');
            LIGHT <= '0';
        elsif (FIN_DELAY = '1' AND CTRL_EN = '1' AND SIZE = "0000000000") then
            GOAL_LEFT <= "011111111";
            GOAL_RIGHT <= "100000001";
            LIGHT <= '0';
        --elsif SIZE > "0000000000" then
        else
            GOAL_LEFT <= TTGL(9 downto 1);
            GOAL_RIGHT <= TTGR(9 downto 1);
            LIGHT <= '1';
        end if;
    
    end process;

end Control;
