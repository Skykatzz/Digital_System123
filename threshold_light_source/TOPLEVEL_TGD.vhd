library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOPLEVEL_TGD is
    Port ( 
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           HREF : in STD_LOGIC;
           VSYNC : in  STD_LOGIC;
           Y : in STD_LOGIC_VECTOR (9 downto 0);
           POS : out  STD_LOGIC_VECTOR (9 downto 0);
           REGMAX : out STD_LOGIC_VECTOR (9 downto 0));
end TOPLEVEL_TGD;

architecture Behavioral of TOPLEVEL_TGD is

component Register_Final is
	Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           LOAD_EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           VSYNC : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           POS : out  STD_LOGIC_VECTOR (9 downto 0));
end component;
	
component REGISTER_MAX is
	Port ( A : in STD_LOGIC_VECTOR(9 downto 0);
           B : in STD_LOGIC_VECTOR(9 downto 0);
           BA  : out STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (9 downto 0);
           LOAD_EN : in STD_LOGIC;
           CLK : in STD_LOGIC;
           VSYNC : in STD_LOGIC;
           RST : in STD_LOGIC;
           REGMAX : out STD_LOGIC_VECTOR (9 downto 0));
end component;
	
component REGISTER_COLLUMN_AWAL is
	Port ( DATA : in STD_LOGIC_VECTOR (9 downto 0);
           LOAD_EN : in STD_LOGIC_VECTOR (1 downto 0);
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
	Port ( CLK : in STD_LOGIC;
           HREF : in STD_LOGIC;
           LIGHT_SRC : in STD_LOGIC;
           RST : in STD_LOGIC;
           COUNT_LEBAR : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component COMPARATOR is
	Port ( Y : in STD_LOGIC_VECTOR (9 downto 0);
           THD : in STD_LOGIC_VECTOR (9 downto 0);
           YTHD : out STD_LOGIC);
end component;

signal COUNT_COLLUMN1 : STD_LOGIC_VECTOR (9 downto 0);
signal COUNT_COLLUMN2 : STD_LOGIC_VECTOR (9 downto 0);
signal YTHD1 : STD_LOGIC;
signal YTHD2 : STD_LOGIC;
signal COUNT_LEBAR1 : STD_LOGIC_VECTOR (9 downto 0);
signal COUNT_LEBAR2 : STD_LOGIC_VECTOR (9 downto 0);
signal REGMAX1 : STD_LOGIC_VECTOR (9 downto 0);
signal REGMAX2 : STD_LOGIC_VECTOR (9 downto 0);
signal BA1 : STD_LOGIC;
signal BA2 : STD_LOGIC;
signal COLLUMN_AWAL1 :  STD_LOGIC_VECTOR (9 downto 0);
signal COLLUMN_AWAL2 :  STD_LOGIC_VECTOR (9 downto 0);
signal THD1 : STD_LOGIC_VECTOR (9 downto 0);

begin
	
	Counter_Collumn2 : Counter_Collumn
	port map(  
	           CLK => CLK,
               HREF => HREF,
               RST => RST,
               COUNT_COLLUMN => COUNT_COLLUMN1 );
	COMPARATOR2 : COMPARATOR
	Port map( Y => Y,
              THD => THD1,
              YTHD => YTHD1 );	
	COUNTER_LEBAR2 : COUNTER_LEBAR 
    Port map( CLK => CLK,
              HREF => HREF,
              LIGHT_SRC => YTHD1 ,
              RST => RST,
              COUNT_LEBAR => COUNT_LEBAR1);
    REGISTER_MAX2 : REGISTER_MAX
    Port map( A => REGMAX1,
              B => COUNT_LEBAR1,
              BA  => BA1,
              DATA => COUNT_LEBAR1,
              LOAD_EN => BA1,
              CLK => CLK,
              VSYNC => VSYNC,
              RST => RST,
              REGMAX => REGMAX1);
    REGISTER_COLLUMN_AWAL2 : REGISTER_COLLUMN_AWAL
    Port map( DATA => COUNT_COLLUMN1,
              LOAD_EN => COUNT_LEBAR1 (1 downto 0),
              CLK => CLK,
              VSYNC => VSYNC,
              RST => RST,
              COLLUMN_AWAL => COLLUMN_AWAL1);
    Register_Final2 : Register_Final
    Port map( DATA => COLLUMN_AWAL1,
              LOAD_EN  => BA1,
              CLK => CLK,
              VSYNC => VSYNC,
              RST => RST,
              POS => POS);	
              
   COUNT_COLLUMN2 <= COUNT_COLLUMN1 ;
   YTHD2 <= YTHD1 ;
   COUNT_LEBAR2 <= COUNT_LEBAR1 ;
   REGMAX2 <= REGMAX1 ;
   BA2 <= BA1 ;
   COLLUMN_AWAL2 <= COLLUMN_AWAL1 ;
    
end Behavioral;
