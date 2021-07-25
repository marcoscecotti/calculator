----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:03:51 05/20/2018 
-- Design Name: 
-- Module Name:    multiplicador_8bits - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplicador_8bits is
    Port ( AMulti : in  STD_LOGIC_VECTOR (7 downto 0);
           BMulti : in  STD_LOGIC_VECTOR (7 downto 0);
			  Signo1 : in  STD_LOGIC;
			  Signo2 : in  STD_LOGIC;
           ResultadoMulti : out  STD_LOGIC_VECTOR (15 downto 0);
           SignoMulti : out  STD_LOGIC;
           CoutMulti : out  STD_LOGIC);
end multiplicador_8bits;

architecture Behavioral of multiplicador_8bits is

COMPONENT sumador_8bits_sinSigno
	Port(
		A : in  STD_LOGIC_VECTOR (7 downto 0);
      B : in  STD_LOGIC_VECTOR (7 downto 0);
		Cin : in STD_LOGIC;
      Cout : out  STD_LOGIC;
      ResultadoSuma : out  STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT;

		
signal SumaParcial1:std_logic_vector(7 downto 0);
signal SumaParcial2:std_logic_vector(7 downto 0);
signal SumaParcial3:std_logic_vector(7 downto 0);
signal SumaParcial4:std_logic_vector(7 downto 0);
signal SumaParcial5:std_logic_vector(7 downto 0);
signal SumaParcial6:std_logic_vector(7 downto 0);
signal SumaParcial7:std_logic_vector(7 downto 0);
signal SumaParcial8:std_logic_vector(7 downto 0);

signal Rmulti_complemento:std_logic_vector(15 downto 0);
signal RMulti:std_logic_vector(15 downto 0);
signal SigMulti:std_logic;

signal m0 : STD_LOGIC_VECTOR (7 downto 0);
signal m1 : STD_LOGIC_VECTOR (7 downto 0);
signal m2 : STD_LOGIC_VECTOR (7 downto 0);
signal m3 : STD_LOGIC_VECTOR (7 downto 0);
signal m4 : STD_LOGIC_VECTOR (7 downto 0);
signal m5 : STD_LOGIC_VECTOR (7 downto 0);
signal m6 : STD_LOGIC_VECTOR (7 downto 0);
signal m7 : STD_LOGIC_VECTOR (7 downto 0);

signal cout1:STD_LOGIC;
signal cout2:STD_LOGIC;
signal cout3:STD_LOGIC;
signal cout4:STD_LOGIC;
signal cout5:STD_LOGIC;
signal cout6:STD_LOGIC;
signal cout7:STD_LOGIC;

begin

m0<=AMulti WHEN BMulti(0)='1' ELSE "00000000";
m1<=AMulti WHEN BMulti(1)='1' ELSE "00000000";

Inst_sumparcial1: sumador_8bits_sinSigno PORT MAP (
	A(7) => ('0'), 
	A(6 downto 0) => m0(7 downto 1),
	B => m1,
	Cin => '0',
	Cout => cout1,
	ResultadoSuma => SumaParcial1
	);

RMulti(0)<=m0(0);
RMulti(1)<=SumaParcial1(0);

m2<=AMulti WHEN BMulti(2)='1' ELSE "00000000";

Inst_sumparcial2: sumador_8bits_sinSigno PORT MAP (
	A(7) => cout1,
	A(6 downto 0) => SumaParcial1(7 downto 1),
	B => m2,
	Cin => '0',
	Cout => cout2,
	ResultadoSuma => SumaParcial2
	);
	
RMulti(2)<=SumaParcial2(0);
	
m3<=AMulti WHEN BMulti(3)='1' ELSE "00000000";

Inst_sumparcial3: sumador_8bits_sinSigno PORT MAP (
	A(7) => cout2,
	A(6 downto 0) => SumaParcial2(7 downto 1),
	B => m3,
	Cin => '0',
	Cout => cout3,
	ResultadoSuma => SumaParcial3
	);
	
RMulti(3)<=SumaParcial3(0);

m4<=AMulti WHEN BMulti(4)='1' ELSE "00000000";

Inst_sumparcial4: sumador_8bits_sinSigno PORT MAP (
	A(7) => cout3,
	A(6 downto 0) => SumaParcial3(7 downto 1),
	B => m4,
	Cin => '0',
	Cout => cout4,
	ResultadoSuma => SumaParcial4
	);
	
RMulti(4)<=SumaParcial4(0);

m5<=AMulti WHEN BMulti(5)='1' ELSE "00000000";

Inst_sumparcial5: sumador_8bits_sinSigno PORT MAP (
	A(7) => cout4,
	A(6 downto 0) => SumaParcial4(7 downto 1),
	B => m5,
	Cin => '0',
	Cout => cout5,
	ResultadoSuma => SumaParcial5
	);
	
RMulti(5)<=SumaParcial5(0);

m6<=AMulti WHEN BMulti(6)='1' ELSE "00000000";

Inst_sumparcial6: sumador_8bits_sinSigno PORT MAP (
	A(7) => cout5,
	A(6 downto 0) => SumaParcial5(7 downto 1),
	B => m6,
	Cin => '0',
	Cout => cout6,
	ResultadoSuma => SumaParcial6
	);
	
RMulti(6)<=SumaParcial6(0);

m7<=AMulti WHEN BMulti(7)='1' ELSE "00000000";

Inst_sumparcial7: sumador_8bits_sinSigno PORT MAP (
	A(7) => cout6,
	A(6 downto 0) => SumaParcial6(7 downto 1),
	B => m7,
	Cin => '0',
	Cout => cout7,
	ResultadoSuma => SumaParcial7
	);
	
RMulti(14 downto 7)<=SumaParcial7;
RMulti(15)<=cout7;

CoutMulti<=cout7;

SigMulti <= Signo1 xor Signo2;
SignoMulti<=SigMulti;

		
ResultadoMulti <= RMulti;


end Behavioral;
