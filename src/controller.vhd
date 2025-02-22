--	Controller.VHD
--	Yasser Raies et Vincent Tessier
--	Hiver 2025

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CONTROLLER IS
	PORT (
		OP, Funct    : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		MemtoReg     : OUT STD_LOGIC;
		MemWrite     : OUT STD_LOGIC;
		MemRead      : OUT STD_LOGIC;
		Branch       : OUT STD_LOGIC;
		ALUSrc       : OUT STD_LOGIC;
		RegDst       : OUT STD_LOGIC;
		RegWrite     : OUT STD_LOGIC;
		Jump         : OUT STD_LOGIC;
		AluControl   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END CONTROLLER;

ARCHITECTURE rtl OF CONTROLLER IS

	SIGNAL MtoReg, MemW, MemR, MRead, Bran, ALUS, RegD, RegW, J : STD_LOGIC;
	SIGNAL ALUCode : STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN

	MainDecoder : PROCESS (OP, MtoReg, MemW, MemR, MRead, Bran, ALUS, RegD, RegW, J, ALUCode)
	BEGIN
		CASE (OP) IS
			WHEN "000000" =>  -- R-Type
				RegW    <= '1';
				RegD    <= '1';
				ALUS    <= '0';
				Bran    <= '0';
				MemR    <= '0';
				MemW    <= '0';
				MtoReg  <= '0';
				ALUCode <= "10";
				J       <= '0';
				-- HexCode => X"304"

			WHEN "100011" =>  -- Lw
				RegW    <= '1';
				RegD    <= '0';
				ALUS    <= '1';
				Bran    <= '0';
				MemR    <= '1';
				MemW    <= '0';
				MtoReg  <= '1';
				ALUCode <= "00";
				J       <= '0';
				-- HexCode => X"2A8"

			WHEN "101011" =>  -- Sw
				RegW    <= '0';
				RegD    <= '-';
				ALUS    <= '1';
				Bran    <= '0';
				MemR    <= '0';
				MemW    <= '1';
				MtoReg  <= '-';
				ALUCode <= "00";
				J       <= '0';
				-- HexCode => X"090"

			WHEN "000100" =>  -- Beq
				RegW    <= '0';
				RegD    <= '-';
				ALUS    <= '0';
				Bran    <= '1';
				MemR    <= '0';
				MemW    <= '0';
				MtoReg  <= '-';
				ALUCode <= "01";
				J       <= '0';
				-- HexCode => X"042"

			WHEN "001000" =>  -- Addi
				RegW    <= '1';
				RegD    <= '0';
				ALUS    <= '1';
				Bran    <= '0';
				MemR    <= '0';
				MemW    <= '0';
				MtoReg  <= '0';
				ALUCode <= "00";
				J       <= '0';
				-- HexCode => X"280"

			WHEN OTHERS =>  -- J
				RegW    <= '0';
				RegD    <= '-';
				ALUS    <= '-';
				Bran    <= '-';
				MemR    <= '0';
				MemW    <= '0';
				MtoReg  <= '-';
				ALUCode <= "00";
				J       <= '0';
				-- HexCode => X"001"
		END CASE;
	END PROCESS;

	ALUDecoder : PROCESS
	BEGIN
		
	END PROCESS;

END rtl;
