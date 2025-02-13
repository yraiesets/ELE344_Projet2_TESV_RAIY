--========================= imem.vhd ============================
-- ELE-343 Conception des systèmes ordinés
-- HIVER 2017, Ecole de technologie supérieure
-- Auteur : Chakib Tadj, Vincent Trudel-Lapierre, Yves Blaquière
-- Update: Hachem Bensalem, Janvier 2025
-- =============================================================
-- Description: imem        
-- =============================================================

LIBRARY ieee;
LIBRARY std;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY imem IS -- Memoire d'instructions
  PORT (adresse : IN  std_logic_vector(7 DOWNTO 0); -- Ce signal corresponds au signal PC(9 DOWNTO 2)
                                                    
        data : OUT std_logic_vector(31 DOWNTO 0));
END;  -- imem;

ARCHITECTURE imem_arch OF imem IS

  CONSTANT TAILLE_ROM : positive := 17;  -- taille de la rom (modifier au besoin)
  TYPE romtype IS ARRAY (0 TO TAILLE_ROM) OF std_logic_vector(31 DOWNTO 0);
	
	--Mettre à jour la Rom avec le code machine généré avec MARS et validé par le chargé de laboratoire
  CONSTANT Rom : romtype := (
    0  => x"20020005",
    1  => x"2003000C",
    2  => x"2067FFF7",
    3  => x"00E22025",
    4  => x"00642824",
    5  => x"00A42820",
    6  => x"10A7000A",
    7  => x"0064202A",
    8  => x"10800001",
    9  => x"20050000",
    10 => x"00E2202A",
    11 => x"00853820",
    12 => x"00E23822",
    13 => x"AC670044",
    14 => x"8C020050",
    15 => x"08000011",
    16 => x"20020001",
    17 => x"AC020054");
BEGIN
  PROCESS (adresse)
  BEGIN
    data <= Rom(to_integer(unsigned((adresse))));
  END PROCESS;
END imem_arch;

