library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOPLEVEL_TGD is
    Port ( 
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           HREF : in STD_LOGIC;
           VSYNC : in  STD_LOGIC;
           Y : in STD_LOGIC_VECTOR (7 downto 0);
           Size_B : out  STD_LOGIC_VECTOR (9 downto 0);
           Pos_B : out  STD_LOGIC_VECTOR (9 downto 0);
           Q : inout STD_LOGIC;
           QBAR : inout STD_LOGIC);
end TOPLEVEL_TGD;

architecture Behavioral of TOPLEVEL_TGD is

component FINAL_POSITION is
    Port ( POS : in STD_LOGIC_VECTOR (9 downto 0);
           REGMAX : in STD_LOGIC_VECTOR (9 downto 0);
           F_POS : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component Size_Buffer is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           VSYNC : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Size_B : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

component Position_Buffer is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           VSYNC : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Pos_B : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

component SR_LATCH is
    Port ( VSYNC : in STD_LOGIC;
           GND : in STD_LOGIC;
           RST : in STD_LOGIC;
           Q : inout STD_LOGIC;
           QBAR : inout STD_LOGIC);
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



signal THD1 : STD_LOGIC_VECTOR (9 downto 0);
signal COUNT_COLLUMN1 : STD_LOGIC_VECTOR (9 downto 0);
signal YTHD1 : STD_LOGIC;
signal COUNT_LEBAR1 : STD_LOGIC_VECTOR (9 downto 0);
signal BA1 : STD_LOGIC;
signal REGMAX1 : STD_LOGIC_VECTOR (9 downto 0);
signal COLLUMN_AWAL1 :  STD_LOGIC_VECTOR (9 downto 0);
signal POS1 : STD_LOGIC_VECTOR (9 downto 0);
signal F_POS1 : STD_LOGIC_VECTOR (9 downto 0);
signal GND1 : STD_LOGIC;


begin
	
	Counter_Collumn2 : Counter_Collumn
	port map(  
	         CLK => CLK,
             HREF => HREF,
             RST => RST,
             COUNT_COLLUMN => COUNT_COLLUMN1 );
         
	COUNTER_LEBAR2 : COUNTER_LEBAR 
    Port map( Y => Y,
              CLK => CLK,
              HREF => HREF,
              RST => RST,
              YTHD => YTHD1,
              COUNT_LEBAR => COUNT_LEBAR1);
              
    REGISTER_MAX2 : REGISTER_MAX
    Port map( A => REGMAX1,
              B => COUNT_LEBAR1,
              BA  => BA1,
              DATA => COUNT_LEBAR1,
              CLK => CLK,
              VSYNC => VSYNC,
              RST => RST,
              REGMAX => REGMAX1);
              
    REGISTER_COLLUMN_AWAL2 : REGISTER_COLLUMN_AWAL
    Port map( DATA => COUNT_COLLUMN1,
              LOAD_EN => COUNT_LEBAR1,
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
              POS => POS1);	
              
    FINAL_POSITION2 : FINAL_POSITION
    Port map( POS => POS1,
              REGMAX => REGMAX1,
              F_POS => F_POS1 ); 
              
   Size_Buffer2 : Size_Buffer 
   Port map ( DATA => REGMAX1,
              VSYNC => VSYNC,
              RST => RST,
              Size_B => Size_B);
               
   Position_Buffer2 : Position_Buffer 
   Port map ( DATA => F_POS1,
              VSYNC => VSYNC,
              RST => RST,
              Pos_B => Pos_B);
              
   SR_LATCH2 : SR_LATCH 
   Port map(  VSYNC => VSYNC,
              GND => GND1,
              RST => RST,
              Q => Q,
              QBAR => QBAR);
  

end Behavioral;
