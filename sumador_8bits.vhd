----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:16:44 05/17/2018 
-- Design Name: 
-- Module Name:    sumador_8bits - Behavioral 
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

entity sumador_8bits is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
			  Signo1 : in STD_LOGIC;
			  Signo2 : in STD_LOGIC;
			  Cin : in STD_LOGIC;
           Cout : out  STD_LOGIC;
			  S : out STD_LOGIC;
           ResultadoSuma : out  STD_LOGIC_VECTOR (7 downto 0));
end sumador_8bits;

architecture Behavioral of sumador_8bits is

signal Cinterno: std_logic;
signal A1: std_logic_vector(3 downto 0);
signal A2: std_logic_vector(3 downto 0);
signal B1: std_logic_vector(3 downto 0);
signal B2: std_logic_vector(3 downto 0);
signal Res1: std_logic_vector(3 downto 0);
signal Res2: std_logic_vector(3 downto 0);
signal S1: std_logic;
signal S2: std_logic;
signal AAux: std_logic_vector(7 downto 0);
signal BAux: std_logic_vector(7 downto 0);
signal AAuxComp: std_logic_vector(7 downto 0);
signal BAuxComp: std_logic_vector(7 downto 0);
signal AAux2: std_logic_vector(7 downto 0);
signal BAux2: std_logic_vector(7 downto 0);
signal SumaTotal: std_logic_vector(7 downto 0);
signal SumaTotalAux: std_logic_vector(7 downto 0);
signal CompSumaTotal: std_logic_vector(7 downto 0);
signal Comparador: std_logic_vector(1 downto 0);
signal Comparador2: std_logic_vector(1 downto 0);

COMPONENT sumador_4bits
	PORT(
		A : IN std_logic_vector(3 downto 0);
		B : IN std_logic_vector(3 downto 0);
		Cin : IN std_logic;          
		ResultadoSuma : OUT std_logic_vector(3 downto 0);
		Cout : OUT std_logic
		);
	END COMPONENT;

COMPONENT Complemento_a_2 
    PORT ( 
		A : in  STD_LOGIC_VECTOR (7 downto 0);
      Complemento2 : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;

COMPONENT Comparador_8bits
	 PORT ( 
		A : in  STD_LOGIC_VECTOR (7 downto 0);
      B : in  STD_LOGIC_VECTOR (7 downto 0);
      salida : out STD_LOGIC_VECTOR (1 downto 0)
		);
	END COMPONENT;

begin

S1 <= Signo1;
S2 <= Signo2;

AAux <= A;
BAux <= B;

Inst_complemento2_A:Complemento_a_2 PORT MAP (
	A => AAux,
	Complemento2 => AAuxComp
	);
	
Inst_complemento2_B:Complemento_a_2 PORT MAP (
	A => BAux,
	Complemento2 => BAuxComp
	);

AAux2 <= AAux when S1='0' else AAuxComp;
BAux2 <= BAux when S2='0' else BAuxComp; 

A1<=AAux2(3 downto 0);
A2<=AAux2(7 downto 4);
B1<=BAux2(3 downto 0);
B2<=BAux2(7 downto 4);

Inst_primerasuma: sumador_4bits PORT MAP(
		A => A1,
		B => B1,
		Cin => Cin,
		ResultadoSuma => Res1,
		Cout => Cinterno
	);
	
Inst_segundasuma: sumador_4bits PORT MAP(
		A => A2,
		B => B2,
		Cin => Cinterno,
		ResultadoSuma => Res2,
		Cout => Cout
	);

SumaTotal<= Res2 & Res1;

Inst_complemento2_SumaTotal:Complemento_a_2 PORT MAP (
	A => SumaTotal,
	Complemento2 => CompSumaTotal
	);
	
SumaTotalAux<=SumaTotal;

Inst_comparador: Comparador_8bits PORT MAP (
	A=>AAux,
	B=>BAux,
	Salida=>Comparador
	);

Inst_comparador_128: Comparador_8bits PORT MAP (
	A=>SumaTotalAux,
	B=>"01111111",
	Salida=>Comparador2
	);


ResultadoSuma <= CompSumaTotal when S1='0' and S2='1' and Comparador="01"
else CompSumaTotal when S1='1' and S2='0' and Comparador="10"
else SumaTotal when Comparador2="10" and S1='0'
else CompSumaTotal when S1='1' and S2='1'
else SumaTotal when SumaTotalAux(7)='0';
		
S <= '1' when S1='0' and S2='1' and Comparador="01"
else '0' when Comparador2="10" and S1='0'
else '1' when Comparador2="10" and S1='1'
else '1' when S1='1' and S2='1'
else SumaTotalAux(7);
		

end Behavioral;

