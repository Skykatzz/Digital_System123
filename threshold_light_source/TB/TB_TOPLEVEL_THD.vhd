LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
 
ENTITY TB_TOPLEVEL_THD IS
END TB_TOPLEVEL_THD;
 
ARCHITECTURE behavior OF TB_TOPLEVEL_THD IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOPLEVEL_THD
    PORT( CLK : in  STD_LOGIC;
          RST : in  STD_LOGIC;
          HREF : in STD_LOGIC;
          VSYNC : in  STD_LOGIC;
          Y : in STD_LOGIC_VECTOR (7 downto 0); --only in, Y from Pixel Capture
          SIZE_B : out  STD_LOGIC_VECTOR (9 downto 0);
          POS_B : out  STD_LOGIC_VECTOR (9 downto 0);
          Q : inout STD_LOGIC;
          READY : inout STD_LOGIC);--tidak perlu 
    END COMPONENT;
    
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--input
 signal CLK : std_logic := '0';
 signal RST : std_logic := '0';
 signal HREF : std_logic := '0';
 signal VSYNC : std_logic := '0';
 signal Y : std_logic_vector (7 downto 0) := "00000000";
 
--output:
 signal Size_B : STD_LOGIC_VECTOR (9 downto 0);
 signal Pos_B : STD_LOGIC_VECTOR (9 downto 0);
 signal Q : std_logic;
 signal READY : std_logic;
	
 constant pclk_period : time := 20 ns;
 constant clk_period : time :=  40 ns;
 constant line_period : time := 784*2*pclk_period; 	
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
    uut: TOPLEVEL_THD PORT MAP (
             CLK => CLK,
             RST => RST,
             HREF => HREF ,
             VSYNC => VSYNC,
             Y => Y,
             Size_B => Size_B,
             Pos_B => Pos_B,
             Q => Q,
             READY => READY);
		 
	clk_process :process
          begin
              CLK <= '1';
              wait for clk_period/2;
              CLK <= '0';
              wait for clk_period/2;
              
          end process;
          
     stim_procRST: process -- reset
           begin        
              RST <= '1';
              wait for 1 ns;
              RST <= '0';
              wait;
           end process;  
     
     vsync_href_proc :process
           variable href_loop :integer;
           variable pixel_loop :integer;
           begin
            HREF <= '0';
            VSYNC <= '1';
            wait for 3*line_period;
            VSYNC <='0';
            wait for 17 * line_period;
           for href_loop in 1 to 480 loop
              HREF <= '1';
              wait for 640*clk_period;
              HREF <= '0';
              wait for 144*2*pclk_period;
             end loop;
           
           wait for 10*line_period;
        end process;

     Y_proc :process
        begin        
            wait for 20*line_period;
            Y <= "01001001";
            wait for clk_period;
            Y <= "01110101";
            wait for clk_period;
            Y <= "11010101";
            wait for clk_period;
            Y <= "11011101";
            wait for clk_period;
            Y <= "11110101";
            wait for clk_period;
            Y <= "11010100";
            wait for clk_period;
            Y <= "11111101";
            wait for clk_period;
            Y <= "01111101";
            wait;
            
         end process;   
      END;
