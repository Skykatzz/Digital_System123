
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
