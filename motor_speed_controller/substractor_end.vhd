library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
------ memulai pergeseran 
entity SR_PrevCount_Final_3 is 
                Port(    PWM_kiri: out  STD_LOGIC_Vector(7 downto 0);
                         PWM_kanan: out  STD_LOGIC_Vector(7 downto 0);
                         direction_L : out STD_LOGIC;
                         direction_R : out STD_LOGIC;
                         clk62hz : in  STD_LOGIC;
                         RST: in  STD_LOGIC;
                        Count_kiri  : in  STD_LOGIC_Vector(7 downto 0); 
                        Count_kanan : in  STD_LOGIC_Vector(7 downto 0));
end SR_PrevCount_Final_3;

architecture Behavioral of SR_PrevCount_Final_3 is

signal after_1 : STD_LOGIC_VECTOR(7 downto 0);
signal before_1 : STD_LOGIC_VECTOR(7 downto 0);
signal after_2 : STD_LOGIC_VECTOR(7 downto 0);
signal before_2 : STD_LOGIC_VECTOR(7 downto 0);
signal hasil_pengurangan_1 : STD_LOGIC_VECTOR(7 downto 0);
signal hasil_pengurangan_2 : STD_LOGIC_VECTOR(7 downto 0);
signal RPS1 : STD_LOGIC_VECTOR(7 downto 0);
signal RPS2 : STD_LOGIC_VECTOR(7 downto 0 );
signal EXT_RPS1 : STD_LOGIC_VECTOR(7 downto 0);
signal EXT_RPS2 : STD_LOGIC_VECTOR(7 downto 0);
signal ninebit_signed_RPS2 : STD_LOGIC_VECTOR(8 downto 0);
signal ninebit_signed_RPS2 : STD_LOGIC_VECTOR(8 downto 0);
signal signed_RPS1 : STD_LOGIC_VECTOR(7 downto 0 );
signal signed_RPS2 : STD_LOGIC_VECTOR(7 downto 0 );

-----SR KIRI
Component SR_LEFT Port( CKIRIOUT : in  STD_LOGIC;
                            RST : in  STD_LOGIC;
                            SR_CLK : in  STD_LOGIC;
                            Q_SR1 : out  STD_LOGIC);
                            End Component;
-----SR KANAN     
Component SR_RIGHT Port( CKANANOUT : in  STD_LOGIC;
                            RST : in  STD_LOGIC;
                            SR_CLK : in  STD_LOGIC;
                            Q_SR2 : out  STD_LOGIC);
        
End Component;
                           
                           
                           
begin

before_1 <= Count_kiri;
before_2 <= Count_kanan;


----PORT MAP KIRI

        
U3: SR_LEFT PORT MAP(
        C_OUT1 => Count_kiri(7),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR1=> Q(7)
        );
        
U4: SR_LEFT PORT MAP(
        C_OUT1 => Count_kiri(6),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR1=> Q(6)
        );
        
U5: SR_LEFT PORT MAP(
        C_OUT1 => Count_kiri(5),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR1=> Q(5)
        );

U6: SR_LEFT PORT MAP(
        C_OUT1 => Count_kiri(4),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR1=> Q(4)
        );
        
U7: SR_LEFT PORT MAP(
        C_OUT1 => Count_kiri(3),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR1=> Q(3)
        );
        
U8: SR_LEFT PORT MAP(
        C_OUT1 => Count_kiri(2),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR1=> Q(2)
        );
        
U9: SR_LEFT PORT MAP(
        C_OUT1 => Count_kiri(1),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR1=> Q(1)
        );

U10: SR_LEFT PORT MAP(
        C_OUT1 => Count_kiri(0),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR1=> Q(0)
        );
--- PORTMAP KANAN

        
U3: SR_RIGHT PORT MAP(
        C_OUT2 => Count_kanan(7),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR2=> Q(7)
        );
        
U4: SR_RIGHT PORT MAP(
        C_OUT2 => Count_kanan(6),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR2=> Q(6)
        );
        
U5: SR_RIGHT PORT MAP(
        C_OUT2 => Count_kanan(5),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR2=> Q(5)
        );

U6: SR_RIGHT PORT MAP(
        C_OUT2 => Count_kanan(4),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR2=> Q(4)
        );
        
U7: SR_RIGHT PORT MAP(
        C_OUT2 => Count_kanan(3),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR2=> Q(3)
        );
        
U8: SR_RIGHT PORT MAP(
        C_OUT2 => Count_kanan(2),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR2=> Q(2)
        );
        
U9: SR_RIGHT PORT MAP(
        C_OUT2 => Count_kanan(1),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR2=> Q(1)
        );

