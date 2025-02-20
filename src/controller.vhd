--	Controller.VHD
--	Yasser Raies et Vincent Tessier
--	Hiver 2025

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY controller IS 
PORT (
	OP, Funct: IN std_logic_vector(5 downto 0);
	MemtoReg, MemWrite, MemRead, Branch, AluSrc,
	RegDst, RegWrite, MemRead, Branch, AluSrc,
	AluControl : OUT std_logi_vector(3 downto 0));

END Controller;

ARCHITECTURE logique of controller is 


MainDecoder : PROCESS(OP, Regwrite, RegDst, ALUSrc, Branch, MemRead, MemWrite, MemtoReg, ALUOp, Jump) 
	BEGIN
	
	case OP is 
	when "000000"   -- R-Type
		RegWrite => 1; 
		RegDst => 1;
		ALUSrc => 0;
		Branch => 0;
		MemRead => 0;
		MemWrite => 0;
		MemtoReg => 0;
		ALUOp => B"10";
		Jump => "0"
	--	HexCode => X"304"
	
	when "100011"	--Lw
		RegWrite => 1; 
		RegDst => 0;
		ALUSrc => 1;
		Branch => 0;
		MemRead => 1;
		MemWrite => 0;
		MemtoReg => 1;
		ALUOp => B"00";
		Jump => "0"
	--	HexCode => X"2A8"
	
	when "101011"	--Sw
		RegWrite => 0; 
		RegDst => '-';
		ALUSrc => 1;
		Branch => 0;
		MemRead => 0;
		MemWrite => 1;
		MemtoReg => '-';
		ALUOp => B"00";
		Jump => "0"
	--	HexCode => X"090"

	when "000100"	--Beq
		RegWrite => 0; 
		RegDst => '-';
		ALUSrc => 0;
		Branch => 1;
		MemRead => 0;
		MemWrite => 0;
		MemtoReg => '-';
		ALUOp => B"01";
		Jump => "0"
	--	HexCode => X"042"

	when "001000"	--Addi
		RegWrite => 1; 
		RegDst => 0;
		ALUSrc => 1;
		Branch => 0;
		MemRead => 0;
		MemWrite => 0;
		MemtoReg => 0;
		ALUOp => B"00";
		Jump => "0"
	--	HexCode => X"280"

	when "000010"	--J
		RegWrite => 0; 
		RegDst => '-';
		ALUSrc => '-';
		Branch => '-';
		MemRead => 0;
		MemWrite => 0;
		MemtoReg => '-';
		ALUOp => B"'--'";
		Jump => "0"
	--	HexCode => X"001"

	end case
END PROCESS

ALUDecoder : PROCESS

END PROCESS 