library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity master_top is --yg nyambung ke port luar board
Port (	
	RST : in  STD_LOGIC
);
end master_top;

architecture Behavioral of master_top is -- top level masing-masing kelompok:

-- KELOMPOK DECIDE SPEED AND DIRECTION :
component TOPLEVELSPEEDNDIR is
Port (  -- FROM THRESHOLDING:
	POSITION : in  STD_LOGIC_VECTOR (9 downto 0);
	SIZE : in  STD_LOGIC_VECTOR (9 downto 0);
	CTRL_EN : in  STD_LOGIC;
	-- FROM MEASUREMENT:
	RMF_DIRECTION : in std_logic ;
	RMF_SPEED : in std_logic_vector (7 downto 0);
	LMF_DIRECTION : in std_logic ;
	LMF_SPEED : in std_logic_vector (7 downto 0);
	-- FROM CAMERA:
	VSYNC : in  STD_LOGIC; -- 62.5 Hz
	-- RESET:
	RST : in  STD_LOGIC;
	-- TO PWM:
        RM_DIRECTION : out std_logic ;
        RM_SPEED : out std_logic_vector (7 downto 0);
        LM_DIRECTION : out std_logic ;
        LM_SPEED : out std_logic_vector (7 downto 0));
end component;

-- KELOMPOK LIGHT SOURCE DETECTION & THRESHOLDING :	
component TOPLEVEL_TGD is 
Port (  -- FROM PIXEL CAPTURE or PIXEL CAPTURE:
	CLK : in  STD_LOGIC;
        HREF : in STD_LOGIC;
        VSYNC : in  STD_LOGIC; -- 62.5 Hz
        Y : in STD_LOGIC_VECTOR (7 downto 0);
	-- RESET:
	RST : in  STD_LOGIC;
	-- TO DECIDE SPEED AND DIRECTION :
        Size_B : out  STD_LOGIC_VECTOR (9 downto 0);
        Pos_B : out  STD_LOGIC_VECTOR (9 downto 0);
        Q : inout STD_LOGIC;
        QBAR : inout STD_LOGIC);
end component;
	

-- tulis top level masing-masing kelompok di sini:
-- component xxx is
-- Port ( );
-- end component;


-- ------------SIGNALS--------------

	
--between thresholding and speedndir:
signal Pos_B, Size_B : STD_LOGIC_VECTOR (9 downto 0);
signal QBAR : std_logic; -- ini apa ya?

-- between measurement and speedndir:
signal RMF_DIRECTION, LMF_DIRECTION : std_logic;
signal RMF_SPEED, LMF_SPEED : std_logic_vector (7 downto 0);

-- between PWM_generator and speedndir:
signal RM_DIRECTION, LM_DIRECTION : std_logic;
signal RM_SPEED, LM_SPEED : std_logic_vector (7 downto 0);

-- from camera:
signal VSYNC:  STD_LOGIC;

begin

TLSND : TOPLEVELSPEEDNDIR
port map(
	-- FROM THRESHOLDING:
	POSITION => Pos_B,
	SIZE => Size_B,
	CTRL_EN => CTRL_EN, -- ini ke mana?
	-- FROM MEASUREMENT
	RMF_DIRECTION => RMF_DIRECTION,
	RMF_SPEED => RMF_SPEED,
	LMF_DIRECTION => LMF_DIRECTION,
	LMF_SPEED => LMF_SPEED,
	VSYNC => VSYNC,
	-- RESET:
	RST => RST,
	-- TO PWM:
	RM_DIRECTION => RM_DIRECTION,
	RM_SPEED => RM_SPEED,
	LM_DIRECTION => LM_DIRECTION,
	LM_SPEED => LM_SPEED
);
	
	
TLTHD : TOPLEVEL_TGD
port map(	
	-- FROM PIXEL CAPTURE or PIXEL CAPTURE:
	CLK => CLK,
        HREF => HREF,
        VSYNC => VSYNC, -- 62.5 Hz
        Y => Y,
	-- RESET:
	RST => RST,
	-- TO DECIDE SPEED AND DIRECTION :
        Size_B => Size_B,
        Pos_B => Pos_B,
        Q => Q,
        QBAR => QBAR
);
	
-- tulis port map masing-masing kelompok di sini:
-- bebas : (nama file top level kalian)
-- port map( );


end Behavioral;

