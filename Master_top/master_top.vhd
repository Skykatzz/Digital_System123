library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity master_top is --yg nyambung ke port luar board
Port (	--camera + pixel capture
	   sioc : out  STD_LOGIC;
           siod : out  STD_LOGIC;
           pwdn  : out   STD_LOGIC;
           fsioc : in  STD_LOGIC; --clock utk register 400 khz
           --config_finished : out STD_LOGIC; -- memberi tau register sudah selesai , optional
           pclk_in    : in  STD_LOGIC -- clock dari camera 24 mhz
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
           rst : in  STD_LOGIC
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

-- KELOMPOK CAMERA + PIXEL CAPTURE
	
component ov7670_capture is
    port ( pclk    : in  STD_LOGIC;
     vsync   : in  STD_LOGIC;
     href    : in  STD_LOGIC;
     data_In : in  STD_LOGIC_VECTOR (7 downto 0);
     RST    : in STD_LOGIC;
     halfclk  : out STD_LOGIC;
     PixelOut: out STD_LOGIC_VECTOR (7 downto 0)
     );
end component;

component Shift_reg is
    Port ( Data : in  STD_LOGIC_VECTOR (27 downto 0);
           LOAD_EN : in  STD_LOGIC;
           SHIFT_EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Siod : out  STD_LOGIC);
			  
end component;

component ov7670_controller is
    Port ( Count_EN : out  STD_LOGIC;
           LOAD_EN : out  STD_LOGIC;
           SHIFT_EN : out  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           SET_EN: out STD_LOGIC;
           stop_cond : in STD_LOGIC;
           advance : out STD_LOGIC;
           RESET_EN: out STD_LOGIC
           ); 

end component;

component counter is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           COUNT_EN : in  STD_LOGIC;
		   stop_cond : out STD_LOGIC
			  );
end component;

component Flipflop is
    Port ( SET_EN : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           RESET_EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           sioc : out  STD_LOGIC);
end component;
        
        COMPONENT ov7670_registers is
PORT(
        clk      : IN std_logic;
        advance  : IN std_logic;
        rst   : in STD_LOGIC;
        command  : OUT std_logic_vector(15 downto 0);
        finished : OUT std_logic);	
END COMPONENT;
	
-- ------------SIGNALS--------------
-- between register parts 
	
 signal internal_data: STD_LOGIC_VECTOR(27 downto 0);
 signal internal_count_en: STD_LOGIC;
 signal internal_stop_cond : STD_LOGIC;
 signal internal_load_en: STD_LOGIC;
 signal internal_shift_en: STD_LOGIC;
 signal internal_set_en: STD_LOGIC; 
 signal internal_reset_en: STD_LOGIC;
 signal command  : std_logic_vector(15 downto 0);
 signal finished : std_logic := '0';
 signal taken    : std_logic := '0';
 signal send     : std_logic;
 signal internal_advance: std_logic;
 signal Data_in : std_logic;
 signal dpara : std_logic_vector(7 downto 0);
 signal pclk : std_logic;
 constant camera_address : std_logic_vector(7 downto 0) := x"42";
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
-- camera control(register) & pixel capture
config_finished <= finished;
   reset <= rst;                                                            -- Normal mode
   pwdn  <= '0';                                           -- Power device up
   pclk <= pclk_in;
   Inst_ov7670_registers: ov7670_registers 
   PORT MAP(
                      clk      => fsioc,
                      advance  => internal_advance,
                      command  => command,
                      finished => finished,
                      rst   => rst
              );
  dpara(7) <= d7;
  dpara(6) <= d6;
  dpara(5) <= d5;
  dpara(4) <= d4;
  dpara(3) <= d3;
  dpara(2) <= d2;
  dpara(1) <= d1;
  dpara(0) <= d0;
  
    toplevel_ov7670_capture: ov7670_capture
    port map (pclk   => pclk,
         vsync   => vsync,
         href    => href,
         data_In => dpara,
         RST    => rst,
         halfclk  => halfclk,
         PixelOut => pixelout
    );
     

	Datapath_ov7670controller: ov7670_controller
	port map (
	Count_EN => internal_Count_En,
	LOAD_EN => internal_load_en,
	SHIFT_EN => internal_shift_en,
	CLK => fsioc,
	RST => RST,
	SET_EN => internal_SET_EN,
   RESET_EN => internal_RESET_EN,
   advance => internal_advance,
	stop_cond => internal_stop_cond
	);
	
	Datapath_shift_reg: Shift_reg
	port map (
	Data =>  internal_data,
	LOAD_EN => internal_LOAD_EN,
	SHIFT_EN => internal_SHIFT_EN,
	CLK => fsioc,
	RST => RST,
	SIOD => SIOD);

	Datapath_counter: counter
	port map(
		   CLK => fsioc,
           RST => RST,
           COUNT_EN =>internal_COUNT_EN,
		   stop_cond => internal_stop_cond);
			  
	Datapath_flipflop: Flipflop
	port map (
		   SET_EN => internal_SET_EN,
           RST    => RST,
           RESET_EN => internal_RESET_EN,
           CLK 	=> fsioc,
           sioc => sioc);
    
	internal_data(27) <= '0';
	internal_data(26 downto 19) <= camera_address;
	internal_data(18) <= '1' ;
	internal_data(17 downto 10) <= command(15 downto 8);
	internal_data(9) <= '1' ;
	internal_data(8 downto 1) <= command(7 downto 0);
	internal_data(0) <= '0' ;

 ----------------------------------
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

