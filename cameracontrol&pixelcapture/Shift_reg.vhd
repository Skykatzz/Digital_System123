library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Shift_reg is
    Port ( Data : in  STD_LOGIC_VECTOR (27 downto 0);
           LOAD_EN : in  STD_LOGIC;
           SHIFT_EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Siod : out  STD_LOGIC);
end Shift_reg;

architecture Behavioral of Shift_reg is
signal reg: std_logic_vector(27 downto 0);

begin
	process(RST, CLK)
		begin 
			if RST = '1' then
				reg <= (others => '0'); 
			elsif rising_edge(clk) then	
				if LOAD_EN  = '1' then 
					reg <= DATA; 
				elsif SHIFT_EN ='1' then
					reg <= reg(26 downto 0) & '1';
					end if;
			end if;
	end process;

	siod <= reg(27);

end Behavioral;
