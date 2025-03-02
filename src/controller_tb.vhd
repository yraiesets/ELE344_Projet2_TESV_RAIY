LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CONTROLLER_TB IS

END ENTITY CONTROLLER_TB;

ARCHITECTURE valeurs_forcees OF CONTROLLER_tb IS

	SIGNAL	OP, Funct	:	STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
	SIGNAL	MemtoReg	:	STD_LOGIC;
	SIGNAL	MemWrite	:	STD_LOGIC;
	SIGNAL	MemRead   	:	STD_LOGIC;
	SIGNAL	Branch    	:	STD_LOGIC;
	SIGNAL	AluSrc    	:	STD_LOGIC;
	SIGNAL	RegDst    	:	STD_LOGIC;
	SIGNAL	RegWrite  	:	STD_LOGIC;
	SIGNAL	Jump      	:	STD_LOGIC;
	SIGNAL	AluControl	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	BEGIN
	
		DUT_CONTROLLER	:	ENTITY work.CONTROLLER(rtl)
			PORT MAP(
					OP,
					Funct,
					MemtoReg,
					MemWrite,
					MemRead,
					Branch,
					AluSrc,
					RegDst,
					RegWrite,
					Jump,
					AluControl
				);
					
		
		-- Generateur de stimuli
		stimulus	:	PROCESS
		BEGIN
			-- R-Type Instruction
			OP <= "000000";
			Funct <= "100000"; -- Add
			WAIT FOR 25 ns;
			
			ASSERT(RegWrite = '1' AND RegDst = '1' AND AluSrc = '0' AND Branch = '0' AND MemRead = '0' AND MemWrite = '0' AND MemtoReg = '0' AND  Jump = '0' AND AluControl = "0010")
				REPORT "Erreur R-Type Instruction - Function Add" SEVERITY ERROR;

			OP <= "000000";
			Funct <= "100010"; -- Sub
			WAIT FOR 25 ns;

			ASSERT(RegWrite = '1' AND RegDst = '1' AND AluSrc = '0' AND Branch = '0' AND MemRead = '0' AND MemWrite = '0' AND MemtoReg = '0' AND Jump = '0' AND AluControl = "0110")
				REPORT "Erreur R-Type Instruction - Function Sub" SEVERITY ERROR;

			OP <= "000000";
			Funct <= "100100"; -- And
			WAIT FOR 25 ns;

			ASSERT(RegWrite = '1' AND RegDst = '1' AND AluSrc = '0' AND Branch = '0' AND MemRead = '0' AND MemWrite = '0' AND MemtoReg = '0' AND Jump = '0' AND AluControl = "0000")
				REPORT "Erreur R-Type Instruction - Function And" SEVERITY ERROR;

			OP <= "000000";
			Funct <= "100101"; -- Or
			WAIT FOR 25 ns;

			ASSERT(RegWrite = '1' AND RegDst = '1' AND AluSrc = '0' AND Branch = '0' AND MemRead = '0' AND MemWrite = '0' AND MemtoReg = '0' AND Jump = '0' AND AluControl = "0001")
				REPORT "Erreur R-Type Instruction - Function Or" SEVERITY ERROR;

			OP <= "000000";
			Funct <= "101010"; -- Slt
			WAIT FOR 25 ns;

			ASSERT(RegWrite = '1' AND RegDst = '1' AND AluSrc = '0' AND Branch = '0' AND MemRead = '0' AND MemWrite = '0' AND MemtoReg = '0' AND Jump = '0' AND AluControl = "0111")
				REPORT "Erreur R-Type Instruction - Function Slt" SEVERITY ERROR;

			-- LW Instruction
			OP <= "100011";
			Funct <= "------";
			WAIT FOR 25 ns;

			ASSERT(RegWrite = '1' AND RegDst = '0' AND AluSrc = '1' AND Branch = '0' AND MemRead = '1' AND MemWrite = '0' AND MemtoReg = '1' AND Jump = '0' AND AluControl = "0010")
				REPORT "Erreur LW Instruction" SEVERITY ERROR;

			-- SW Instruction
			OP <= "101011";
			Funct <= "------";
			WAIT FOR 25 ns;

			ASSERT(RegWrite = '0' AND RegDst = '-' AND AluSrc = '1' AND Branch = '0' AND MemRead = '0' AND MemWrite = '1' AND MemtoReg = '-' AND Jump = '0' AND AluControl = "0010")
				REPORT "Erreur SW Instruction" SEVERITY ERROR;

			-- BEQ Instruction
			OP <= "000100";
			Funct <= "------";
			WAIT FOR 25 ns;

			ASSERT(RegWrite = '0' AND RegDst = '-' AND AluSrc = '0' AND Branch = '1' AND MemRead = '0' AND MemWrite = '0' AND MemtoReg = '-' AND Jump = '0' AND AluControl = "0110")
				REPORT "Erreur BEQ Instruction" SEVERITY ERROR;

			-- Addi Instruction
			OP <= "001000";
			Funct <= "------";
			WAIT FOR 25 ns;

			ASSERT(RegWrite = '1' AND RegDst = '0' AND AluSrc = '1' AND Branch = '0' AND MemRead = '0' AND MemWrite = '0' AND MemtoReg = '0' AND Jump = '0' AND AluControl = "0010")
				REPORT "Erreur ADDI Instruction" SEVERITY ERROR;

			-- Jump Instruction
			OP <= "000010";
			Funct <= "------";
			WAIT FOR 25 ns;
			
			ASSERT(RegWrite = '0' AND RegDst = '-' AND AluSrc = '-' AND Branch = '-' AND MemRead = '0' AND MemWrite = '0' AND MemtoReg = '-' AND Jump = '1' AND AluControl = "----")
				REPORT "Erreur BEQ Instruction" SEVERITY ERROR;

			END PROCESS stimulus;
					
END ARCHITECTURE valeurs_forcees;