library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity nolightcounter is
Port (
	VSYNC : in  STD_LOGIC; -- 62.5 Hz
	RST : in  STD_LOGIC; -- asynchronous reset
	NLC_EN : in  STD_LOGIC; -- enable dari thresholding
	CAHAYA : in  STD_LOGIC; -- ada tidaknya cahaya
	FINISH : out STD_LOGIC); -- menunjukkan sudah selesai muter/diam di tempat
end nolightcounter;

architecture Behavioral of nolightcounter is
	signal ticks: std_logic_vector(9 downto 0);
	signal srl_set, srl_rst: std_logic;
begin

	process(VSYNC, RST, NLC_EN, CAHAYA) is  -- PROCESS UNTUK COUNTING
	begin
		if RST = '1' or NLC_EN = '0' or CAHAYA = '1' then -- jika direset, belum enable, atau terdapat cahaya
			ticks <= "0000000000";
			srl_rst <= '0';
			srl_set <= '0';
		elsif rising_edge(VSYNC)and NLC_EN = '1' and CAHAYA = '0' and RST = '0' then
			if ticks = "0100111001" then -- 5 detik (0 - 313)
				srl_rst <= '1'; -- FINISH = 0 -> NEXT DIAM DI TEMPAT
				ticks <= ticks + 1;
			elsif ticks = "1110101010" then -- 10 detik (314 - 938)
				srl_set <= '1' ; -- FINISH = 1 -> NEXT MUTER DI TEMPAT
			   	ticks <= "0000000000";
			else
	    		   	srl_rst <= '0';
				srl_set <= '0';
				ticks <= ticks + 1;
			end if;
		end if;
	end process;
	
	process( rst,srl_set, srl_rst, CAHAYA) -- SR LATCH
	begin
		if falling_edge(rst) or srl_set = '1' or CAHAYA = '1' then 
			FINISH <= '1'; -- DEFAULT 1, muter
		elsif rst = '1' and srl_rst = '1' then 
			FINISH <= '0'; -- diam di tempat
		end if;
	end process;
	
end Behavioral;
