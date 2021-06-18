----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.05.2021 21:05:09
-- Design Name: 
-- Module Name: TOPLEVEL_TGD - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

entity TOPLEVEL_THD is
    Port ( 
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           HREF : in STD_LOGIC;
           VSYNC : in  STD_LOGIC;
           Y : in STD_LOGIC_VECTOR (7 downto 0); --only in, Y from Pixel Capture
           Size_B : out  STD_LOGIC_VECTOR (9 downto 0);
           Pos_B : out  STD_LOGIC_VECTOR (9 downto 0);
           Q : inout STD_LOGIC;
           READY : inout STD_LOGIC);
end TOPLEVEL_THD;

architecture Behavioral of TOPLEVEL_THD is

component FINAL_POSITION is
    Port ( POS : in STD_LOGIC_VECTOR (9 downto 0);
           REGMAX : in STD_LOGIC_VECTOR (9 downto 0);
           F_POS : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component Size_Buffer is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           NOT_CLK : in STD_LOGIC;
           VSYNC : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Size_B : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

component Position_Buffer is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           NOT_CLK : in STD_LOGIC;
           VSYNC : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Pos_B : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

component SR_LATCH is
    Port ( VSYNC : in STD_LOGIC; --Reset
           SET : in STD_LOGIC;
           RST : in STD_LOGIC; --Reset System
           Q : inout STD_LOGIC;
           READY : inout STD_LOGIC);
end component;

component Register_Final is
	Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           LOAD_EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           VSYNC : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           POS : out  STD_LOGIC_VECTOR (9 downto 0));
end component;
	
component REGISTER_MAX is
	Port ( A : in std_logic_vector(9 downto 0);
           B : in std_logic_vector(9 downto 0);
           BA  : inout std_logic;
           DATA : in STD_LOGIC_VECTOR (9 downto 0);
           CLK : in STD_LOGIC;
           VSYNC : in STD_LOGIC;
           RST : in STD_LOGIC;
           REGMAX : out STD_LOGIC_VECTOR (9 downto 0));
end component;
	
component REGISTER_COLLUMN_AWAL is
	Port ( DATA : in STD_LOGIC_VECTOR (9 downto 0);
           LOAD_EN : in STD_LOGIC_VECTOR (9 downto 0);
           CLK : in STD_LOGIC;
           VSYNC : in STD_LOGIC;
           RST : in STD_LOGIC;
           COLLUMN_AWAL : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component Counter_Collumn is
	Port ( CLK : in  STD_LOGIC;
           HREF : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           COUNT_COLLUMN : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

component COUNTER_LEBAR is
	Port ( Y : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           HREF : in STD_LOGIC;
           RST : in STD_LOGIC;
           YTHD : inout STD_LOGIC;
           COUNT_LEBAR : out STD_LOGIC_VECTOR (9 downto 0));
end component;

signal THD : STD_LOGIC_VECTOR (9 downto 0);
signal COUNT_COLLUMN : STD_LOGIC_VECTOR (9 downto 0);
signal YTHD : STD_LOGIC;
signal COUNT_LEBAR : STD_LOGIC_VECTOR (9 downto 0);
signal BA : STD_LOGIC;
signal REGMAX : STD_LOGIC_VECTOR (9 downto 0);
signal COLLUMN_AWAL :  STD_LOGIC_VECTOR (9 downto 0);
signal POS : STD_LOGIC_VECTOR (9 downto 0);
signal F_POS : STD_LOGIC_VECTOR (9 downto 0);

begin
	
	Counter_Collumn2 : Counter_Collumn
	port map(  
	         CLK => CLK,
             HREF => HREF,
             RST => RST,
             COUNT_COLLUMN => COUNT_COLLUMN);
         
	COUNTER_LEBAR2 : COUNTER_LEBAR 
    Port map( Y => Y,
              CLK => CLK,
              HREF => HREF,
              RST => RST,
              YTHD => YTHD,
              COUNT_LEBAR => COUNT_LEBAR);
              
    REGISTER_MAX2 : REGISTER_MAX
    Port map( A => REGMAX,
              B => COUNT_LEBAR,
              BA  => BA,
              DATA => COUNT_LEBAR,
              CLK => CLK,
              VSYNC => VSYNC,
              RST => RST,
              REGMAX => REGMAX);
              
    REGISTER_COLLUMN_AWAL2 : REGISTER_COLLUMN_AWAL
    Port map( DATA => COUNT_COLLUMN,
              LOAD_EN => COUNT_LEBAR,
              CLK => CLK,
              VSYNC => VSYNC,
              RST => RST,
              COLLUMN_AWAL => COLLUMN_AWAL);
              
    Register_Final2 : Register_Final
    Port map( DATA => COLLUMN_AWAL,
              LOAD_EN  => BA,
              CLK => CLK,
              VSYNC => VSYNC,
              RST => RST,
              POS => POS);	
              
    FINAL_POSITION2 : FINAL_POSITION
    Port map( POS => POS,
              REGMAX => REGMAX,
              F_POS => F_POS); 
              
   Size_Buffer2 : Size_Buffer 
   Port map ( DATA => REGMAX,
              VSYNC => VSYNC,
              NOT_CLK => HREF,
              RST => RST,
              Size_B => Size_B);
               
   Position_Buffer2 : Position_Buffer 
   Port map ( DATA => F_POS,
              VSYNC => VSYNC,
              NOT_CLK => HREF,
              RST => RST,
              Pos_B => Pos_B);
              
   SR_LATCH2 : SR_LATCH 
   Port map(  VSYNC => VSYNC,
              SET => '0', 
              RST => RST,
              Q => Q,
              READY => READY);
  

end Behavioral;
