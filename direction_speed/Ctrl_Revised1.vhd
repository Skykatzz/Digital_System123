library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_SIGNED.all;

entity Ctrl_Revised1 is
    Port ( POSITION : in  STD_LOGIC_VECTOR (9 downto 0);
           SIZE : in  STD_LOGIC_VECTOR (9 downto 0);
           FIN_DELAY : inout  STD_LOGIC;
           CTRL_EN : in  STD_LOGIC;
           RCLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           GOAL_LEFT : out  STD_LOGIC_VECTOR (8 downto 0);
           GOAL_RIGHT : out  STD_LOGIC_VECTOR (8 downto 0);
           COUNT_EN : out  STD_LOGIC);
end Ctrl_Revised1;

architecture Control of Ctrl_Revised1 is

signal a, b: STD_LOGIC_VECTOR (9 downto 0);
signal TGL, TGR: STD_LOGIC_VECTOR (9 downto 0);
signal TTGL, TTGR: STD_LOGIC_VECTOR (9 downto 0);

begin
	process(POSITION, SIZE)
	begin
		a <= POSITION - "0101000000"; --posisi - 320 (posisi tengah)
		b <= "0101000000" - SIZE; --320 (threshold size) - size pada saat itu 
		TGL <= b - a;
		TGR <= b + a;
	end process;
	
	process(a, b, TGL) --mencegah overflow goal left
	begin
		if (a(9) = '0' and b(9) = '1' and TGL(9) = '0') then 
			TTGL <= "1000000001"; --mentok ke -511
		
		elsif (a(9) = '1' and b(9) = '0' and TGL(9) = '1') then 
			TTGL <= "0111111111"; --mentok ke 511
		else 
			TTGL <= TGL; --kalo bener, langsung
		end if; 
	end process;
	
	process(a, b, TGR) --mencegah overflow goal right
	begin
		if (a(9) = '1' and b(9) = '1' and TGR(9) = '0') then 
			TTGR <= "1000000001"; --mentok ke -511
		
		elsif (a(9) = '0' and b(9) = '0' and TGR(9) = '1') then 
			TTGR <= "0111111111"; --mentok ke 511
		else
			TTGR <= TGR; --kalo bener, langsung
		end if; 
	end process;
	
	Process(RST, RCLK)
	Begin
		if RST = '1' then --Aynchronous reset
			GOAL_LEFT <= (others => '0');
			GOAL_RIGHT <= (others => '0');
			COUNT_EN <= '0';
		
		elsif rising_edge(RCLK) then
			if FIN_DELAY = '0' then --lagi kondisi delay (berarti sebelumnya gak ada cahaya)
				if SIZE > "0000000000" then --tiba-tiba ada cahaya lebih besar dari ... saat kedelay
					FIN_DELAY <= '1';
				else --tetep belum ada cahaya
					GOAL_LEFT <= (others => '0');
					GOAL_RIGHT <= (others => '0');
				end if; 
				
			elsif FIN_DELAY = '1' AND CTRL_EN = '1' then --sedang tidak delay, kamera sudah memberi sinyal jalan 
				if SIZE = "0000000000" then --gak ada cahaya
					GOAL_LEFT <= "011111111";
					GOAL_RIGHT <= "100000001";
					COUNT_EN <= '1';
				else
					GOAL_LEFT <= TTGL (9 downto 1);
					GOAL_RIGHT <= TTGR (9 downto 1);
				end if;
				
			end if;
	
		end if;
	end Process;
	
end Control;

