# 1) Creer la librarie work
vlib work

# 2) Compiler exemple.vhd avec VHDL 1993
vcom -93 -work work ../src/controller.vhd
vcom -93 -work work ../src/controller_tb.vhd

# 3) Demarrer la simulation avec le design
vsim -gui work.CONTROLLER_tb(valeurs_forcees)

# 4) Ouvrir certaines fenetres pour visualiser
view structure
view signals
view wave

# 5) Montrer tous les signaux dans la fenetre wave
add wave -r *
wave zoom full

# 6) Execution de la simulation pour 500 nanosecondes
run 400ns

# Fermer le fichier transcript avant suppression
vdel -lib work -all