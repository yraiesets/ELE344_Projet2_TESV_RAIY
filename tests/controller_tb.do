vlib work

vcom -93 -work work ../src_top/controller.vhd
vcom -93 -work work ../src_top/controller_tb.vhd

vsim -gui work.CONTROLLER_tb(valeurs_forcees)


view structure
view signals
view wave

add wave -r *
wave zoom full

run 400ns

vdel -lib work -all