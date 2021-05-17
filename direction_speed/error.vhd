library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity error is
    Port ( L_GOAL : in  STD_LOGIC_VECTOR (8 downto 0);
           L_FEEDBACK : in  STD_LOGIC_VECTOR (8 downto 0);
           L_action : out  STD_LOGIC_VECTOR (8 downto 0);
           R_GOAL : in  STD_LOGIC_VECTOR (8 downto 0);
           R_FEEDBACK : in  STD_LOGIC_VECTOR (8 downto 0);
           R_action : out  STD_LOGIC_VECTOR (8 downto 0);
           
end error;

architecture Behavioral of error is


signal L_temp_action: std_logic_vector (8 downto 0);
signal R_temp_action: std_logic_vector (8 downto 0);

begin
    process(L_GOAL,L_FEEDBACK,L_IN_ACTION)
    begin
        L_temp_action <= L_GOAL - L_FEEDBACK; 
        if (L_GOAL(8) = 1 and L_FEEDBACK(8) = 0 and L_temp_action(8) = 0) then
            L_action <= "100000001"; -- -255
        elsif(L_GOAL(8) = 0 and L_FEEDBACK(8) = 1 and L_temp_action(8) = 1) then
            L_action <= "011111111"; -- +255
        else
            L_action <= L_temp_action;
        end if;    
    end process;
    
    
    process(R_GOAL,R_FEEDBACK,R_IN_ACTION)
    begin
        R_temp_action <= R_GOAL - R_FEEDBACK; 
        if (R_GOAL(8) = 1 and R_FEEDBACK(8) = 0 and R_temp_action(8) = 0) then
            R_action <= "100000001"; -- -255
        elsif(R_GOAL(8) = 0 and R_FEEDBACK(8) = 1 and R_temp_action(8) = 1) then
            R_action <= "011111111"; -- +255
        else
            R_action <= R_temp_action;
        end if;    
    end process;
    
   
end Behavioral;
