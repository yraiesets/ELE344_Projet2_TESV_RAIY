main:	
	addi	$t6,	$zero,	0x10 		# Compteur pour sll
	addi	$t1,	$zero,	0x004C 		# Centiemes

centiemes:
	beq	$t6,	$zero,	next
	add	$t1,	$t1,	$t1
	addi	$t6,	$t6,	-1
	j	centiemes

next:	
	addi	$t1,	$t1,	0x4B40
	
	sw	$t1,	8224($zero)
	
	addi	$t6,	$zero,	0xC 		# Compteur pour sll
	addi	$t1,	$zero,	0x02FAF		# Secondes

secondes:
	beq	$t6,	$zero,	next_2
	add	$t1,	$t1,	$t1
	addi	$t6,	$t6,	-1
	j	secondes
	
next_2:
	addi	$t1,	$t1,	0x0080
	
	sw	$t1,	8228($zero)
	
	addi	$t6,	$zero,	0x10		# Compteur pour sll
	addi	$t1,	$zero,	0x1DCD		# Dizaines de secondes
	
dizaines:
	beq	$t6,	$zero,	next_3
	add	$t1,	$t1,	$t1
	addi	$t6,	$t6,	-1
	j	dizaines
	
next_3:
	addi	$t1,	$t1,	0x6500
	
	sw	$t1,	8232($zero)
	
	addi	$t6,	$zero,	0x10
	addi 	$t1,	$zero,	-19760	# Minutes
	
minutes:
	beq	$t6,	$zero,	next_4
	add	$t1,	$t1,	$t1
	addi	$t6,	$t6,	-1
	j	minutes
	
next_4:
	addi	$t1,	$t1,	24064
	
	sw	$t1,	8236($zero)
		
loop:

	# $t1 : Centiemes
	# $t2 : Secondes
	# $t3 : Dizaines
	# $t4 : Minutes
	# $s0 : Limites pour centiemes, secondes et minutes
	# $s1 :	Limites pour les dizaines
	
	addi	$s0,	$zero,	0x9
	addi	$s1,	$zero,	0x5
	lw	$t1,	8224($zero)
	
increment_centiemes:
	
	
	
	
	
	
	
	
	
				
	
	
	
	
	
	
		
	
	
	
	
	
	
		
	

	
	
	


					

	
	
	
	
		
	
