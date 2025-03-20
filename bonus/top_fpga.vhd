LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TOP_FPGA IS
  PORT(
    MAX10_CLK1_50   : IN STD_LOGIC;
    KEY             : IN STD_LOGIC_VECTOR(0 TO 1);
    HEX0            : OUT STD_LOGIC_VECTOR(0 TO 6);
    HEX1            : OUT STD_LOGIC_VECTOR(0 TO 6);
    HEX2            : OUT STD_LOGIC_VECTOR(0 TO 6);
    HEX3            : OUT STD_LOGIC_VECTOR(0 TO 6);
    HEX4            : OUT STD_LOGIC_VECTOR(0 TO 6);
    HEX5            : OUT STD_LOGIC_VECTOR(0 TO 6)
  );
END TOP_FPGA;

ARCHITECTURE rtl OF top_fpga IS
  SIGNAL WriteData, DataAddress : STD_LOGIC_VECTOR(31 DOWNTO 0);
  SIGNAL ResetIntern            : STD_LOGIC;
  SIGNAL PC                     : STD_LOGIC_VECTOR(31 DOWNTO 0);

  SIGNAL Hundredths, Seconds, Tens, Minutes : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

  ResetIntern <= NOT(KEY(0));

  -- MIPS utilise l'horloge stable à 50 MHz
  DUT : ENTITY work.TOP(rtl)
    PORT MAP(
      Clk         => MAX10_CLK1_50,
      Reset       => ResetIntern,
      PC          => PC,
      WriteData   => WriteData,
      DataAddress => DataAddress
    );

  -- Capture propre des données du MIPS pour les afficheurs
  PROCESS(MAX10_CLK1_50, ResetIntern)
  BEGIN
    IF ResetIntern = '1' THEN
      Hundredths <= (OTHERS => '0');
      Seconds    <= (OTHERS => '0');
      Tens       <= (OTHERS => '0');
      Minutes    <= (OTHERS => '0');    
    ELSIF RISING_EDGE(MAX10_CLK1_50) THEN
      CASE DataAddress(7 DOWNTO 0) IS
        WHEN x"00" => Hundredths <= WriteData(3 DOWNTO 0);
        WHEN x"04" => Seconds    <= WriteData(3 DOWNTO 0);
        WHEN x"08" => Tens       <= WriteData(3 DOWNTO 0);
        WHEN x"0C" => Minutes    <= WriteData(3 DOWNTO 0);
        WHEN OTHERS => NULL;
      END CASE;
    END IF;
  END PROCESS;

  -- Afficheurs 7 segments
  dec7seg_0 : ENTITY work.dec7seg PORT MAP (HEX0, Hundredths);
  dec7seg_1 : ENTITY work.dec7seg PORT MAP (HEX1, Seconds);
  dec7seg_2 : ENTITY work.dec7seg PORT MAP (HEX2, Tens);
  dec7seg_3 : ENTITY work.dec7seg PORT MAP (HEX3, Minutes);
  dec7seg_4 : ENTITY work.dec7seg PORT MAP (HEX4, PC(5 downto 2));
  dec7seg_5 : ENTITY work.dec7seg PORT MAP (HEX5, PC(9 downto 6));

END rtl;
