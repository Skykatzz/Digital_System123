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
           LM_SPEED : out std_logic_vector (7 downto 0)
);
              end S2US;

architecture Behavioral of S2US is
            
                signal tempL : std_logic_vector(8 downto 0);
                signal tempR : std_logic_vector(8 downto 0);


begin
process(L_action)
begin
	    if L_action(8) = '1' then
		LM_DIRECTION <= '1'; -- Mundur
                tempL <= (not L_action) + 1; -- 9 bit
                LM_SPEED <= tempL (7 downto 0); -- cara biar jadi 8 bit
            elsif L_action(8) = '0' then --0 1011 1111
                LM_DIRECTION <= '0'; -- Maju
                LM_SPEED <= L_action (7 downto 0);  --ambil bit ke 7 to 0
             end if; 
end process;
	
process(R_action)
begin
	    if R_action(8) = '1' then
	       RM_DIRECTION <= '0'; -- Mundur
               tempR <= (not R_action) + 1;
               RM_SPEED <= tempR (7 downto 0);
           elsif R_action(8) = '0' then --0 1011 1111
               RM_DIRECTION <= '1'; -- Maju
               RM_SPEED <= R_action (7 downto 0);
          end if; 
end process;		
	
end Behavioral;
