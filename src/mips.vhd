LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY MIPS IS

	PORT(
		Instruction	:	IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		ReadData	:	IN	STD_LOGIC_VECTOR(31 DOWNTO 0);
		Reset		:	IN	STD_LOGIC;
		Clock		:	IN	STD_LOGIC;

		MemRead		:	OUT	STD_LOGIC;
		MemWrite	:	OUT	STD_LOGIC;
		PC		:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
		WriteData	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0);
		AluResult	:	OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);

END ENTITY MIPS;

ARCHITECTURE rtl OF MIPS IS
	-- Signaux internes entre le controleur et le datapath
	SIGNAL MemtoReg, Branch, Jump			:	STD_LOGIC;
	SIGNAL AluSrc, RegDst, RegWrite			:	STD_LOGIC;
	SIGNAL MemReadIn, MemWriteIn			:	STD_LOGIC;
	SIGNAL AluControl				:	STD_LOGIC_VECTOR(3 DOWNTO 0);

	BEGIN

		CONTROLLER_INST		:	ENTITY work.CONTROLLER(rtl)
			PORT MAP(

				Instruction(31 DOWNTO 26),	-- OP
				Instruction(5 DOWNTO 0),	-- Funct
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

		DATAPATH_INST		:	ENTITY work.DATAPATH(rtl)
			PORT MAP(
				Clock,
				Reset,
				MemtoReg,
				Branch,
				AluSrc,
				RegDst,
				RegWrite,
				Jump,
				MemReadIn,
				MemWriteIn,
				AluControl,
				Instruction,
				ReadData,
				MemReadOut,
				MemWriteOut,
				PC,
				WriteData,
				AluResult
			);

END ARCHITECTURE rtl;