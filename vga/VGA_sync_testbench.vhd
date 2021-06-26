library ieee;
use ieee.std_logic_1164.all;

entity VGA_sync_tstbench is
end entity;

architecture behavior of VGA_sync_tstbench is
    signal clk:     std_logic := '0';
    signal pclk:     std_logic := '0';
	signal rst:     std_logic := '0';
    signal h_sync:  std_logic;
    signal v_sync:  std_logic;
    signal VGA_Red:     std_logic_vector (3 downto 0);
    signal VGA_Green:   std_logic_vector (3 downto 0);
    signal VGABlue:    std_logic_vector (3 downto 0);    
component VGA_sync is
    port (
        clk: in  std_logic;    
        pclk: in  std_logic;
        rst: in  STD_LOGIC;
        VGA_Red: out std_logic_vector(3 downto 0);
        VGA_Green: out std_logic_vector(3 downto 0);
        VGA_Blue: out std_logic_vector(3 downto 0);
        h_sync, v_sync: out std_logic );
end component ;

begin
DUT:
    VGA_sync port map (
            VGA_clk => VGA_clk,
			rst => rst,
            h_sync => h_sync,
            v_sync => v_sync,
            VGA_Red => VGA_Red,
            VGA_Green => VGA_Green,
            VGA_Blue => VGA_Blue
        );
CLOCK:
    process
    begin
        wait for 20 ns;  -- clock period 25 MHz = 40 ns;
        clk <= not clk;
            --wait for 20 ns;  -- one frame time plus a bit
    end process;
RESET:
    process
    begin
        rst <= '1';
        wait for 20 ns;  -- clock period 25 MHz = 40 ns;
        rst <= '0';
        wait;
    end process;
end architecture behavior;
