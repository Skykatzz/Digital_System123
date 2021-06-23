library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity master_top is --yg nyambung ke port luar board
Port (	--camera + pixel capture
	   sioc : out  STD_LOGIC;
           siod : out  STD_LOGIC;
           pwdn  : out   STD_LOGIC;
           fsioc : in  STD_LOGIC; --clock utk register 400 khz
           --config_finished : out STD_LOGIC; -- memberi tau register sudah selesai , optional
           pclk_in    : in  STD_LOGIC; -- clock dari camera 24 mhz
           vsync   : in  STD_LOGIC;
           href    : in  STD_LOGIC;
           --halfclk  : out STD_LOGIC; -- 1/2 clock 24mhz
           --PixelOut: out STD_LOGIC_VECTOR (7 downto 0);-- data pixel tanpa cb cr , hanya y saja
           d0 : in std_logic;
           d1 : in std_logic;
           d2 : in std_logic;
           d3 : in std_logic;
           d4 : in std_logic;
           d5 : in std_logic;
           d6 : in std_logic;
           d7 : in std_logic;
           mclk : out std_logic; --generate clock ke camera
	--reset ke camera module
           reset: out std_logic;
	--reset yg button
           rst : in  STD_LOGIC;
	--pwm gen
	output_kecepatan_kiri  : out  STD_LOGIC;
	output_kecepatan_kanan : out  STD_LOGIC;
	output_direction_kiri : out STD_LOGIC;
	output_direction_kanan : out STD_LOGIC;
	--ab decoder
	A1 : in  STD_LOGIC;
	B1 : in  STD_LOGIC;
	A2 : in  STD_LOGIC;
	B2 : in  STD_LOGIC;
	--clock for pwm gen n measurement
	clock_2khz : in STD_LOGIC;
	clock_625khz :in STD_LOGIC;
	---segment
        Anodectivate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
        LEDout : out STD_LOGIC_VECTOR (6 downto 0)-- Cathode patterns of 7-segment 
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
        LM_SPEED : out std_logic_vector (7 downto 0)
	
);
end component;
	
-- KELOMPOK SPEED GENERATOR & MEASUREMENT :
component top_final is
Port ( 
	---input ke motor controller
	input_kecepatan_kiri  : in  STD_LOGIC_VECTOR (7 downto 0);
	input_kecepatan_kanan : in  STD_LOGIC_VECTOR (7 downto 0);
	input_direction_kiri : in STD_LOGIC;
	input_direction_kanan : in STD_LOGIC;
	---output ke motor
	output_kecepatan_kiri  : out  STD_LOGIC;
	output_kecepatan_kanan : out  STD_LOGIC;
	output_direction_kiri : out STD_LOGIC;
	output_direction_kanan : out STD_LOGIC;
	---feedback ke motor
	A1 : in  STD_LOGIC;
	B1 : in  STD_LOGIC;
	A2 : in  STD_LOGIC;
	B2 : in  STD_LOGIC;

	feedback_kecepatan_kiri  : out  STD_LOGIC_VECTOR (7 downto 0);
	feedback_kecepatan_kanan : out  STD_LOGIC_VECTOR (7 downto 0);
	feedback_direction_kiri :  out STD_LOGIC;
	feedback_direction_kanan : out STD_LOGIC;
	clock_2khz : in STD_LOGIC;
	clock_625khz :in STD_LOGIC;
	reset : in STD_LOGIC;
	---segment
	Anodectivate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
	LEDout : out STD_LOGIC_VECTOR (6 downto 0)-- Cathode patterns of 7-segment 

);
end component;
	
-- KELOMPOK LIGHT SOURCE DETECTION & THRESHOLDING :	
component TOPLEVEL_THD is 
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
        READY : inout STD_LOGIC);
end component;
	
--Camera control & pixel capture
COMPONENT toplevel IS
PORT(   sioc : out  STD_LOGIC;
        siod : out  STD_LOGIC;
        pwdn  : out   STD_LOGIC;
        fsioc : in  STD_LOGIC;
        config_finished : out STD_LOGIC;
        pclk_in    : in  STD_LOGIC;
        vsync   : in  STD_LOGIC;
        href    : in  STD_LOGIC;
        halfclk  : out STD_LOGIC;
        PixelOut: out STD_LOGIC_VECTOR (7 downto 0);
        d0 : in std_logic;
        d1 : in std_logic;
        d2 : in std_logic;
        d3 : in std_logic;
        d4 : in std_logic;
        d5 : in std_logic;
        d6 : in std_logic;
        d7 : in std_logic;
        mclk : out std_logic;
        reset: out std_logic;
        rst : in  STD_LOGIC);
