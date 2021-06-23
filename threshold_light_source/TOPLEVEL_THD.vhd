library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOPLEVEL_THD is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           HREF : in STD_LOGIC;
           VSYNC : in  STD_LOGIC;
           Y : in STD_LOGIC_VECTOR (7 downto 0); --only in, Y from Pixel Capture
           SIZE_B : out  STD_LOGIC_VECTOR (9 downto 0);
           POS_B : out  STD_LOGIC_VECTOR (9 downto 0);
           READY : inout STD_LOGIC);
end TOPLEVEL_THD;

architecture Behavioral of TOPLEVEL_THD is

component COLUMN_COUNTER is
	Port ( CLK : in  STD_LOGIC;
           HREF : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           COUNT_COLUMN : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

component LIGHT_SIZE_COUNTER is
	Port ( Y : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           HREF : in STD_LOGIC;
           RST : in STD_LOGIC;
           YTHD : inout STD_LOGIC;
           COUNT_LIGHT_SIZE : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component FIRST_COLUMN_REGISTER1 is
	Port ( DATA : in STD_LOGIC_VECTOR (9 downto 0);
           LOAD_EN : in STD_LOGIC_VECTOR (9 downto 0);
           CLK : in STD_LOGIC;
           VSYNC : in STD_LOGIC;
           RST : in STD_LOGIC;
           F_CR1 : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component FIRST_COLUMN_REGISTER2 is
	Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           LOAD_EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           VSYNC : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           F_CR2 : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

component MAX_LIGHT_SIZE_REGISTER is
	Port ( A : in std_logic_vector(9 downto 0);
           B : in std_logic_vector(9 downto 0);
           BA  : inout std_logic;
           DATA : in STD_LOGIC_VECTOR (9 downto 0);
           CLK : in STD_LOGIC;
           VSYNC : in STD_LOGIC;
           RST : in STD_LOGIC;
           MAX_SIZE : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component READY_INDICATOR is
    Port ( R : in STD_LOGIC; --srl_rst
           S : in STD_LOGIC; --srl_set
           RST : in STD_LOGIC; --Reset System
           READY : out STD_LOGIC);--finish
end component;

component FINAL_POSITION is
    Port ( F_CR2 : in STD_LOGIC_VECTOR (9 downto 0);
           MAX_SIZE : in STD_LOGIC_VECTOR (9 downto 0);
           F_POS : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component POSITION_BUFFER is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           NOT_HREF : in STD_LOGIC;
           RST : in  STD_LOGIC;
           POS_B : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

component SIZE_BUFFER is
    Port ( DATA : in  STD_LOGIC_VECTOR (9 downto 0);
           NOT_HREF : in STD_LOGIC;
           RST : in  STD_LOGIC;
           SIZE_B : out  STD_LOGIC_VECTOR (9 downto 0));
end component;
	
signal THD : STD_LOGIC_VECTOR (9 downto 0);
signal YTHD : STD_LOGIC;
signal COUNT_COLUMN : STD_LOGIC_VECTOR (9 downto 0);
signal COUNT_LIGHT_SIZE : STD_LOGIC_VECTOR (9 downto 0);
signal F_CR1 :  STD_LOGIC_VECTOR (9 downto 0);
signal F_CR2 :  STD_LOGIC_VECTOR (9 downto 0);
signal BA : STD_LOGIC;
signal MAX_SIZE : STD_LOGIC_VECTOR (9 downto 0);
signal F_POS : STD_LOGIC_VECTOR (9 downto 0);

begin
	
	COLUMN_COUNTER2 : COLUMN_COUNTER
	port map(  
	         CLK => CLK,
             HREF => HREF,
             RST => RST,
             COUNT_COLUMN => COUNT_COLUMN);
         
	LIGHT_SIZE_COUNTER2 : LIGHT_SIZE_COUNTER
    Port map( Y => Y,
              CLK => CLK,
              HREF => HREF,
              RST => RST,
              YTHD => YTHD,
              COUNT_LIGHT_SIZE => COUNT_LIGHT_SIZE);
              
    FIRST_COLUMN_REGISTER_1 : FIRST_COLUMN_REGISTER1
    Port map( DATA => COUNT_COLUMN,
              LOAD_EN => COUNT_LIGHT_SIZE,
              CLK => CLK,
              VSYNC => VSYNC,
              RST => RST,
              F_CR1 => F_CR1); 
    
    FIRST_COLUMN_REGISTER_2 : FIRST_COLUMN_REGISTER2
    Port map( DATA => F_CR1,
              LOAD_EN  => BA,
              CLK => CLK,
              VSYNC => VSYNC,
              RST => RST,
              F_CR2 => F_CR2);                       
              
    MAX_LIGHT_SIZE_REGISTER2 : MAX_LIGHT_SIZE_REGISTER
    Port map( A => MAX_SIZE,
              B => COUNT_LIGHT_SIZE,
              BA  => BA,
              DATA => COUNT_LIGHT_SIZE,
              CLK => CLK,
              VSYNC => VSYNC,
              RST => RST,
              MAX_SIZE => MAX_SIZE);
              
    READY_INDICATOR2 : READY_INDICATOR 
    Port map( S => '0',--SET
              R => VSYNC,--RESET
              RST => RST,
              READY => READY);
              
    FINAL_POSITION2 : FINAL_POSITION
    Port map( F_CR2 => F_CR2,
              MAX_SIZE => MAX_SIZE,
              F_POS => F_POS); 
              
    POSITION_BUFFER2 : POSITION_BUFFER 
    Port map( DATA => F_POS,
              NOT_HREF => HREF,
              RST => RST,
              POS_B => POS_B);          
              
   SIZE_BUFFER2 : SIZE_BUFFER 
   Port map ( DATA => MAX_SIZE,
              NOT_HREF => HREF,
              RST => RST,
              SIZE_B => SIZE_B);
  
end Behavioral;
