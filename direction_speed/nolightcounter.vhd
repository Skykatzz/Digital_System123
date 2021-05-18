library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity nolightcounter is
Port (
	RCLK : in  STD_LOGIC; -- 10 Hz
	RST : in  STD_LOGIC; -- asynchronous reset
	STARTCOUNT : in  STD_LOGIC;
	CAHAYA : in  STD_LOGIC;
	FINISH : out STD_LOGIC);
end nolightcounter;

architecture Behavioral of nolightcounter is
	signal counting : std_logic_vector (5 downto 0);
	signal ticks: std_logic_vector(7 downto 0);
	signal stoprotate, srff_set, srff_rst: std_logic;
begin
	
	process(RCLK, RST) is -- PROCESS UNTUK MUTER DI TEMPAT
	begin
		if RST = '1' or STARTCOUNT = '0' or CAHAYA = '1' then
			counting <= "000000";
		elsif rising_edge(RCLK) and STARTCOUNT = '1' and CAHAYA = '0' then
			if counting = "110001" then -- 50 counting (0 - 49) 5 DETIK
				stoprotate <= '1';
				srff_rst <= '1';
			else
				srff_rst <= '0';
				stoprotate <= '0';
            			counting <= counting + 1;
			end if;
		end if;
   end process;
	
	process(RCLK, RST) is  -- PROCESS UNTUK DIAM DI TEMPAT
	begin
		if RST = '1' or CAHAYA = '1' or stoprotate = '0' then
			ticks <= "00000000";
		elsif CAHAYA = '0' and stoprotate = '1' and rising_edge(RCLK) then --kalo disuruh mulai oleh STR_DELAY
			if ticks = "011000100" then -- 100 tick (0 - 100)
				srff_set <= '1';
			else
				srff_set <= '0';
				ticks <= ticks + 1;
			end if;
		end if;
	end process;
	
	process(RST) -- EDGE TRIGGERED SR FLIP FLOP
	begin
		if RST = '1' then 
			FINISH <= '1';
		elsif rising_edge(srff_rst) then 
			FINISH <= '0';
		elsif rising_edge(srff_set) then
			FINISH <= '1'; 
		end if;
	end process;
	
end Behavioral;
