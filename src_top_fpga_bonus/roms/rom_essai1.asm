main:

# Si F = 50 Mhz, alors un cycle se fait en 20 ns = 2*10^-8 seconde.

addi	$t0, $zero, 0x0 # $t0 contiendra les centiemes de secondes
addi	$t1, $zero, 0x0 # $t1 contiendra les secondes
addi	$t2, $zero, 0x0 # $t2 contiendra les dizaines de secondes
addi	$t3, $zero, 0x0 # $t3 contiendra les minutes
addi	$t5, $zero, 0xA # limite pour les centiemes, secondes et minutes
addi	$t6, $zero, 0x6 # limite pour les dizaines de secondes

# Preparation des addresses memoires
ori	$s0, $zero, 0x2000 # Addresse 0x0
ori	$s1, $zero, 0x2004 # Addresse 0x4
ori	$s2, $zero, 0x2008 # Addresse 0x8
ori	$s3, $zero, 0x200C # Addresse 0xC

begin:
	# Nombre de cycles par 0.1 seconde = 0.1/2*10^-8 = 5000000 = 0x004C4B40
	# Nombre de cycles par 1 seconde = 1/2*10^-8 = 50000000 = 0x02FAF080
	# Nombre de cycles par 10 secondes = 10/2*10^-8 = 500000000 = 0x1DCD6500
	# Nombre de cycles par 60 secondes = 60/2*10^-8 = 3000000000 = 0xB2D05E00
	
	lui	$t4, 0x004C
	ori	$t4, $t4, 0x4B40 # $t4 contient maintenant le nombre de cycle pour incrementer les centiemes de secondes
	jal	chrono
	sw	$t0, 0($s0)
	addi	$t0, $t0, 0x1	
	# On verifie si on est pret a passer aux secondes
	slt	$at, $t0, $t5
	# Si jamais on a atteint 10, on passe aux secondes apres avoir RESET le timer
	beq	$at, $zero, remise_zero_centiemes
	#Sinon on recommence
	j begin
		
remise_zero_centiemes:
	addi	$t0, $zero, 0
	# On est rendu aux secondes
	j secondes
	
secondes:
	lui	$t4, 0x02FA
	ori	$t4, $t4, 0xF080 # $t4 contient maintenant le nombre de cycle pour incrementer les secondes
	jal	chrono
	sw	$t1, 0($s1)
	addi	$t1, $t1, 0x1	
	# On repete la meme logique pour tout le reste
	slt	$at, $t1, $t5
	beq	$at, $zero, remise_zero_secondes
	j	begin
	
remise_zero_secondes:
	addi	$t1, $zero, 0
	j dizaines_secondes
	

dizaines_secondes:
	lui	$t4, 0x1DCD
	ori	$t4, $t4, 0x6500
	jal	chrono
	sw	$t2, 0($s2)
	addi	$t2, $t2, 1
	slt	$at, $t2, $t6
	beq	$at, $zero, remise_zero_dizaines_secondes
	j	begin
	
remise_zero_dizaines_secondes:
	addi	$t2, $zero, 0
	j minutes
	
minutes:
	lui	$t4, 0xB2D0
	ori	$t4, $t4, 0x5E00
	jal	chrono
	sw	$t3, 0($s3)
	addi	$t3, $t3, 1
	slt	$at, $t3, $t5
	beq	$at, $zero, remise_zero_minutes
	j begin
	
remise_zero_minutes:
	addi	$t3, $zero, 0
	j begin
		 	

chrono:
    addi    $t7, $zero, 0        # Initialisation du compteur de d�lai
    
attente:
    addi    $t7, $t7, 1          # Incr�menter le compteur de d�lai
    slt     $at, $t7, $t4        # $at = 1 si $t7 < $t4, sinon 0
    bne     $at, $zero, attente  # Tant que $t7 < $t4, continuer la boucle
    jr      $ra                  # Retour � l'appelant
