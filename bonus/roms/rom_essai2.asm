main:
    # Boucle infinie pour incrémenter le temps
    li $t0, 0       # Compteur de 0.1s
    li $t1, 0       # Compteur de secondes
    li $t2, 0       # Compteur de dizaines de secondes
    li $t3, 0       # Compteur de minutes

loop_timer:
    # Attendre 0.1s en utilisant Count Register
    jal wait_100ms

    # Incrémenter le compteur de 0.1s
    addi $t0, $t0, 1
    li $t4, 10
    beq $t0, $t4, increment_seconds
    j loop_timer

increment_seconds:
    li $t0, 0       # Réinitialiser les 0.1s
    addi $t1, $t1, 1
    li $t4, 10
    beq $t1, $t4, increment_tens

    j loop_timer

increment_tens:
    li $t1, 0       # Réinitialiser les secondes
    addi $t2, $t2, 1
    li $t4, 6
    beq $t2, $t4, increment_minutes

    j loop_timer

increment_minutes:
    li $t2, 0       # Réinitialiser les dizaines de secondes
    addi $t3, $t3, 1
    j loop_timer

# ---------------------------
# Attente de 100ms avec le registre Count du CP0
# ---------------------------
wait_100ms:
    mfc0 $t5, $9    # Lire le registre Count (horloge interne)
    li $t6, 5000000 # Valeur pour 100ms (50 MHz * 0.1s)
wait_loop:
    mfc0 $t7, $9
    sub $t7, $t7, $t5
    blt $t7, $t6, wait_loop
    jr $ra
