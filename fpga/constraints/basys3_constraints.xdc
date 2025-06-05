## Clock signal (100MHz)
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]

## LEDs (using only LED0)
set_property -dict { PACKAGE_PIN U16  IOSTANDARD LVCMOS33 } [get_ports led]