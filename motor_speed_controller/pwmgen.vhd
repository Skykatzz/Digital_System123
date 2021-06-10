library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Speed_Value is
    Port ( Nilai_Kecepatan_kiri  : in  STD_LOGIC_VECTOR (7 downto 0);
           Nilai_Kecepatan_kanan : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           LEFT_DIR_INPUT : in STD_LOGIC;
           RIGHT_DIR_INPUT : in STD_LOGIC;
           LEFT_MOTOR_DIRECTION : out STD_LOGIC;
           RIGHT_MOTOR_DIRECTION : out STD_LOGIC;
           PWM_OUT_LEFT_MOTOR : out  STD_LOGIC;
           PWM_OUT_RIGHT_MOTOR : out STD_LOGIC);
           
           
end Speed_Value;

architecture Behavioral of Speed_Value is
    
signal COUNTER_PWM_KIRI: STD_LOGIC_VECTOR(7 downto 0):=(others => '0');-- counter for PWM signal on left motor
signal COUNTER_PWM_KANAN: STD_LOGIC_VECTOR(7 downto 0):=(others => '0');-- counter for PWM signal on right motor

begin
 
 -- Counter 0 - 255 for left motor
process(CLK,RST)
 begin
 if RST = '1' then 
    COUNTER_PWM_KIRI <= x"0";
 elsif rising_edge(CLK) then
     COUNTER_PWM_KIRI <= COUNTER_PWM_KIRI + x"1";
 end if;
  
 end process;

-- Counter 0- 255 for right motor

process(CLK,RST)
 begin
 if RST = '1' then 
    COUNTER_PWM_KANAN <= x"0";
 elsif rising_edge(CLK) then
     COUNTER_PWM_KANAN <= COUNTER_PWM_KANAN + x"1";
 end if;
  
 end process; 
 --comparator 
 
 PWM_OUT_LEFT_MOTOR <= '1' when COUNTER_PWM_KIRI < Nilai_Kecepatan_kiri else '0';
 PWM_OUT_RIGHT_MOTOR <= '1' when COUNTER_PWM_KANAN < Nilai_Kecepatan_kanan else '0';
 LEFT_DIR_INPUT <= LEFT_MOTOR_DIRECTION;
 RIGHT_DIR_INPUT <= RIGHT_MOTOR_DIRECTION;
end Behavioral;
