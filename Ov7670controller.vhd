library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--generate LE dan SE dan CE 
entity ov7670controller is

    Port ( Count_EN : out  STD_LOGIC;
           LOAD_EN : out  STD_LOGIC;
           SHIFT_EN : out  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
		   siod : in STD_LOGIC;
           Sioc : in  STD_LOGIC;
           SET_EN: out STD_LOGIC;
           stop_cond : in STD_LOGIC;
           RESET_EN: out STD_LOGIC
           ); 

end ov7670controller;
architecture Behavioral of ov7670controller is
signal shift_enin: STD_LOGIC;
signal set_enin: STD_LOGIC;

begin
process(rst, clk)
begin
     if rising_edge(clk) then
     --reset
        if rst = '1' then
         LOAD_EN <= '0';
         shift_en<= '0';
         set_en <= '0';
         reset_en <= '0';
             -- idle state
          
            --start 1 masuk input send pertama kali
           if sioc ='1' and siod = '1'  then
                load_en <= '1';
             else 
            --start 2 load pertama siod pasti 0 
                if sioc = '1' and siod = '0' THEN
                 --sioc menjadi 0
                   reset_en <= '1';
            --shift 
                elsif stop_cond = '0' then
                 if sioc = '0'   then
                   shift_en <= '1';
                   reset_en <= '0';
            --set sioc     
                 elsif shift_enin = '1' then
                    shift_en <= '0';
                    load_en <= '1';
                    count_en <= '1';
                    set_en <= '1';
                  
                elsif set_enin = '1' then
                    set_en <= '0';
                    reset_en <= '1';
                end if;
               end if;
           end if;
       end if;
	end if;
end process;

end Behavioral;
