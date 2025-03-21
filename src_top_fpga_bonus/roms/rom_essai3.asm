main:
    addi  $t4, $zero, 0x2000
    addi  $t5, $zero, 0x2004
    addi  $t6, $zero, 0x2008
    addi  $t7, $zero, 0x200C

    addi  $s0, $zero, 0
    addi  $s1, $zero, 0
    addi  $s2, $zero, 0
    addi  $s3, $zero, 0

loop:
    lui   $t0, 0x004C
    ori   $t0, $t0, 0x4B40

    jal   delay

    sw    $s0, 0($t4)
    addi  $s0, $s0, 1
    slti  $at, $s0, 10
    bne   $at, $zero, loop

    addi  $s0, $zero, 0
    sw    $s1, 0($t5)
    addi  $s1, $s1, 1
    slti  $at, $s1, 10
    bne   $at, $zero, loop

    addi  $s1, $zero, 0
    sw    $s2, 0($t6)
    addi  $s2, $s2, 1
    slti  $at, $s2, 6
    bne   $at, $zero, loop

    addi  $s2, $zero, 0
    sw    $s3, 0($t7)
    addi  $s3, $s3, 1
    slti  $at, $s3, 60
    bne   $at, $zero, loop

    addi  $s3, $zero, 0
    j     loop

delay:
    addi  $t1, $zero, 0

wait_loop:
    addi  $t1, $t1, 1
    slt   $at, $t1, $t0
    bne   $at, $zero, wait_loop
    jr    $ra
