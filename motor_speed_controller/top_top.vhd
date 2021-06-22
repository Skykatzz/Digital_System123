

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity top_top_final is
Port ( 




---input ke motor controller
input_kecepatan_kiri  : in  STD_LOGIC_VECTOR (7 downto 0);


input_kecepatan_kanan : in  STD_LOGIC_VECTOR (7 downto 0);
input_direction_kiri : in STD_LOGIC;
input_direction_kanan : in STD_LOGIC;
---output ke motor
output_kecepatan_kiri  : out  STD_LOGIC; --- ke motor
output_kecepatan_kanan : out  STD_LOGIC;
output_direction_kiri :  out STD_LOGIC; --- ke motor
output_direction_kanan : out STD_LOGIC;
---feedback ke motor

A1 : in  STD_LOGIC; --- Decoder a1
B1 : in  STD_LOGIC; --- decoder b1
clock_512hz :  in STD_LOGIC;
clock_2khz   :  in STD_LOGIC;
CLK : in STD_LOGIC; -- clock 100mhz
A2 : in  STD_LOGIC;--- Decoder a2
B2 : in  STD_LOGIC;--- Decoder b2

feedback_kecepatan_kiri  : out STD_LOGIC_VECTOR (7 downto 0); ---feedback value kiri 
feedback_kecepatan_kanan : out STD_LOGIC_VECTOR (7 downto 0); ---feedback value kanan
feedback_direction_kiri :  out STD_LOGIC; ---feedback arah kiri
feedback_direction_kanan : out STD_LOGIC; ---feedback arah kanan
reset : in STD_LOGIC; --  tombol reset
---segment
Anodectivate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals (mengendalikan seven segment )
LEDout : out STD_LOGIC_VECTOR (6 downto 0)-- Cathode patterns of 7-segment 

);
end top_top_final;

architecture Behavioral of top_top_final is
---A-B encoder
--- signal counter

---        
component ab_decoder is
    Port ( CLOCK : in  STD_LOGIC;
           A1 : in  STD_LOGIC;
           B1 : in  STD_LOGIC;
           A2 : in  STD_LOGIC;
           B2 : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           Up_en1 : out  STD_LOGIC;
           Dwn_en1 : out  STD_LOGIC;
           Up_en2 : out  STD_LOGIC;
           Dwn_en2 : out  STD_LOGIC
           );
end component;
---
---Counter_countup_countdown
component Counter is
    Port ( COUNT_UP_Left : in  STD_LOGIC;
           COUNT_DWN_Left : in  STD_LOGIC;
           COUNT_UP_Right : in  STD_LOGIC;
           COUNT_DWN_Right : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           C_OUT_Left : out  STD_LOGIC_VECTOR (7 downto 0);
           C_OUT_Right : out  STD_LOGIC_VECTOR (7 downto 0)
           ); 
end component;

---pwm_gen
component Speed_Value is
    Port ( Nilai_Kecepatan_kiri  : in  STD_LOGIC_VECTOR (7 downto 0);
           Nilai_Kecepatan_kanan : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           LEFT_DIR_INPUT : in STD_LOGIC;
           RIGHT_DIR_INPUT : in STD_LOGIC;
           LEFT_MOTOR_DIRECTION : out STD_LOGIC;
           RIGHT_MOTOR_DIRECTION : out STD_LOGIC;
           PWM_OUT_LEFT_MOTOR : out  STD_LOGIC;
           PWM_OUT_RIGHT_MOTOR : out STD_LOGIC
           );
           
end component;


---clock2khz
---component clock_2khz is
---port ( 

---RST : in STD_LOGIC;
---clock_out1 :out STD_LOGIC
---);
---end component;

---clock62khz

---component clock_625khz is

---port ( 

---RST : in STD_LOGIC;
---clock_out2 :out STD_LOGIC

---);
---end component;

---Sr_prevcount
component SR_PrevCount_Final_3 is 

                Port(   Count_kiri  : in  STD_LOGIC_Vector(7 downto 0); 
                        Count_kanan : in  STD_LOGIC_Vector(7 downto 0);
                        PWM_kiri: out  STD_LOGIC_Vector(7 downto 0);
                        PWM_kanan: out  STD_LOGIC_Vector(7 downto 0);
                        direction_L : out STD_LOGIC;
                        direction_R : out STD_LOGIC;
                        clk62hz : in  STD_LOGIC;
                        RST : in STD_LOGIC;
                        tosegment : out STD_LOGIC_VECTOR (7 downto 0)
                        );
                        
