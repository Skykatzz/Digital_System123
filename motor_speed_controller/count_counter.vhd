library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Counter is
    Port ( COUNT_UP_Left : in  STD_LOGIC;
           COUNT_DWN_Left : in  STD_LOGIC;
           COUNT_UP_Right : in  STD_LOGIC;
           COUNT_DWN_Right : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           C_OUT_Left : out  STD_LOGIC_VECTOR (7 downto 0);
           C_OUT_Right : out  STD_LOGIC_VECTOR (7 downto 0)); 
end Counter;

architecture Behavioral of Counter is

signal countinLeft: STD_LOGIC_VECTOR (7 downto 0); 
signal countinRight: STD_LOGIC_VECTOR (7 downto 0);

begin

--Counter Left
process(CLK, RST)
begin 
            if (RST='1') then
            countinLeft <=(others =>'0');
            elsif (CLK='1' and CLK'event)then
                if (COUNT_UP_Left = '1') then   
                    countinLeft <= countinLeft + 1;
                elsif (COUNT_DWN_Left =  '1')then
                    countinLeft <= countinLeft - 1;
                else countinLeft <= countinLeft;
            end if;
        end if;            
end process; 

    C_OUT_Left<=countinLeft; 
     
--Counter Right
process(CLK, RST)
begin 
            if (RST='1') then
            countinRight <=(others =>'0');
            elsif (CLK='1' and CLK'event)then
                if (COUNT_UP_Right = '1') then   
                    countinRight <= countinRight + 1;
                elsif (COUNT_DWN_Right =  '1')then
                    countinRight <= countinRight - 1;
                else countinRight <= countinRight;
            end if;
        end if;            
end process; 

    C_OUT_Right<=countinRight; 
    
end Behavioral;
