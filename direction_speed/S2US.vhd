library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

entity S2US is
 port 
( 
           --Inputs DARI NICO
           L_action : in  STD_LOGIC_VECTOR (8 downto 0); -- 9 bit
           R_action : in  STD_LOGIC_VECTOR (8 downto 0);
           --Outputs
           RM_DIRECTION : out std_logic ;
           RM_SPEED : out std_logic_vector (7 downto 0);
           LM_DIRECTION : out std_logic ;
           LM_SPEED : out std_logic_vector (7 downto 0);
			  RST : in std_logic
);
              end S2US;

architecture Behavioral of S2US is
            
                signal tempL : std_logic_vector(8 downto 0);
                signal tempR : std_logic_vector(8 downto 0);


begin
tempL <= (not L_action) + 1; -- 9 bit
process(L_action,tempL,rst)
begin
	    if rst = '1' then
		LM_DIRECTION <= '0';
		LM_SPEED <= "00000000";
	    elsif L_action(8) = '1' then
		LM_DIRECTION <= '1'; -- Mundur
         	LM_SPEED <= tempL (7 downto 0); -- cara biar jadi 8 bit
       	   else 
         	LM_DIRECTION <= '0'; -- Maju
         	LM_SPEED <= L_action (7 downto 0);  --ambil bit ke 7 to 0
      	 end if; 
end process;
tempR <= (not R_action) + 1;
process(R_action,tempR,rst)
begin
	    if rst = '1' then
		RM_DIRECTION <= '0';
		RM_SPEED <= "00000000";
	   elsif R_action(8) = '1' then
	     	RM_DIRECTION <= '0'; -- Mundur
         	RM_SPEED <= tempR (7 downto 0);
           else
         	RM_DIRECTION <= '1'; -- Maju
          	RM_SPEED <= R_action (7 downto 0);
      	 end if; 
end process;		
	
end Behavioral;