end component;
---seven_segment
component  seven_segment_display_VHDL is
Port ( clock_100Mhz : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
       reset : in STD_LOGIC; -- reset
	   input_value : in STD_LOGIC_VECTOR ( 15 downto 0 );
       Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
       LED_out : out STD_LOGIC_VECTOR (6 downto 0));-- Cathode patterns of 7-segment display
end component;
--- counter signal 


signal    countup_left :     STD_LOGIC;
signal    countdown_left :   STD_LOGIC;
signal    countup_right :   STD_LOGIC;
signal    countdown_right :  STD_LOGIC;

signal    Upen1 :  STD_LOGIC;
signal    Dwnen1 : STD_LOGIC;
signal    Upen2 :  STD_LOGIC;
signal    Dwnen2 : STD_LOGIC;
signal    output_left : STD_LOGIC_VECTOR(7 downto 0);
signal    output_right : STD_LOGIC_VECTOR(7 downto 0);


---substractor signal


signal Countkiri  :  STD_LOGIC_Vector(7 downto 0); 
signal Countkanan :  STD_LOGIC_Vector(7 downto 0);

---segment signal

signal inputvalue :  STD_LOGIC_VECTOR (  7 downto 0 );

begin




datapath_counter : Counter 
port map (
           COUNT_UP_Left => countup_left,
           COUNT_DWN_Left => countdown_left,
           COUNT_UP_Right => countup_right,
           COUNT_DWN_Right => countdown_right,
           RST => reset,
           CLK => clock_512hz,
           C_OUT_Left => output_left,
           C_OUT_Right =>output_right
);

datapath_decoder : ab_decoder
port map (
       
       CLOCK => clock_512hz,
       A1 => a1,
       B1 => b1 ,
       A2 => a2  ,
       B2 => b2  ,
       RST => reset,
       Up_en1 => Upen1 ,
       Dwn_en1 =>Dwnen1 ,
       Up_en2 => Upen2 ,
       Dwn_en2 =>Dwnen2  
);

datapath_pwmgen : Speed_value
port map (
  Nilai_Kecepatan_kiri => input_kecepatan_kiri,
  Nilai_Kecepatan_kanan => input_kecepatan_kanan,
  CLK => clock_512hz ,
  RST => reset , 
  LEFT_DIR_INPUT => input_direction_kiri,
  RIGHT_DIR_INPUT => input_direction_kanan,
  LEFT_MOTOR_DIRECTION => output_direction_kiri,
  RIGHT_MOTOR_DIRECTION => output_direction_kanan,
  PWM_OUT_LEFT_MOTOR => output_kecepatan_kiri,
  PWM_OUT_RIGHT_MOTOR => output_kecepatan_kanan
);

---datapath_2clock : clock_2khz
---port map (
---clock_out1 => p2clock
---);


---datapath_625clock : clock_625khz

---port map(
---clock_out2 => p625clock
---);

datapath_substractor : SR_PrevCount_Final_3

port map(
 
 PWM_kiri =>  feedback_kecepatan_kiri,
 PWM_kanan => feedback_kecepatan_kanan,
 clk62hz =>clock_512hz,
 RST => reset,
 Count_kiri => Countkiri,
 Count_kanan => Countkanan,
 direction_L => feedback_direction_kiri,
 direction_R => feedback_direction_kanan,
 tosegment => inputvalue
 
);



datapath_segment : seven_segment_display_VHDL
port map(
clock_100Mhz => CLK,
input_value => "00000000" & inputvalue,
Anode_activate =>   Anodectivate, 
LED_out => LEDout,
reset => reset
);



--connectorr
countup_left <= Upen1;
countdown_left <= Dwnen1 ;
countup_right <= Upen2  ;
countdown_right <= Dwnen2 ;
    
Countkiri <=  output_left ; 
Countkanan <= output_right ;

end Behavioral;
