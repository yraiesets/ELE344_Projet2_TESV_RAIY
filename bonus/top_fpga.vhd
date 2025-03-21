--========================= top_fpga.vhd ============================
-- ELE-343 Conception des systemes ordines
-- HIVER 2017, Ecole de technologie superieure
-- Auteur : Yves Blaquiere
-- Update: Hachem Bensalem, Mars 2025
-- =============================================================
-- Description: top_fpga modifié pour chronomètre numérique
-- Affiche directement les valeurs des adresses 0x00002000, 0x00002004,
-- 0x00002008, 0x0000200C sur HEX0, HEX1, HEX2, HEX3 respectivement.
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TOP_FPGA IS

	PORT(
		MAX10_CLK1_50 : IN STD_LOGIC;
		KEY  : IN  STD_LOGIC_VECTOR(0 TO 1);  -- KEY[0]=reset, KEY[1]=clock
		HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);  -- Adresse 0x00002000 (0.1 sec)
		HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);  -- Adresse 0x00002004 (1 sec)
		HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);  -- Adresse 0x00002008 (10 sec)
		HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6)   -- Adresse 0x0000200C (60 sec)
	);

END ENTITY TOP_FPGA;

ARCHITECTURE rtl OF top_fpga IS

	SIGNAL PC                      : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL WriteData, DataAddress  : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ResetIntern             : STD_LOGIC;

	SIGNAL mem0, mem4, mem8, memC  : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

	ResetIntern <= NOT(KEY(0));

	-- Instantiation du top
	DUT : ENTITY work.TOP(rtl)
		PORT MAP(
			Clk          => MAX10_CLK1_50,
			Reset        => ResetIntern,
			PC           => PC,
			WriteData    => WriteData,
			DataAddress  => DataAddress
		);

	-- Capture synchrone des valeurs écrites aux adresses spécifiques
	PROCESS(DataAddress,WriteData,mem0,mem4,mem8, memC)
	BEGIN
			mem0 <= mem0;
			mem4 <= mem4;
			mem8 <= mem8;
			memC <= memC;
			
			IF DataAddress = x"00002000" THEN
				mem0 <= WriteData(3 DOWNTO 0);
			ELSIF DataAddress = x"00002004" THEN
				mem4 <= WriteData(3 DOWNTO 0);
			ELSIF DataAddress = x"00002008" THEN
				mem8 <= WriteData(3 DOWNTO 0);
			ELSIF DataAddress = x"0000200C" THEN
				memC <= WriteData(3 DOWNTO 0);
			END IF;
	END PROCESS;

	-- Affichage direct sur afficheurs HEX
	dec7seg_0 : ENTITY work.dec7seg PORT MAP (HEX0, mem0);
	dec7seg_1 : ENTITY work.dec7seg PORT MAP (HEX1, mem4);
	dec7seg_2 : ENTITY work.dec7seg PORT MAP (HEX2, mem8);
	dec7seg_3 : ENTITY work.dec7seg PORT MAP (HEX3, memC);

END ARCHITECTURE rtl;
