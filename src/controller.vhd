--	Controller.VHD
--	Yasser Raies et Vincent Tessier
--	Hiver 2025

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY controller IS 
PORT (
	OP, Funct: IN std_logic_vector(5 downto 0);
	MemtoReg, MemWrite, MemRead, Branch, ALUSrc,
	RegDst, RegWrite, Jump: OUT std_logic; 
	AluControl: OUT std_logic_vector(3 downto 0));

END Controller;

ARCHITECTURE logique of controller is 

  SIGNAL MtoReg, MemW, MemR, MRead, Bran, ALUS, RegD, RegW, J : STD_LOGIC;
  SIGNAL ALUCode : STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN

MainDecoder : PROCESS(OP, MtoReg, MemW, MemR, MRead, Bran, ALUS, RegD, RegW, J, ALUCode) 

BEGIN
	case (OP) is 
	when "000000" =>  -- R-Type
		RegW <= '1'; 
		RegD <= '1';
		ALUS <= '0';
		Bran <= '0';
		MemR <= '0';
		MemW <= '0';
		MtoReg <= '0';
		ALUCode <= "10";
		J <= '0';
	--	HexCode => X"304"
	
	when "100011" => --Lw
		RegW <= '1'; 
		RegD <= '0';
		ALUS <= '1';
		Bran <= '0';
		MemR <= '1';
		MemW <= '0';
		MtoReg <= '1';
		ALUCode <= "00";
		J <= '0';
	--	HexCode => X"2A8"
	
	when "101011" => --Sw
		RegW <= '0'; 
		RegD <= '-';
		ALUS <= '1';
		Bran <= '0';
		MemR <= '0';
		MemW <= '1';
		MtoReg <= '-';
		ALUCode <= "00";
		J <= '0';
	--	HexCode => X"090"

	when "000100" => --Beq
		RegW <= '0'; 
		RegD <= '-';
		ALUS <= '0';
		Bran <= '1';
		MemR <= '0';
		MemW <= '0';
		MtoReg <= '-';
		ALUCode <= "01";
		J <= '0';
	--	HexCode => X"042"

	when "001000" => --Addi
		RegW <= '1'; 
		RegD <= '0';
		ALUS <= '1';
		Bran <= '0';
		MemR <= '0';
		MemW <= '0';
		MtoReg <= '0';
		ALUCode <= "00";
		J <= '0';
	--	HexCode => X"280"

	when others => --J
		RegW <= '0'; 
		RegD <= '-';
		ALUS <= '-';
		Bran <= '-';
		MemR <= '0';
		MemW <= '0';
		MtoReg <= '-';
		ALUCode <= "00";
		J <= '0';
	--	HexCode => X"001"

	end case;
END PROCESS;

ALUDecoder : PROCESS
BEGIN

END PROCESS;

END logique;