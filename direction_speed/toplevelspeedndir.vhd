library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOPLEVELSPEEDNDIR is
Port (  -- FROM THRESHOLDING:
	POSITION : in  STD_LOGIC_VECTOR (9 downto 0);
	SIZE : in  STD_LOGIC_VECTOR (9 downto 0);
	READY : in  STD_LOGIC;
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
    LM_SPEED : out std_logic_vector (7 downto 0)); -- asynchronous reset 
end TOPLEVELSPEEDNDIR;

architecture Behavioral of TOPLEVELSPEEDNDIR is

component Ctrl is
 Port ( POSITION : in  STD_LOGIC_VECTOR (9 downto 0);
	SIZE : in  STD_LOGIC_VECTOR (9 downto 0);
	ROTATE : in  STD_LOGIC;
	CTRL_EN : in  STD_LOGIC;
	GOAL_LEFT : out  STD_LOGIC_VECTOR (8 downto 0);
	GOAL_RIGHT : out  STD_LOGIC_VECTOR (8 downto 0));
end component;

component S2US is
 port ( --Inputs DARI NICO
        L_action : in  STD_LOGIC_VECTOR (8 downto 0); -- 9 bit
        R_action : in  STD_LOGIC_VECTOR (8 downto 0);
        --Outputs
        RM_DIRECTION : out std_logic ;
        RM_SPEED : out std_logic_vector (7 downto 0);
        LM_DIRECTION : out std_logic ;
        LM_SPEED : out std_logic_vector (7 downto 0));
end component;

component US2S is
port ( --Inputs
	RMF_DIRECTION : in std_logic ;
	RMF_SPEED : in std_logic_vector (7 downto 0);
	LMF_DIRECTION : in std_logic ;
	LMF_SPEED : in std_logic_vector (7 downto 0);
	--Outputs
	L_Feedback : out std_logic_vector (8 downto 0);
	R_Feedback : out std_logic_vector (8 downto 0));
end component;

component error is
Port ( L_GOAL : in  STD_LOGIC_VECTOR (8 downto 0);-- 
       L_FEEDBACK : in  STD_LOGIC_VECTOR (8 downto 0);
       L_action : out  STD_LOGIC_VECTOR (8 downto 0);
	   R_GOAL : in  STD_LOGIC_VECTOR (8 downto 0);-- 
       R_FEEDBACK : in  STD_LOGIC_VECTOR (8 downto 0);
	   R_action : out  STD_LOGIC_VECTOR (8 downto 0));
end component;

component nolightcounter is
Port (
	CLK : in  STD_LOGIC; -- 62.5 Hz
	RST : in  STD_LOGIC; -- asynchronous reset
	NLC_EN : in  STD_LOGIC; -- enable dari thresholding
	CAHAYA : in  STD_LOGIC_VECTOR(9 DOWNTO 0); -- ada tidaknya cahaya
	ROTATE : out STD_LOGIC); -- menunjukkan sudah selesai muter/diam di tempat
end component;

signal ROTATE : STD_LOGIC;
signal GOAL_LEFT : STD_LOGIC_VECTOR (8 downto 0); -- 9 bit signed
signal GOAL_RIGHT : STD_LOGIC_VECTOR (8 downto 0); -- 9 bit signed
signal L_action : STD_LOGIC_VECTOR (8 downto 0); -- 9 bit signed
signal R_action : STD_LOGIC_VECTOR (8 downto 0); -- 9 bit signed
signal L_Feedback : std_logic_vector (8 downto 0); -- 9 bit signed
signal R_Feedback : std_logic_vector (8 downto 0); -- 9 bit signed

begin

datapath_error : error
	port map(L_GOAL => GOAL_LEFT,
		R_GOAL => GOAL_RIGHT,
		L_FEEDBACK => L_Feedback,
		R_FEEDBACK => R_Feedback,
		L_action => L_action,
		R_action => R_action);
				
datapath_S2US : S2US
	port map(L_action => L_action,
		R_action => R_action,
		RM_DIRECTION => RM_DIRECTION,
		RM_SPEED => RM_SPEED,
		LM_DIRECTION => LM_DIRECTION,
		LM_SPEED => LM_SPEED);
				
datapath_Ctrl : Ctrl
	port map(POSITION => POSITION,
		SIZE => SIZE,
		CTRL_EN  => READY,
		ROTATE => ROTATE,
		GOAL_LEFT => GOAL_LEFT,
		GOAL_RIGHT => GOAL_RIGHT);

datapath_nolightcounter : nolightcounter
	port map(CAHAYA => SIZE,
		ROTATE => ROTATE,
		CLK => VSYNC,
		RST => RST,
		NLC_EN => READY);
				
datapath_US2S : US2S
	port map(R_Feedback => R_FEEDBACK,
		L_Feedback => L_FEEDBACK,
		RMF_DIRECTION => RMF_DIRECTION,
		RMF_SPEED => RMF_SPEED,
		LMF_DIRECTION => LMF_DIRECTION,
		LMF_SPEED => LMF_SPEED );				



end Behavioral;
