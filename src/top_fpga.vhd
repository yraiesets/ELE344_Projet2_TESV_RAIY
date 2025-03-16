--========================= top_fpga.vhd ============================
-- ELE-343 Conception des syst�mes ordin�s
-- HIVER 2017, Ecole de technologie sup�rieure
-- Auteur : Yves Blaqui�re
-- =============================================================
-- Description: top_fpga
--              Enveloppe (wrapper) pour le top du MIPS qui
--              Nomme les ports en fonction du fichier des pins
--              du FPGA, tel que d�crit dans le fichier
--              DE2_pin_assignments.csv du DE2
--              Ajoute des afficheurs 7-segment sur les ports de
--              sortie du top
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TOP_FPGA IS

	PORT(
		KEY  : IN  STD_LOGIC_VECTOR(0 TO 1);	-- KEY[0]=reset, KEY[1]=clock
		HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);	-- PC(3 downto 0) 
		HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);	-- PC(7 downto 4) 
		HEX2 : OUT STD_LOGIC_VECTOR(0 TO 6);	-- DataAddress(3 downto 0) 
		HEX3 : OUT STD_LOGIC_VECTOR(0 TO 6);	-- DataAddress(7 downto 4) 
		HEX4 : OUT STD_LOGIC_VECTOR(0 TO 6);	-- WriteData(3 downto 0) 
		HEX5 : OUT STD_LOGIC_VECTOR(0 TO 6)	-- WriteData(7 downto 4
	);

END ENTITY TOP_FPGA;

ARCHITECTURE rtl OF top_fpga IS
	SIGNAL Memwrite               : STD_LOGIC;
	SIGNAL PC                     : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL WriteData, DataAddress : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
	-- Instantiation du top
	DUT : ENTITY work.TOP(rtl)
		PORT MAP(
			Clk		=> KEY(1),
			Reset		=> KEY(0),
			PC		=> PC,
			WriteData	=> WriteData,
			DataAddress	=> DataAddress
		);

	-- Afficheurs 7-segments pour les ports de sortie
	dec7seg_0 : ENTITY work.dec7seg PORT MAP (HEX0, PC(3 DOWNTO 0));
	dec7seg_1 : ENTITY work.dec7seg PORT MAP (HEX1, PC(7 DOWNTO 4));
	dec7seg_2 : ENTITY work.dec7seg PORT MAP (HEX2, DataAddress(3 DOWNTO 0));
	dec7seg_3 : ENTITY work.dec7seg PORT MAP (HEX3, DataAddress(7 DOWNTO 4));
	dec7seg_4 : ENTITY work.dec7seg PORT MAP (HEX4, WriteData(3 DOWNTO 0));
	dec7seg_5 : ENTITY work.dec7seg PORT MAP (HEX5, WriteData(7 DOWNTO 4));

END ARCHITECTURE rtl;
