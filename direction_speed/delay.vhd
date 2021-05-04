library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity delay is
port(
    RCLK          : in std_logic;
    timerreset    : inout std_logic;
    startdelay    : in std_logic; -- dari Q pada SRFFdelay
	 RST				: in std_logic;
    finishdelay   : out std_logic);
end entity;

architecture Behavioral of delay is
    signal ticks: integer;
    signal seconds: integer;
begin
    process(clk, RST) is
    begin
	 if RST = '1' then
		  ticks <= 0;
        seconds <= 0;		  
    elsif startdelay = '1' then --kalo disuruh mulai oleh SRFFdelay
        if timerreset = '1' then --kalo direset
            ticks <= 0;
            seconds <= 0;
        elsif rising_edge(RCLK) then
            if ticks = 25000000 - 1 then --tunggu sampai 25.000.000 tick - 1 (1 detik) (tergantung RCLK berapa Hz)
                if seconds = 30 then --30 detik delay
                    seconds <= 0;
                    finishdelay <= '1';
						        timerreset <= '1';
                else
                    finishdelay <= '0';
						        seconds <= seconds + 1;
                end if;
                ticks <= 0;
            else
                ticks <= ticks + 1; -- setiap rising edge clock akan tambah 1
            end if;
        end if; 
    end if;
    end process;

end Behavioral;