END COMPONENT;
	

-- tulis top level masing-masing kelompok di sini:
-- component xxx is
-- Port ( );
-- end component;
	

-- ------------SIGNALS--------------
-- between register parts
	
--between pixelcapture and thresholding:	
signal pixelout : STD_LOGIC_VECTOR (7 downto 0);

--between thresholding and speedndir:
signal POS_B, SIZE_B : STD_LOGIC_VECTOR (9 downto 0);
signal READY : std_logic;

-- between measurement and speedndir:
signal RMF_DIRECTION, LMF_DIRECTION : std_logic;
signal RMF_SPEED, LMF_SPEED : std_logic_vector(7 downto 0);

-- between PWM_generator and speedndir:
signal RM_DIRECTION, LM_DIRECTION : std_logic;
signal RM_SPEED, LM_SPEED : std_logic_vector(7 downto 0);

begin
	
-- TOP LEVEL SPEEDNDIR
TLSND : TOPLEVELSPEEDNDIR
port map(
	-- FROM THRESHOLDING:
	POSITION => POS_B,
	SIZE => SIZE_B,
	READY => READY, 
	-- FROM MEASUREMENT
	RMF_DIRECTION => RMF_DIRECTION,
	RMF_SPEED => RMF_SPEED,
	LMF_DIRECTION => LMF_DIRECTION,
	LMF_SPEED => LMF_SPEED,
	VSYNC => vsync,
	-- RESET:
	RST => RST,
	-- TO PWM:
	RM_DIRECTION => RM_DIRECTION,
	RM_SPEED => RM_SPEED,
	LM_DIRECTION => LM_DIRECTION,
	LM_SPEED => LM_SPEED
);
	
	
TLTHD : TOPLEVEL_THD
port map(	
	-- FROM PIXEL CAPTURE :
	CLK => pclk_in,--25 MHz CLK
        HREF => HREF,--HREF
        VSYNC => VSYNC, -- VSYNC 62.5 Hz
        Y => pixelout , --Y from Pixel Capture
	-- RESET:
	RST => RST,
	-- TO DECIDE SPEED AND DIRECTION :
        Size_B => Size_B,
        Pos_B => Pos_B,
        Q => Q,
        READY => READY
);
	
-- Top level Motor gen & measurement
TLPGSM : top_final 
PORT MAP (
	input_kecepatan_kiri  => LM_SPEED,
	input_kecepatan_kanan => RM_SPEED,
	input_direction_kiri  => LM_DIRECTION,
	input_direction_kanan => RM_DIRECTION,
	---output ke motor
	output_kecepatan_kiri  => output_kecepatan_kiri,
	output_kecepatan_kanan => output_kecepatan_kiri,
	output_direction_kiri  => output_direction_kiri,
	output_direction_kanan => output_direction_kanan,
	---feedback ke motor
	A1 => A1,
	B1 => B1,
	A2 => A2,
	B2 => B2,

	feedback_kecepatan_kiri  =>LMF_SPEED,
	feedback_kecepatan_kanan =>RMF_SPEED,
	feedback_direction_kiri =>LMF_DIRECTION,
	feedback_direction_kanan =>RMF_DIRECTION,
	clock_2khz => clock_2khz, -- CLOCK 2 KHZ
	clock_625khz => clock_625khz, -- CLOCK 62,5 KHZ
	reset => reset,
	---segment
	Anodectivate => Anodectivate,
	LEDout => LEDout);
	
-- Top level Camera
TLCAM : toplevel PORT MAP (
      sioc => sioc,
      siod => siod,
      reset => reset,
      pwdn => pwdn,
      fsio => xclk,
      pclk_in => clk,
      config_finished => config_finished,
      RST  => RST,
      d0   => d0,
      d1   => d1,
      d2   => d2,    
      d3   => d3,    
      d4   => d4,    
      d5   => d5,    
      d6   => d6,    
      d7   => d7,    
      mclk  =>   mclk,  
      reset => reset, 
      rst   =>   rst   
    );
-- tulis port map masing-masing kelompok di sini:
-- bebas : (nama file top level kalian)
-- port map( );


end Behavioral;
