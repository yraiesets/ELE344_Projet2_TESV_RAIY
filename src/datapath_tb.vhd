LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY DATAPATH_TB IS
END DATAPATH_TB;

ARCHITECTURE tb OF DATAPATH_TB IS

    -- Declaration des constantes
    CONSTANT N : INTEGER := 32;

    -- Declaration des signaux pour le test
    SIGNAL Clk         : STD_LOGIC := '0';
    SIGNAL Reset       : STD_LOGIC := '0';
    SIGNAL MemtoReg    : STD_LOGIC := '0';
    SIGNAL Branch      : STD_LOGIC := '0';
    SIGNAL AluSrc      : STD_LOGIC := '0';
    SIGNAL RegDst      : STD_LOGIC := '0';
    SIGNAL RegWrite    : STD_LOGIC := '0';
    SIGNAL Jump        : STD_LOGIC := '0';
    SIGNAL MemReadIn   : STD_LOGIC := '0';
    SIGNAL MemWriteIn  : STD_LOGIC := '0';
    SIGNAL AluControl  : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Instruction : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL ReadData    : STD_LOGIC_VECTOR(N-1 DOWNTO 0);

    SIGNAL MemReadOut  : STD_LOGIC;
    SIGNAL MemWriteOut : STD_LOGIC;
    SIGNAL PC          : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL AluResult   : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL WriteData   : STD_LOGIC_VECTOR(N-1 DOWNTO 0);

BEGIN

    -- Instanciation du Datapath
    DUT: ENTITY work.DATAPATH(rtl)
        PORT MAP(
            Clk         => Clk,
            Reset       => Reset,
            MemtoReg    => MemtoReg,
            Branch      => Branch,
            AluSrc      => AluSrc,
            RegDst      => RegDst,
            RegWrite    => RegWrite,
            Jump        => Jump,
            MemReadIn   => MemReadIn,
            MemWriteIn  => MemWriteIn,
            AluControl  => AluControl,
            Instruction => Instruction,
            ReadData    => ReadData,
            MemReadOut  => MemReadOut,
            MemWriteOut => MemWriteOut,
            PC          => PC,
            AluResult   => AluResult,
            WriteData   => WriteData
        );

    -- Processus de test avec verifications
    PROCESS
    BEGIN
        -- Attente du reset (force via le fichier datapath_tb.do)
        WAIT FOR 20 ns;

        -- Test 1 : ADD ($3 = $1 + $2)
        Instruction <= X"00221820"; -- ADD $3, $1, $2
        RegDst <= '1';
        AluSrc <= '0';
        MemtoReg <= '0';
        AluControl <= "0010"; -- Addition
        RegWrite <= '1';
        WAIT FOR 20 ns;

        ASSERT AluResult = X"00000006"
        REPORT "Erreur: ADD a donne une mauvaise valeur." SEVERITY ERROR;

        -- Test 2 : ADDI ($4 = $0 + 10)
        Instruction <= X"2004000A"; -- ADDI $4, $0, 10
        RegDst <= '0';
        AluSrc <= '1';
        MemtoReg <= '0';
        AluControl <= "0010"; -- Addition
        RegWrite <= '1';
        WAIT FOR 20 ns;

        ASSERT AluResult = X"0000000A"
        REPORT "Erreur: ADDI n'a pas retourne la valeur correcte." SEVERITY ERROR;

        -- Test 3 : LW ($5 ? MEM[0])
        Instruction <= X"8C050000"; -- LW $5, 0($0)
        MemReadIn <= '1';
        MemtoReg <= '1';
        AluSrc <= '1';
        RegWrite <= '1';
        ReadData <= X"0000000F"; -- Simulation de la valeur en memoire
        WAIT FOR 20 ns;

        ASSERT WriteData = X"0000000F"
        REPORT "Erreur: LW n'a pas charge la valeur correcte." SEVERITY ERROR;

        -- Test 4 : SW (MEM[0] ? $6)
        Instruction <= X"AC060000"; -- SW $6, 0($0)
        MemReadIn <= '0';
        MemWriteIn <= '1';
        RegWrite <= '0';
        WriteData <= X"00000020"; -- Simulation de l'ecriture en memoire
        WAIT FOR 20 ns;

        ASSERT MemWriteOut = '1'
        REPORT "Erreur: SW n'a pas active le signal d'ecriture memoire." SEVERITY ERROR;

        -- Test 5 : BEQ ($5 == $5 ? PC += Offset)
        Instruction <= X"10050002"; -- BEQ $5, $5, label
        Branch <= '1';
        WAIT FOR 20 ns;

        ASSERT PC = X"00000008"
        REPORT "Erreur: BEQ n'a pas modifie le PC correctement." SEVERITY ERROR;

        -- Test 6 : JUMP (PC <- 0x10)
        Instruction <= X"08000004"; -- J 0x10
        Jump <= '1'; 
        WAIT FOR 20 ns;

        ASSERT PC = X"00000010"
        REPORT "Erreur: JUMP n'a pas modifie le PC correctement." SEVERITY ERROR;

        -- Fin du test
        REPORT "Test termine avec succes." SEVERITY NOTE;
        WAIT;
    END PROCESS;

END ARCHITECTURE tb;
