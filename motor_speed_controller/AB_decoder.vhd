library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ab_decoder is
    Port ( CLOCK : in  STD_LOGIC;
           A1 : in  STD_LOGIC;
           B1 : in  STD_LOGIC;
           A2 : in  STD_LOGIC;
           B2 : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Up_en1 : out  STD_LOGIC;
           Dwn_en1 : out  STD_LOGIC;
           Up_en2 : out  STD_LOGIC;
           Dwn_en2 : out  STD_LOGIC);
end ab_decoder;

architecture Behavioral of Control_Unit is

type state_type is( S00, S01, S10, S11,V00,V01,V10,V11);
signal A1B1: std_logic_vector(1 downto 0);
signal present_state1, next_state1: state_type1;
signal present_state2, next_state2: state_type2;



begin
-----ENCODER_KIRI	
	A1B1 <= A1 & B1 ;--GABUNGKAN A DAN B DALAM 1 BUS
-- memory element
process(RST, CLOCK)--SENSITIVITY LIST 
begin

   if RST = '1' then 
		case A1B1 is 
			when "00" => present_state <=  S00;
			when "01" => present_state <=  S01;
			when "11" => present_state <=  S11;
			when others => present_state <= S10; -- AB ="10"
		end case;
	elsif rising_Edge(CLOCK) then
		present_state1 <= next_state1;
		
	end if;
end process;

-- combinational circuit

process(present_state1,A1,B1)
begin
	case present_state is 
		when S00 => 
				if A1 = '1' then
				    next_state1 <= S10;
					 Up_en1 <= '1';
					 Dwn_en1 <= '0';
				elsif B1 = '1' then 
					 next_state1 <= S01;
					 Up_en1 <= '0';
					 Dwn_en1 <= '1';
				else 
					 next_state1 <= S00;
					 Up_en1 <= '0';
					 Dwn_en1 <= '0';
				end if;
		when S01 => 
				if A1 = '1' then
				    next_state1 <= S00;
					 Up_en1 <= '1';
					 Dwn_en1 <= '0';
				elsif B1 = '1' then 
					 next_state1 <= S11;
					 Up_en1 <= '0';
					 Dwn_en1 <= '1';
				else 
					 next_state1 <= S00;
					 Up_en1 <= '0';
					 Dwn_en1 <= '0';
				end if;
		when S11 => 
				if A1 = '1' then
				    next_state1 <= S01;
					 Up_en1 <= '1';
					 Dwn_en1 <= '0';
				elsif B1 = '1' then 
					 next_state1 <= S10;
					 Up_en1 <= '0';
					 Dwn_en1 <= '1';
				else 
					 next_state1 <= S00;
					 Up_en1 <= '0';
					 Dwn_en1 <= '0';
				end if;
		when others =>
				if A1 = '1' then
				    next_state1 <= S11;
					 Up_en1 <= '1';
					 Dwn_en1 <= '0';
				elsif B1 = '1' then 
					 next_state1 <= S00;
					 Up_en1 <= '0';
					 Dwn_en1 <= '1';
				else 
					 next_state1 <= S00;
					 Up_en1 <= '0';
					 Dwn_en1 <= '0';
				end if;
				end case;
			
end process;

--ENCODER KANAN
process(present_state2,A2,B2)
begin
	case present_state is 
		when V00 => 
				if A2 = '1' then
				    next_state2 <= V10;
					 Up_en2 <= '1';
					 Dwn_en2 <= '0';
				elsif B2 = '1' then 
					 next_state2 <= V01;
					 Up_en2 <= '0';
					 Dwn_en2 <= '1';
				else 
					 next_state2 <= V00;
					 Up_en2 <= '0';
					 Dwn_en2 <= '0';
				end if;
		when V01 => 
				if A2 = '1' then
				    next_state2 <= V00;
					 Up_en2 <= '1';
					 Dwn_en2 <= '0';
				elsif B2 = '1' then 
					 next_state2 <= V11;
					 Up_en2 <= '0';
					 Dwn_en2 <= '1';
				else 
					 next_state2 <= V00;
					 Up_en2 <= '0';
					 Dwn_en2 <= '0';
				end if;
		when V11 => 
				if A2 = '1' then
				    next_state2 <= V01;
					 Up_en2 <= '1';
					 Dwn_en2 <= '0';
				elsif B2 = '1' then 
					 next_state2 <= V10;
					 Up_en2 <= '0';
					 Dwn_en2 <= '1';
				else 
					 next_state2 <= V00;
					 Up_en2 <= '0';
					 Dwn_en2 <= '0';
				end if;
		when others =>
				if A2 = '1' then
				    next_state2 <= V11;
					 Up_en2 <= '1';
					 Dwn_en2 <= '0';
				elsif B2 = '1' then 
					 next_state2 <= V00;
					 Up_en2 <= '0';
					 Dwn_en2 <= '1';
				else 
					 next_state2 <= V00;
					 Up_en2 <= '0';
					 Dwn_en2 <= '0';
				end if;
				end case;
			
end process;



end Behavioral;

