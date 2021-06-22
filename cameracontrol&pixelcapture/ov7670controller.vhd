library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--generate LE dan SE dan CE 
entity ov7670_controller is

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

end ov7670_controller;
architecture Behavioral of ov7670_controller is
type state is (idle,start1,start2,shift,setsioc,resetsioc,stop1,stop2);
signal NS:state;
signal PS:state;


begin
-- memory
    process(RST, clk)
    begin
        if RST= '1' then
            PS <= idle;
        elsif rising_edge(clk) then
            PS <= NS;   
        end if; 
    end process;
    -- state control
    process(PS,stop_cond)
    begin
        Load_En <= '0';
        Shift_En <= '0';
        Set_En <= '0';
        Reset_En <= '0';
        Count_En <= '0';
        advance <= '0';
        case PS is 
            when idle =>
                
                NS <= start1;
            when start1 =>  
                Load_En <= '1';
                
                NS <= start2;
            when start2 =>
                Reset_en <= '1';
                NS <= shift;
            when shift =>
                 Shift_En <= '1';
                 NS <= setsioc;

            when setsioc =>
                Set_En <= '1';
                Count_En <= '1';
                NS <= resetsioc;
            when resetsioc =>
                if stop_cond = '0' then 
                 reset_En <= '1';
                 NS <= shift;
                else 
                 reset_En <= '1';
                 NS <= stop1;
                 end if;
            when stop1 =>
                 Set_En <= '1';
                 NS <= stop2;
            when stop2 =>
                 shift_En <= '1';
                 NS <= idle;
                 advance <= '1';
          end case;      
    end process;
end Behavioral;
