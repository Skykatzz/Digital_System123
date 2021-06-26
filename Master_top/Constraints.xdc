
##Pmod Header JXADC
##Sch name = XA1_P
set_property PACKAGE_PIN J3 [get_ports {sioc}]
set_property IOSTANDARD LVCMOS33 [get_ports {sioc}]
##Sch name = XA2_P
set_property PACKAGE_PIN L3 [get_ports {vsync}]
set_property IOSTANDARD LVCMOS33 [get_ports {vsync}]
##Sch name = XA3_P
set_property PACKAGE_PIN M2 [get_ports {pclk_in}]
set_property IOSTANDARD LVCMOS33 [get_ports {pclk_in}]
##Sch name = XA4_P
set_property PACKAGE_PIN N2 [get_ports {siod}]
set_property IOSTANDARD LVCMOS33 [get_ports {siod}]
##Sch name = XA1_N
set_property PACKAGE_PIN K3 [get_ports {d4}]
set_property IOSTANDARD LVCMOS33 [get_ports {d4}]
##Sch name = XA2_N
set_property PACKAGE_PIN M3 [get_ports {d6}]
set_property IOSTANDARD LVCMOS33 [get_ports {d6}]
##Sch name = XA3_N
set_property PACKAGE_PIN M1 [get_ports {d0}]
set_property IOSTANDARD LVCMOS33 [get_ports {d0}]
##Sch name = XA4_N
set_property PACKAGE_PIN N1 [get_ports {d2}]
set_property IOSTANDARD LVCMOS33 [get_ports {d2}]
##Pmod Header JA
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {d7}]
set_property IOSTANDARD LVCMOS33 [get_ports {d7}]
##Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {d5}]
set_property IOSTANDARD LVCMOS33 [get_ports {d5}]
##Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {d3}]
set_property IOSTANDARD LVCMOS33 [get_ports {d3}]
##Sch name = JA4
set_property PACKAGE_PIN G2 [get_ports {d1}]
set_property IOSTANDARD LVCMOS33 [get_ports {d1}]
##Sch name = JA7
set_property PACKAGE_PIN H1 [get_ports {href}]
set_property IOSTANDARD LVCMOS33 [get_ports {href}]
##Sch name = JA8
set_property PACKAGE_PIN K2 [get_ports {mclk}]
set_property IOSTANDARD LVCMOS33 [get_ports {mclk}]
##Sch name = JA9
set_property PACKAGE_PIN H2 [get_ports {reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]
##Sch name = JA10
set_property PACKAGE_PIN G3 [get_ports {pwdn}]
set_property IOSTANDARD LVCMOS33 [get_ports {pwdn}]

set_property PACKAGE_PIN V17 [get_ports {rst}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst}]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pclk_in]

create_clock -period 2500.000 -name fsioc -waveform {0.000 1250.000} [get_ports fsioc]
create_clock -period 10.000 -name CLK -waveform {0.000 5.000} -add [get_ports CLK]

#LEFT MOTOR PORT

##Pmod Header JB
##Sch name = JB1
#set_property PACKAGE_PIN A14 [get_ports  output_direction_kiri]					
	#set_property IOSTANDARD LVCMOS33 [get_ports  output_direction_kiri]
##Sch name = JB2
#set_property PACKAGE_PIN A16 [output_kecepatan_kiri]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {output_kecepatan_kiri]
##Sch name = JB3
#set_property PACKAGE_PIN B15 [get_ports A1]					
	#set_property IOSTANDARD LVCMOS33 [get_ports  A1]
##Sch name = JB4
#set_property PACKAGE_PIN B16 [get_ports B1]					
	#set_property IOSTANDARD LVCMOS33 [get_ports B1]

 
#RIGHT MOTOR PORT

##Sch name = JC1
#set_property PACKAGE_PIN K17 [output_direction_kanan]					
	#set_property IOSTANDARD LVCMOS33 [get_ports output_direction_kanan]
##Sch name = JC2
#set_property PACKAGE_PIN M18 [get_ports output_kecepatan_kanan]					
	#set_property IOSTANDARD LVCMOS33 [get_ports output_kecepatan_kanan]
##Sch name = JC3
#set_property PACKAGE_PIN N17 [get_ports A2]			
	#set_property IOSTANDARD LVCMOS33 [get_ports A2]
##Sch name = JC4
#set_property PACKAGE_PIN P18 [get_ports B2]					
	#set_property IOSTANDARD LVCMOS33 [get_ports B2]

