addi  $t0, $zero, 0
addi  $t1, $zero, 0
addi  $t2, $zero, 0
addi  $t3, $zero, 0
addi  $t5, $zero, 10
addi  $t6, $zero, 6
addi  $s0, $zero, 8192
addi  $s1, $zero, 8196
addi  $s2, $zero, 8200
addi  $s3, $zero, 8204

loop_cent:
    lui   $t4, 0x004c
    ori   $t4, $t4, 0x4b40
    jal   wait_loop
    sw    $t0, 0($s0)
    addi  $t0, $t0, 1
    slt   $at, $t0, $t5
    bne   $at, $zero, loop_cent
    addi  $t0, $zero, 0
    j loop_sec

loop_sec:
    lui   $t4, 0x02fa
    ori   $t4, $t4, 0xf080
    jal   wait_loop
    sw    $t1, 0($s1)
    addi  $t1, $t1, 1
    slt   $at, $t1, $t5
    bne   $at, $zero, loop_cent
    addi  $t1, $zero, 0
    j loop_ten_sec

loop_ten_sec:
    lui   $t4, 0x1dcd
    ori   $t4, $t4, 0x6500
    jal   wait_loop
    sw    $t2, 0($s2)
    addi  $t2, $t2, 1
    slt   $at, $t2, $t6
    bne   $at, $zero, loop_cent
    addi  $t2, $zero, 0
    j loop_min

loop_min:
    lui   $t4, 0xb2d0
    ori   $t4, $t4, 0x5e00
    jal   wait_loop
    sw    $t3, 0($s3)
    addi  $t3, $t3, 1
    slt   $at, $t3, $t5
    bne   $at, $zero, loop_cent
    addi  $t3, $zero, 0
    j loop_cent

wait_loop:
    addi  $t7, $zero, 0
wait_loop_label:
    addi  $t7, $t7, 1
    slt   $at, $t7, $t4
    bne   $at, $zero, wait_loop_label
    jr    $ra
