.text
.globl main

main:
    # Définition des adresses mémoire-mappées
    addi $t4, $zero, 0x2000  # Adresse pour les centièmes de secondes
    addi $t5, $zero, 0x2004  # Adresse pour les secondes
    addi $t6, $zero, 0x2008  # Adresse pour les dizaines de secondes
    addi $t7, $zero, 0x200C  # Adresse pour les minutes

    # Initialisation des compteurs
    addi $s0, $zero, 0  # Centièmes
    addi $s1, $zero, 0  # Secondes
    addi $s2, $zero, 0  # Dizaines de secondes
    addi $s3, $zero, 0  # Minutes

    # Valeurs seuils pour comparaison
    addi $s4, $zero, 10  # Valeur de comparaison pour centièmes et secondes
    addi $s5, $zero, 6   # Valeur de comparaison pour dizaines de secondes
    addi $s6, $zero, 60  # Valeur de comparaison pour minutes

loop:
    # Attendre 100ms
    addi $t0, $zero, 5000000  # Nombre de cycles pour 100ms
    addi $t1, $zero, 0
wait_loop:
    addi $t1, $t1, 1
    slt $t2, $t1, $t0
    beq $t2, $zero, end_wait
    j wait_loop
end_wait:

    # Mettre à jour les centièmes
    sw $s0, 0($t4)  # Écrire dans l'afficheur des centièmes
    addi $s0, $s0, 1
    slt $t2, $s0, $s4  # Vérifier si $s0 < 10
    beq $t2, $zero, reset_centiemes
    j loop

reset_centiemes:
    addi $s0, $zero, 0
    sw $s1, 0($t5)  # Écrire dans l'afficheur des secondes
    addi $s1, $s1, 1
    slt $t2, $s1, $s4  # Vérifier si $s1 < 10
    beq $t2, $zero, reset_secondes
    j loop

reset_secondes:
    addi $s1, $zero, 0
    sw $s2, 0($t6)  # Écrire dans l'afficheur des dizaines de secondes
    addi $s2, $s2, 1
    slt $t2, $s2, $s5  # Vérifier si $s2 < 6
    beq $t2, $zero, reset_dizaines
    j loop

reset_dizaines:
    addi $s2, $zero, 0
    sw $s3, 0($t7)  # Écrire dans l'afficheur des minutes
    addi $s3, $s3, 1
    slt $t2, $s3, $s6  # Vérifier si $s3 < 60
    beq $t2, $zero, reset_minutes
    j loop

reset_minutes:
    addi $s3, $zero, 0
    j loop  # Recommencer
