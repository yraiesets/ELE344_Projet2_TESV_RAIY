# Spécifications de contraintes pour diriger la synthèse logique du design
#

# Contrainte de la période maximum de l'horloge à 20 ns (Fmin=50MHz). 
# Cette contrainte concerne les chemins combinatoires entre les bascules. 
create_clock -name {CLK} -period 20.000 -waveform { 0.000 10.000 } [get_ports {MAX10_CLK1_50}]

# Calcul de l'incertitude d'horloge automatique
derive_clock_uncertainty