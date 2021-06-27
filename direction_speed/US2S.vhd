library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity US2S is
 port 
( --Inputs
  RMF_DIRECTION : in std_logic ;
  RMF_SPEED : in std_logic_vector (7 downto 0);
  LMF_DIRECTION : in std_logic ;
  LMF_SPEED : in std_logic_vector (7 downto 0);
  --Outputs
  L_Feedback : out std_logic_vector (8 downto 0);
  R_Feedback : out std_logic_vector (8 downto 0)
);
end US2S;

architecture US2S_v1 of US2S is
signal tempL,tempR : std_logic_vector(7 downto 0);

begin

tempL <= (not LMF_SPEED) + 1;
process(LMF_DIRECTION,LMF_SPEED,tempL)
begin
	if LMF_DIRECTION = '0' then --Left 0 CW (MAJU)
	   L_Feedback(8) <= '0';
	   L_Feedback(7 downto 0) <= LMF_SPEED;
	else
	   L_Feedback(8) <= '1';
       L_Feedback(7 downto 0) <= tempL;
	end if;
end process;
	
tempR <= (not RMF_SPEED)+1;
process(RMF_DIRECTION,RMF_SPEED,tempR)
begin
	if  RMF_DIRECTION ='1' then --Right 1 CCW (MAJU)
	    R_Feedback(8) <= '0';
        R_Feedback(7 downto 0) <= RMF_SPEED;
	else
	    R_Feedback(8) <= '1';
	    R_Feedback(7 downto 0) <= tempR;
	end if;
end process ;

end US2S_v1;
