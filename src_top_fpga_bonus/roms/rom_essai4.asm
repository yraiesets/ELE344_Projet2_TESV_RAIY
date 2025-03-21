main:
    lui  $t0, 0x0000
    ori  $t0, $t0, 0x2000  # Adresse centièmes (0x2000)
    addi $t1, $t0, 4       # Adresse secondes   (0x2004)
    addi $t2, $t0, 8       # Adresse dizaines   (0x2008)
    addi $t3, $t0, 12      # Adresse minutes    (0x200C)

reset_all:
    sw   $zero, 0($t0)
    sw   $zero, 0($t1)
    sw   $zero, 0($t2)
    sw   $zero, 0($t3)

loop_cent:
    lw   $a0, 0($t0)
    addi $a0, $a0, 1
    sw   $a0, 0($t0)
    addi $v0, $zero, 10
    beq  $a0, $v0, inc_sec
    j delay_100ms

inc_sec:
    sw   $zero, 0($t0)
    lw   $a1, 0($t1)
    addi $a1, $a1, 1
    sw   $a1, 0($t1)
    addi $v0, $zero, 10
    beq  $a1, $v0, inc_ten_sec
    j delay_100ms

inc_ten_sec:
    sw   $zero, 0($t1)
    lw   $a2, 0($t2)
    addi $a2, $a2, 1
    sw   $a2, 0($t2)
    addi $v0, $zero, 6
    beq  $a2, $v0, inc_min
    j delay_100ms

inc_min:
    sw   $zero, 0($t2)
    lw   $a3, 0($t3)
    addi $a3, $a3, 1
    sw   $a3, 0($t3)
    addi $v0, $zero, 10
    beq  $a3, $v0, reset_min
    j delay_100ms

reset_min:
    sw   $zero, 0($t3)
    j delay_100ms

delay_100ms:
    lui  $t4, 0x004C
    ori  $t4, $t4, 0x4B40 # (5000000 en decimal pour 100ms à 50MHz)

delay_loop:
    addi $t4, $t4, -1
    bne  $t4, $zero, delay_loop
    j loop_cent
