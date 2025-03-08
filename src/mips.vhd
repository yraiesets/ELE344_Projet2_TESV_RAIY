library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS is 
    port (
	-- Signaux d'entrer 
        Clk, Reset : in std_logic;
        Instruction, ReadData : in std_logic_vector(31 downto 0);
	-- Signaux de sortie
        MemRead, MemWrite : out std_logic;
        PC, AluResult, WriteData,  : out std_logic_vector(31 downto 0)
    );
end entity MIPS;

architecture logique of MIPS is 

    signal MemtoReg, MemWrite, MemRead, Branch, AluSrc, RegDst, RegWrite, Jump : std_logic;
    signal AluControl : std_logic_vector(3 downto 0);
begin
    -- Instanciation du fichier controller.vhd
    CONTROLLER : entity work.controller
        port map (
        OP	  	=> Instruction(31 downto 26), -- Partie du OPCODE
	Funct	  	=> Instruction(5 downto 0), -- Partie de Fonction de l'instruction
	MemtoReg  	=> MemtoReg -- Si 0 = Alu Si 1 = Mem (LW)
	MemWrite  	=> MemWrite -- Si 1 Écrit dans la Mem (SW)	
	MemRead   	=> MemRead -- Si 1 lit la Mem (LW)		
	Branch    	=> Branch -- Si 1 = BEQ Si 0 	
	AluSrc    	=> AluSrc -- Si 1 = type I SignImm Si 0 = rd2  	
	RegDst    	=> RegDst -- Si 1 = rd [15:11] Si 0 = rt [20:16] 	
	RegWrite  	=> RegWrite -- Si 1 Ecriture registre Si 0 soit BEQ, SW	
	Jump      	=> Jump -- Si 1 = (PC = Jump addr)	
	AluControl	=> AluControl -- Operation de ALU
        );

    -- Instanciation du fichier datapath.vhd
    Datapath : entity work.datapath

        port map (
	clk 		=> Clk
	reset		=> Reset
	MemtoReg	=> MemtoReg
	Branch 		=> Branch 
	RegDst		=> RegDst
	RegWrite	=> RegWrite
	Jump		=> Jump
	AluSrc		=> AluSrc
	MemReadIn	=> MemReadIn
 	MemWriteIn	=> MemWriteIn	
	AluControl 	=> AluControl 	
	Instruction	=> Instruction
	ReadData 	=> ReadData
	MemReadOut	=> MemReadOut
	MemWriteOut	=> MemWriteOut	
        PC		=> PC
 	AluResult	=> AluResult	
	WriteData  	=> WriteData   
        );

-- Je ne crois pas qu'on ait besoin d'assigner rien en sortie 

end architecture logique;
