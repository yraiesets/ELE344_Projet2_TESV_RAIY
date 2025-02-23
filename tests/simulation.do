# 1) Créer la librarie work
vlib work

# 2) Compiler exemple.vhd avec VHDL 1993
vcom -93 -work work ../src/controller.vhd
vcom -93 -work work ../src/controller_tb.vhd

# 3) Démarrer la simulation avec le design
vsim -gui work.CONTROLLER_tb(valeurs_forcees)

# 4) Ouvrir certaines fenêtres pour visualiser
view structure
view signals
view wave

# 5) Montrer tous les signaux dans la fenêtre wave
add wave -r *

# 6) Exécution de la simulation pour 500 nanosecondes
run 500ns

# Fermer le fichier transcript avant suppression
vdel -lib work -all