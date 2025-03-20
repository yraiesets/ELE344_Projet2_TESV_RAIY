# Horloge FPGA principale à 50 MHz (période de 20 ns)
create_clock -name MAX10_CLK1_50 -period 20.000 [get_ports {MAX10_CLK1_50}]
derive_clock_uncertainty
