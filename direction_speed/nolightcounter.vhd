library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity nolightcounter is
Port (
	RCLK : in  STD_LOGIC; -- 10 Hz
	RST : in  STD_LOGIC; -- asynchronous reset
	NLC_EN : in  STD_LOGIC; -- enable dari thresholding
	CAHAYA : in  STD_LOGIC; -- ada tidaknya cahaya
	FINISH : out STD_LOGIC); -- menunjukkan sudah selesai muter/diam di tempat
end nolightcounter;

architecture Behavioral of nolightcounter is
	signal ticks: std_logic_vector(7 downto 0);
	signal srl_set, srl_rst: std_logic;
begin

	process(RCLK, RST, NLC_EN, CAHAYA) is  -- PROCESS UNTUK MUTER/DIAM DI TEMPAT
	begin
		if RST = '1' or NLC_EN = '0' or CAHAYA = '1' then -- jika belum enable, atau ada cahaya
			ticks <= "00000000";
		elsif rising_edge(RCLK) and NLC_EN = '1' and CAHAYA = '0' then -- jika sudah enable dan tidak ada cahaya
			if ticks = "00110001" then -- 50 tick (0 - 49)
				srl_rst <= '1'; -- FINISH = 0 -> NEXT DIAM DI TEMPAT
			elsif ticks = "10010101" then -- 100 tick (50 - 149)
				srl_set <= '1' ; -- FINISH = 1 -> NEXT MUTER DI TEMPAT
			   ticks <= "00000000";
			else
    		   srl_rst <= '0';
				srl_set <= '0';
				ticks <= ticks + 1;
			end if;
		end if;
	end process;
	
	process(RST, srl_set, srl_rst) -- SR LATCH
	begin
		if RST = '1' or srl_set = '1' then 
			FINISH <= '1'; -- DEFAULT 1
		elsif srl_rst = '1' then 
			FINISH <= '0';
		end if;
	end process;
	
end Behavioral;
