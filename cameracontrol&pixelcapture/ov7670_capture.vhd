----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date  :     13:40:52 05/10/2021 
-- Design Name  :  
-- Module Name  :     ov7670capture - Behavioral 
-- Project Name :  Light Seeking Robot
-- Target Devices : 
-- Tool versions : 
-- Description  : 
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

entity ov7670capture is
Port (  pclk    : in  STD_LOGIC;
     vsync   : in  STD_LOGIC;
     href    : in  STD_LOGIC;
     data_In : in  STD_LOGIC_VECTOR (7 downto 0);
     RST    : in STD_LOGIC;
 2clk  : out STD_LOGIC;
     PixelOut: out STD_LOGIC_VECTOR (7 downto 0)
    );
     
end ov7670capture;

architecture Behavioral of ov7670capture is
 signal dataY   : std_logic_vector (7 downto 0) := (others => '0');
 signal Q : std_logic := '0';
begin
 PixelOut <= dataY;
 2clk <= Q;
process(pclk) 
begin
 if RST = '1' then
  Q <= '0';
 else
  if rising_edge(pclk) then
   Q <= not Q;
  end if;
 end if;
end process;

process (pclk,vsync,href,RST,Q) 
 begin
   if RST = '1' then
      dataY <= (others => '0');
   else 
     if rising_edge(pclk)then
       if vsync = '1' then
         dataY <= (others => '0');
       else   
         if href = '1' then
           if rising_edge(Q) then 
             dataY <= data_In;     
           end if;
         end if; 
       end if;
     end if;
   end if;
end process;
end behavioral;