U10: SR_RIGHT PORT MAP(
        C_OUT2 => Count_kanan(0),
        RST => RST,
        SR_CLK => clk62hz,
        Q_SR2=> Q(0)
        );
    after_1 <= Count_kiri;
    after_2 <= Count_kanan;
    
    
    
    
    ---perhitungan rotation per sec
    
    hasil_pengurangan_1 <= before_1 - after_1;
    hasil_pengurangan_2 <= before_2 - after_2;
        
    RPS1 <=  hasil_pengurangan_1 / 3 ;
    RPS2 <=  hasil_pengurangan_2 / 3 ;
    
    --from 8 bit to 9 bit
    
    EXT_RPS1 <= '0' & RPS1;
    EXT_RPS2 <= '0' & RPS2;
    --from unsigned to signed 
    ninebit_signed_RPS1 <= not EXT_RPS1 + 1 ;
    ninebit_signed_RPS2 <= not EXT_RPS2 + 1 ;
    -- DIRECTION OUTPUT
    direction_L <=  ninebit_signed_RPS1 (8);
    direction_R <=  ninebit_signed_RPS2 (8);
    -- PWM OUTPUT
    PWM_kiri  <= RPS1 ; 
    PWM_kanan <= RPS2  ; 
    --- SEGMENT OUTPUT
     input_value <= RPS1;
end Behavioral; 

----Memulai SR_KIRI sebanyak 31 kali
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SR_LEFT is
    Port ( C_OUT1 : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           --Load_EN : in  STD_LOGIC;
           SR_CLK : in  STD_LOGIC;
           Q_SR1 : out  STD_LOGIC);
end SR_LEFT;

architecture Behavioral of SR_LEFT is
signal temp1: std_logic_vector( 30 downto 0);
begin
process( SR_CLK, RST) --Load_EN)
begin
    if(RST='1') then
        temp1<="0000000000000000000000000000000";
    elsif (SR_CLK'event and SR_CLK ='1') then --and Load_EN ='1') then
        temp1(30)<=C_OUT;
        temp1(29)<=temp1(30);
        temp1(28)<=temp1(29);
        temp1(27)<=temp1(28);
        temp1(26)<=temp1(27);
        temp1(25)<=temp1(26);
        temp1(24)<=temp1(25);
        temp1(23)<=temp1(24);
        temp1(22)<=temp1(23);
        temp1(21)<=temp1(22);
        temp1(20)<=temp1(21);
        temp1(19)<=temp1(20);
        temp1(18)<=temp1(19);
        temp1(17)<=temp1(18);
        temp1(16)<=temp1(17);
        temp1(15)<=temp1(16);
        temp1(14)<=temp1(15);
        temp1(13)<=temp1(14);
        temp1(12)<=temp1(13);
        temp1(11)<=temp1(12);
        temp1(10)<=temp1(11);
        temp1(9)<=temp1(10);
        temp1(8)<=temp1(9);
        temp1(7)<=temp1(8);
        temp1(6)<=temp1(7);
        temp1(5)<=temp1(6);
        temp1(4)<=temp1(5);
        temp1(3)<=temp1(4);
        temp1(2)<=temp1(3);
        temp1(1)<=temp1(2);
        temp1(0)<=temp1(1);
    end if;
end process;
    Q_SR1  <=  temp1(0);
end Behavioral;
----Memulai SR_KANAN sebanyak 31 kali
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity SR_RIGHT is
    Port ( C_OUT2 : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           --Load_EN : in  STD_LOGIC;
           SR_CLK : in  STD_LOGIC;
           Q_SR2 : out  STD_LOGIC);
end SR_RIGHT;

architecture Behavioral of SR_RIGHT is
signal temp2: std_logic_vector( 30 downto 0);
begin
process( SR_CLK, RST) --Load_EN)
begin
    if(RST='1') then
        temp2<="0000000000000000000000000000000";
    elsif (SR_CLK'event and SR_CLK ='1') then --and Load_EN ='1') then
        temp2(30)<=C_OUT;
        temp2(29)<=temp2(30);
        temp2(28)<=temp2(29);
        temp2(27)<=temp2(28);
        temp1(26)<=temp2(27);
        temp2(25)<=temp2(26);
        temp2(24)<=temp2(25);
        temp2(23)<=temp2(24);
        temp2(22)<=temp2(23);
        temp2(21)<=temp2(22);
        temp2(20)<=temp2(21);
        temp2(19)<=temp2(20);
        temp2(18)<=temp2(19);
        temp2(17)<=temp2(18);
        temp2(16)<=temp2(17);
        temp2(15)<=temp2(16);
        temp2(14)<=temp2(15);
        temp2(13)<=temp2(14);
        temp2(12)<=temp2(13);
        temp2(11)<=temp2(12);
        temp2(10)<=temp2(11);
        temp2(9)<=temp2(10);
        temp2(8)<=temp2(9);
        temp2(7)<=temp2(8);
        temp2(6)<=temp2(7);
        temp2(5)<=temp2(6);
        temp2(4)<=temp2(5);
        temp2(3)<=temp2(4);
        temp2(2)<=temp2(3);
        temp2(1)<=temp2(2);
        temp2(0)<=temp2(1);
    end if;
end process;

    Q_SR2  <=  temp2(0);
    
end Behavioral; 
