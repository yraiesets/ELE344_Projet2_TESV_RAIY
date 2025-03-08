--	Controller.VHD
--	Yasser Raies et Vincent Tessier
--	Hiver 2025

LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DATAPATH IS

    GENERIC(N   :   INTEGER :=  32);

    PORT(
        Clk         :   IN  STD_LOGIC;
        Reset       :   IN  STD_LOGIC;
        MemtoReg    :   IN  STD_LOGIC;
        Branch      :   IN  STD_LOGIC;
        AluSrc      :   IN  STD_LOGIC;
        RegDst      :   IN  STD_LOGIC;
        RegWrite    :   IN  STD_LOGIC;
        Jump        :   IN  STD_LOGIC;
        MemReadIn   :   IN  STD_LOGIC;
        MemWriteIn  :   IN  STD_LOGIC;
        AluControl  :   IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        Instruction :   IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
        ReadData    :   IN  STD_LOGIC_VECTOR(31 DOWNTO 0);

        MemReadOut  :   OUT STD_LOGIC;
        MemWriteOut :   OUT STD_LOGIC;
        PC          :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        AluResult   :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        WriteData   :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END ENTITY DATAPATH;

ARCHITECTURE rtl OF DATAPATH IS

	-- Signaux internes pour le banc de registres
	SIGNAL WriteReg                    					:   	STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL Result, SignImm, rd1, rd2   					:   	STD_LOGIC_VECTOR(N-1 DOWNTO 0);

	-- Signaux internes pour l'ALU
	SIGNAL SrcB, AluResultIntern						:	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL Zero, Cout							:	STD_LOGIC;

	-- Signaux internes pour le PC
	SIGNAL PCIntern, PCNext, PCPlus4					:	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL PCBranch, PCJump, PCNextBr					:	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL SignImmSh							:	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL PCSrc								:	STD_LOGIC;
	

BEGIN
    	-- Mul2-to-1 pour determine l'addresse d'ecriture
    	PROCESS(RegDst, Instruction) IS
    		BEGIN
        		CASE RegDst IS
            			WHEN '0'    =>      WriteReg    <=  Instruction(20 DOWNTO 16);
            			WHEN OTHERS =>      WriteReg    <=  Instruction(15 DOWNTO 11);
        		END CASE;
    	END PROCESS;

   	 -- Mul2-to-1 pour determine les donnees d'ecriture
    	PROCESS(MemtoReg, ReadData, AluResultIntern) IS
    		BEGIN
        		CASE MemtoReg IS
            			WHEN '1'	=>      Result		<=     ReadData;
            			WHEN OTHERS 	=>      Result          <=     AluResultIntern;
        		END CASE;
    	END PROCESS;

    	-- Extension de signe (SignExtend)
	SignImm <= STD_LOGIC_VECTOR(RESIZE(SIGNED(Instruction(15 DOWNTO 0)), 32));

    	-- Banc de registres
    	REGISTER_FILE	:	ENTITY work.RegFile(RegFile_arch)
        	PORT MAP(
            		Clk,
            		RegWrite,
            		Instruction(25 DOWNTO 21),
            		Instruction(20 DOWNTO 16),
            		WriteReg,
            		Result,
            		rd1,
            		rd2
        	);

	-- Mul2-to-1 pour determine la SrcB de l'ALU
	PROCESS(AluSrc, SignImm, rd2) IS
		BEGIN
			CASE AluSrc IS
				WHEN '1'	=>	SrcB		<=	SignImm;
				WHEN OTHERS	=>	SrcB		<=	rd2;
			END CASE;
	END PROCESS;
	
	-- UAL
	UAL		:	ENTITY work.UAL(rtl)
		PORT MAP(
			AluControl,
			rd1,
			SrcB,
			AluResultIntern,
			Cout,
			Zero
		);

	-- Determine le PCSrc
	PCSrc		<=	Branch AND Zero;
	
	-- Calcul des signaux utilises dans la logique du PC
	PCPlus4 	<=	STD_LOGIC_VECTOR(UNSIGNED(PCIntern) + TO_UNSIGNED(4, 32));
	PCJump		<=	PCPlus4(31 DOWNTO 28) & Instruction(25 DOWNTO 0) & "00";
	SignImmSh	<=	STD_LOGIC_VECTOR(SHIFT_LEFT(SIGNED(SignImm), 2));
	PCBranch	<=	STD_LOGIC_VECTOR(SIGNED(PCPlus4) + SIGNED(SignImmSh));

	-- Mul2-to-1 pour determiner PCNextBr
	PROCESS(PCSrc, PCBranch, PCPlus4) IS
		BEGIN
			CASE PCSrc IS
				WHEN '1'	=>	PCNextBr	<=	PCBranch;
				WHEN OTHERS	=>	PCNextBr	<=	PCPlus4;
			END CASE;
	END PROCESS;

	-- Mul2-to-1 pour determiner PCNext
	PROCESS(Jump, PCJump, PCNextBr) IS
		BEGIN
			CASE Jump IS
				WHEN '1'	=>	PCNext		<=	PCJump;
				WHEN OTHERS	=>	PCNext		<=	PCNextBr;
			END CASE;
	END PROCESS;

	-- Bascule D Synchrone avec remise a zero asynchrone (clear).
	PROCESS(Clk, Reset) IS
		BEGIN
			IF Reset = '1' THEN
				PCIntern <= (OTHERS => '0');
			ELSIF RISING_EDGE(Clk) THEN
				PCIntern <= PCNext;
			END IF;
	END PROCESS;

	-- Assignation des Sorties
	MemReadOut	<=	MemReadIn;
	MemWriteOut	<=	MemWriteIn;
	PC		<=	PCIntern;
	AluResult	<=	AluResultIntern;
	WriteData	<=	rd2;
	
END ARCHITECTURE rtl;