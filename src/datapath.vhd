--	Controller.VHD
--	Yasser Raies et Vincent Tessier
--	Hiver 2025

LIBRARY IEEE;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DATAPATH IS

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
        WriteData   :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    );

END ENTITY DATAPATH;

ARCHITECTURE PCPATH OF DATAPATH IS
END ARCHITECTURE PCPATH;