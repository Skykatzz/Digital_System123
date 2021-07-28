library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

entity VGA_sync is
    port (
        pclk: in std_logic;
        rst: in  STD_LOGIC;
        VGA_Red: out std_logic_vector (3 downto 0);
        VGA_Green: out std_logic_vector(3 downto 0);
        VGA_Blue: out std_logic_vector(3 downto 0);
	h_sync, v_sync: out std_logic;
	pixelin : in std_logic_vector (7 downto 0)
       );
end entity VGA_sync;
 
architecture Behavior of VGA_sync is
   
	constant horizontaldisplay : integer := 639;  
	constant horizontalfrontporch : integer := 16;       
	constant horizontalsyncpulse : integer := 96;       
	constant horizontalbackporch : integer := 48;        
	
	constant verticaldisplay : integer := 479;  
	constant verticalfrontporch : integer := 10;       	 
	constant verticalsyncpulse : integer := 2;				 
	constant verticalbackporch : integer := 33;       
	
	signal h_pos : integer ;
	signal v_pos : integer ;
	
	signal videoOn : std_logic := '0' ;

	begin
timing:  
    process (pclk, rst) is
        begin
          if rst='1' then
            h_pos <= 0;
            v_pos <= 0;
		  elsif(pclk' EVENT and pclk = '1') then 
            if h_pos < 800 then
                h_pos <= h_pos + 1;
            else
                h_pos <=1;
                if v_pos < 520 then
                    v_pos <= v_pos + 1;
                else
                    v_pos <=1;
                 end if;  
            end if;  
            -- HSYNC
            if h_pos > 16 and h_pos < 112  then 
                h_sync <= '0';   -- h_sync low during display
            else
                h_sync <= '1';
            end if; 
            -- VSYNC
            if v_pos > 8 and v_pos < 11  then 
                v_sync <= '0';  -- v_sync low during display
            else
                v_sync <= '1';
            end if;
        end if;
    end process;

video_on:
process(pclk, rst, h_pos, v_pos)is
begin
	if(rst = '1')then
		videoOn <= '0';
	elsif(pclk' EVENT and pclk = '1')then
		if(h_pos <= horizontaldisplay and v_pos <= verticaldisplay)then
			videoOn <= '1';
		else
			videoOn <= '0';
		end if;
	end if;
end process;


draw:process(pclk, rst, h_pos, v_pos, videoOn, pixelin)
begin
	if(rst = '1')then
		VGA_Red <= "0000";
		VGA_Green <= "0000";
		VGA_Blue <= "0000";
	elsif(pclk' EVENT and pclk = '1')then
		if(videoOn = '1')then
			if((h_pos >= 1 and h_pos <=639) AND (v_pos >= 1 and v_pos <= 479))then
				VGA_Red <= pixelin (7 downto 4); --test
                		VGA_Green <= pixelin (7 downto 4);
                		VGA_Blue <= pixelin (7 downto 4);
			else
				VGA_Red <= "0000";
                		VGA_Green <= "0000";
                		VGA_Blue <= "0000";
			end if;
		else
			VGA_Red <= "0000";
            		VGA_Green <= "0000";
        	    	VGA_Blue <= "0000";
		end if;
         -- BLANKING
        if (h_pos > 1 and h_pos < 160) or (v_pos > 1 and v_pos < 40 ) then
            VGA_Red <= (others => '0');
            VGA_Green <= (others => '0');
            VGA_Blue <= (others => '0');
        end if;         
	end if;
end process;

end architecture Behavior;
