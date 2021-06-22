----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ov7670_capture is
Port (  pclk    : in  STD_LOGIC;
     vsync   : in  STD_LOGIC;
     href    : in  STD_LOGIC;
     data_In : in  STD_LOGIC_VECTOR (7 downto 0);
     RST    : in STD_LOGIC;
     halfclk  : out STD_LOGIC;
    
     PixelOut: out STD_LOGIC_VECTOR (7 downto 0)
    );
     
end ov7670_capture;

architecture Behavioral of ov7670_capture is
 signal dataY   : std_logic_vector (7 downto 0) := (others => '0');
 signal Q : std_logic := '0';
begin
 PixelOut <= dataY;
 halfclk <= Q;
process(pclk,rst) 
begin
 if RST = '1' then
  Q <= '0';
 else
  if rising_edge(pclk) then
   Q <= not Q;
  
  end if;
 end if;
end process;

process (pclk,RST) 
 begin
   if RST = '1' then
      dataY <= (others => '0');
   elsif rising_edge(pclk) then
     
       if vsync = '0' then
         if  href = '1' and q = '1' then 
        
             dataY <= data_In;     
        
            end if;
        end if;
     end if;
   
end process;
end behavioral;
