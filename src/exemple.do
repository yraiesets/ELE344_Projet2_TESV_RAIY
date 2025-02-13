# Exemple simple de fichier .do
#
# Fonction: Genere toutes les combinaisons d'entrée
#           sur les ports a, b et c
#
# Auteur: Yves Blaquière
#
# ----------------------------------------------------
# 1) Créer la librarie work
vlib work

# 2) Compiler exemple.vhd avec VHDL 1993
vcom -93 -work work exemple.vhd

# 3) Démarrer la simulation avec le design
#    "exemple" defini dans exemple.vhd
vsim exemple

# 4) Ouvrir certaines fenêtres pour visualiser
view structure
view signals
view wave
view list

# 5) Montrer tous les signaux dans la fenêtre wave
add wave -r *
add list -r *

# 6) Générer les patrons d'entrée et exécuter pour 20 ns
force a 0 0, 1 4 ns -repeat 8 ns
force b 0 0, 1 2 ns -repeat 4 ns
force c 0 0, 1 1 ns -repeat 2 ns
run 20 ns

# REMARQUE: la commande « force a_i 0 0, 1 4 ns -repeat 8 ns »
#   force '0' sur le signal a à 0 ns
#   force '1' sur le signal a à 4 ns
#   et répète cette séquence à toutes les 8 ns
