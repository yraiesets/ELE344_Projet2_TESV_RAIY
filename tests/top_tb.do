vlib work 

vcom -93 -work work ../src/controller.vhd
vcom -93 -work work ../src/regfile.vhd
vcom -93 -work work ../src/ual.vhd
vcom -93 -work work ../src/datapath.vhd
vcom -93 -work work ../src/dmem.vhd
vcom -93 -work work ../src/imem.vhd
vcom -93 -work work ../src/mips.vhd
vcom -93 -work work ../src/top.vhd

vsim top
view wave

add wave -bin /TOP/Clk
add wave -bin /TOP/reset
add wave -dec /TOP/PC(9:2)
add wave -dec /TOP/WriteData
add wave -dec /TOP/AluResult

force clk 1 0 ns, 0 10 ns -repeat 20 ns
force reset 1, 0 15 ns
run 500 ns

vdel -all work