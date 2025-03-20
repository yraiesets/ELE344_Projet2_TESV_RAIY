--========================= imem.vhd ============================
-- ELE-343 Conception des systemes ordines
-- HIVER 2017, Ecole de technologie superieure
-- Auteur : Chakib Tadj, Vincent Trudel-Lapierre, Yves Blaquiere
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

  CONSTANT TAILLE_ROM : positive := 50;  -- taille de la rom (modifier au besoin)
  TYPE romtype IS ARRAY (0 TO TAILLE_ROM) OF std_logic_vector(31 DOWNTO 0);
	
	--Mettre a jour la Rom avec le code machine genere avec MARS et valide par le charge de laboratoire
CONSTANT Rom : romtype := (
0  => x"20080000",
1  => x"20090000",
2  => x"200a0000",
3  => x"200b0000",
4  => x"200d000a",
5  => x"200e0006",
6  => x"20102000",
7  => x"20112004",
8  => x"20122008",
9  => x"2013200c",

10 => x"3c0c004c",
11 => x"358c4b40",
12 => x"0c000028",
13 => x"ae080000",
14 => x"21080001",
15 => x"010d082a",
16 => x"1420fffa",
17 => x"20080000",
18 => x"08000012",

19 => x"3c0c02fa",
20 => x"358cf080",
21 => x"0c000028",
22 => x"ae290000",
23 => x"21290001",
24 => x"012d082a",
25 => x"1420fff2",
26 => x"20090000",
27 => x"0800001c",

28 => x"3c0c1dcd",
29 => x"358c6500",
30 => x"0c000028",
31 => x"ae4a0000",
32 => x"214a0001",
33 => x"014e082a",
34 => x"1420ffea",
35 => x"200a0000",
36 => x"08000026",

37 => x"3c0cb2d0",
38 => x"358c5e00",
39 => x"0c000028",
40 => x"ae6b0000",
41 => x"216b0001",
42 => x"016d082a",
43 => x"1420ffe2",
44 => x"200b0000",
45 => x"0800000a",

46 => x"200f0000",
47 => x"21ef0001",
48 => x"01ec082a",
49 => x"1420fffd",
50 => x"03e00008"
);

BEGIN
  PROCESS (adresse)
  BEGIN
    data <= Rom(to_integer(unsigned((adresse))));
  END PROCESS;
END imem_arch;

