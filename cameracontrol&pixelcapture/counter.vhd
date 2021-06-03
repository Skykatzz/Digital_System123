----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:40:13 04/23/2021 
-- Design Name: 
-- Module Name:    counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           COUNT_EN : in  STD_LOGIC;
			  stop_cond : out STD_LOGIC
			  );
end counter;

architecture Behavioral of counter is
signal countIn: STD_LOGIC_VECTOR (4 downto 0); 
begin
	process(RST, CLK)
	begin
			if RST ='1' then
				countIn <= (others => '0');
			elsif rising_edge(clk) then
				if countIn = "11011" then
					CountIn <= (others => '0');
					stop_cond <= '1'; 
				elsif COUNT_EN = '1' then 
					CountIn <= CountIn + 1;
					stop_cond <= '0'; 
				end if;
			
		end if;
	
	end process;

	
end Behavioral;

