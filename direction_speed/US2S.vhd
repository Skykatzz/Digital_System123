library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity US2S is
      generic
      (
              Nbits : positive := 9 
       );
 port 
( 
           --Inputs
           RMF_DIRECTION : in std_logic ;
			  RMF_SPEED : in std_logic_vector (Nbits-1 downto 0);
			  LMF_DIRECTION : in std_logic ;
			  LMF_SPEED : in std_logic_vector (Nbits-1 downto 0);
			  RCLK: in std_logic;
           --Outputs
           L_Feedback : out std_logic_vector (Nbits downto 0);
			  R_Feedback : out std_logic_vector (Nbits downto 0)
);
end US2S;

architecture US2S_v1 of US2S is
signal tempL : std_logic_vector(Nbits-1 downto 0);
signal tempR : std_logic_vector(Nbits-1 downto 0);

begin
	process(LMF_DIRECTION,LMF_SPEED,RCLK)
	begin
		if RCLK='1' then
		if LMF_DIRECTION = '0' then --Left 0 CW (MAJU)
			L_Feedback <= ('0' & LMF_SPEED) ;
		elsif LMF_DIRECTION <='1' then --Left 1 CCW (Mundur)
			tempL <= not LMF_SPEED;
			L_Feedback<= ('0'&(tempL + 1));
		end if;
		end if;
	end process ;
	
	process(RMF_DIRECTION,RMF_SPEED,RCLK)
	begin
		if RCLK='1' then
		if  RMF_DIRECTION ='1' then --Right 1 CCW (MAJU)
			 R_Feedback <= ('0' & RMF_SPEED) ;
		elsif RMF_DIRECTION ='0' then --Right 0 CW (Mundur)	
			tempR <= not RMF_SPEED;
			R_Feedback<= ('0'&(tempR + 1));
		end if ;
		end if;
	end process ;

end US2S_v1;
