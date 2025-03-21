# Chronomètre numérique en MIPS (sans pseudo-instructions, sans LUI ni ORI)

# Adresses mémoire fixes :
# 0x0: dixièmes de seconde (0-9)
# 0x4: secondes unités (0-9)
# 0x8: dizaines de secondes (0-5)
# 0xC: minutes unités (0-9)

main:
    addi $t0, $zero, 0         # Compteur cycles (50 MHz)
    addi $t1, $zero, 0         # Compteur intermédiaire
    addi $t2, $zero, 0         # Compteur 0.1 seconde

boucle:
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    
    # Compter jusqu'à 5000 cycles
    addi $t3, $zero, 5000
    beq $t1, $t3, compte_5000
    j boucle

compte_5000:
    addi $t1, $zero, 0
    addi $t2, $t2, 1

    # Compter 1000 fois 5000 cycles (total 5,000,000 cycles)
    addi $t3, $zero, 1000
    beq $t2, $t3, inc_dixieme
    j boucle

inc_dixieme:
    addi $t0, $zero, 0
    addi $t2, $zero, 0

    lw $t4, 0($zero)
    addi $t4, $t4, 1
    sw $t4, 0($zero)

    addi $t5, $zero, 10
    beq $t4, $t5, reset_dixieme
    j boucle

reset_dixieme:
    sw $zero, 0($zero)

    lw $t6, 4($zero)
    addi $t6, $t6, 1
    sw $t6, 4($zero)

    addi $t5, $zero, 10
    beq $t6, $t5, reset_seconde
    j boucle

reset_seconde:
    sw $zero, 4($zero)

    lw $t7, 8($zero)
    addi $t7, $t7, 1
    sw $t7, 8($zero)

    addi $t5, $zero, 6
    beq $t7, $t5, reset_dizaine_sec
    j boucle

reset_dizaine_sec:
    sw $zero, 8($zero)

    lw $t8, 12($zero)
    addi $t8, $t8, 1
    sw $t8, 12($zero)

    addi $t5, $zero, 10
    beq $t8, $t5, reset_minute
    j boucle

reset_minute:
    sw $zero, 12($zero)

    j boucle
