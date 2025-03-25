vlib work 

vcom -93 -work work ../src_top_fpga/controller.vhd
vcom -93 -work work ../src_top_fpga/regfile.vhd
vcom -93 -work work ../src_top_fpga/ual.vhd
vcom -93 -work work ../src_top_fpga/datapath.vhd
vcom -93 -work work ../src_top_fpga/dmem.vhd
vcom -93 -work work ../src_top_fpga/imem.vhd
vcom -93 -work work ../src_top_fpga/mips.vhd
vcom -93 -work work ../src_top_fpga/top.vhd

vsim top
view wave

add wave -bin /TOP/Clk
add wave -bin /TOP/reset
add wave -dec /TOP/PC(9:2)
add wave -dec /TOP/WriteData
add wave -dec /TOP/DataAddress

force clk 1 0 ns, 0 10 ns -repeat 20 ns
force reset 1, 0 15 ns
run 500 ns

vdel -all work