# 7 SEGMENT PORT
#seven-segment LED display
set_property PACKAGE_PIN W7 [get_ports LEDout[6]]
set_property IOSTANDARD LVCMOS33 [get_ports LEDout[6]]
set_property PACKAGE_PIN W6 [get_ports LEDout[5]]
set_property IOSTANDARD LVCMOS33 [get_ports LEDout[5]]
set_property PACKAGE_PIN U8 [get_ports LEDout[4]]
set_property IOSTANDARD LVCMOS33 [get_ports LEDout[4]]
set_property PACKAGE_PIN V8 [get_ports LEDout[3]]
set_property IOSTANDARD LVCMOS33 [get_ports LEDout[3]]
set_property PACKAGE_PIN U5 [get_ports LEDout[2]]
set_property IOSTANDARD LVCMOS33 [get_ports LEDout[2]]
set_property PACKAGE_PIN V5 [get_ports LEDout[1]]
set_property IOSTANDARD LVCMOS33 [get_ports LEDout[1]]
set_property PACKAGE_PIN U7 [get_ports LEDout[0]]
set_property IOSTANDARD LVCMOS33 [get_ports LEDout[0]]
set_property PACKAGE_PIN U2 [get_ports Anodectivate[0]]
set_property IOSTANDARD LVCMOS33 [get_ports Anodectivate[0]]
set_property PACKAGE_PIN U4 [get_ports Anodectivate[1]]
set_property IOSTANDARD LVCMOS33 [get_ports Anodectivate[1]]
set_property PACKAGE_PIN V4 [get_ports Anodectivate[2]]
set_property IOSTANDARD LVCMOS33 [get_ports Anodectivate[2]]
set_property PACKAGE_PIN W4 [get_ports Anodectivate[3]]
set_property IOSTANDARD LVCMOS33 [get_ports Anodectivate[3]]


#VGA Connector
#Bank = 14, Pin name = ,					Sch name = VGA_R0
set_property PACKAGE_PIN G19 [get_ports VGA_Red[0]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Red[0]]
#Bank = 14, Pin name = ,					Sch name = VGA_R1
set_property PACKAGE_PIN H19 [get_ports VGA_Red[1]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Red[1]]
#Bank = 14, Pin name = ,					Sch name = VGA_R2
set_property PACKAGE_PIN J19 [get_ports VGA_Red[2]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Red[2]]
#Bank = 14, Pin name = ,					Sch name = VGA_R3
set_property PACKAGE_PIN N19 [get_ports VGA_Red[3]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Red[3]]
#Bank = 14, Pin name = ,					Sch name = VGA_B0
set_property PACKAGE_PIN N18 [get_ports VGA_Blue[0]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Blue[0]]
#Bank = 14, Pin name = ,						Sch name = VGA_B1
set_property PACKAGE_PIN L18 [get_ports VGA_Blue[1]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Blue[1]]
#Bank = 14, Pin name = ,					Sch name = VGA_B2
set_property PACKAGE_PIN K18 [get_ports VGA_Blue[2]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Blue[2]]
#Bank = 14, Pin name = ,						Sch name = VGA_B3
set_property PACKAGE_PIN J18 [get_ports VGA_Blue[3]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Blue[3]]
#Bank = 14, Pin name = ,					Sch name = VGA_G0
set_property PACKAGE_PIN J17 [get_ports VGA_Green[0]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Green[0]]
#Bank = 14, Pin name = ,				Sch name = VGA_G1
set_property PACKAGE_PIN H17 [get_ports VGA_Green[1]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Green[1]]
#Bank = 14, Pin name = ,					Sch name = VGA_G2
set_property PACKAGE_PIN G17 [get_ports VGA_Green[2]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Green[2]]
#Bank = 14, Pin name = ,				Sch name = VGA_G3
set_property PACKAGE_PIN D17 [get_ports VGA_Green[3]]
set_property IOSTANDARD LVCMOS33 [get_ports VGA_Green[3]]
#Bank = 14, Pin name = ,						Sch name = VGA_HS
set_property PACKAGE_PIN P19 [get_ports h_sync]
set_property IOSTANDARD LVCMOS33 [get_ports h_sync]
#Bank = 14, Pin name = ,				Sch name = VGA_VS
set_property PACKAGE_PIN R19 [get_ports v_sync]
set_property IOSTANDARD LVCMOS33 [get_ports v_sync]
