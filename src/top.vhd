--	Controller.VHD
--	Yasser Raies et Vincent Tessier
--	Hiver 2025

LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY TOP IS

	PORT(
		Clk		:	IN	STD_LOGIC;
		Reset		:	IN	STD_LOGIC;
		
		PC		:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
		WriteData	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
		AluResult	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);

END ENTITY TOP;

ARCHITECTURE rtl OF TOP IS

	SIGNAL PCIntern, WriteDataIntern, AluResultIntern	:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL Instruction, ReadData				:	STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MemRead, MemWrite				:	STD_LOGIC;
	
	BEGIN

		IMEM_INST	:	ENTITY work.IMEM(imem_arch)
			PORT MAP(
				PCIntern(7 DOWNTO 0),
				Instruction
			);

		MIPS_INST	:	ENTITY work.MIPS(rtl)
			PORT MAP(
				Instruction,
				ReadData,
				Reset,
				Clk,
				MemRead,
				MemWrite,
				PCIntern,
				WriteDataIntern,
				AluResultIntern
			);

		DMEM_INST	:	ENTITY work.DMEM(dmem_arch)
			PORT MAP(
				Clk,
				MemWrite,
				AluResultIntern,
				WriteDataIntern,
				ReadData
			);

	-- Assignation des sorties
	PC <= PCIntern;
	WriteData <= WriteDataIntern;
	AluResult <= AluResultIntern;

END ARCHITECTURE rtl;