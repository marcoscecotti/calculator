----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:06:25 05/18/2018 
-- Design Name: 
-- Module Name:    Restador - Behavioral 
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

entity Restador is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
			  S1 : in STD_LOGIC;
			  S2 : in STD_LOGIC;
			  Cin : in STD_LOGIC;
			  Cout : out  STD_LOGIC;
           ResultadoResta : out  STD_LOGIC_VECTOR (7 downto 0);
			  S: out STD_LOGIC
           );
end Restador;

architecture Behavioral of Restador is

COMPONENT sumador_8bits_sinSigno
	Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
          B : in  STD_LOGIC_VECTOR (7 downto 0);
			 Cin : in STD_LOGIC;
          Cout : out  STD_LOGIC;
          ResultadoSuma : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;
	
COMPONENT complemento_a_2
	 Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
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
	
	
signal A1:std_logic_vector(7 downto 0);
signal B1:std_logic_vector(7 downto 0);
signal complemento_2_A:std_logic_vector(7 downto 0);
signal complemento_2_B:std_logic_vector(7 downto 0);

signal ResultadoResta1:std_logic_vector(7 downto 0);
signal ResultadoResta1_final:std_logic_vector(7 downto 0);
signal ResultadoResta2:std_logic_vector(7 downto 0);
signal ResultadoResta2_final:std_logic_vector(7 downto 0);
signal ResultadoResta3:std_logic_vector(7 downto 0);
signal ResultadoResta3_final:std_logic_vector(7 downto 0);
signal ResultadoResta4:std_logic_vector(7 downto 0);
signal ResultadoResta4_final:std_logic_vector(7 downto 0);

signal CoutAux1: std_logic;
signal CoutAux2: std_logic;
signal CoutAux3: std_logic;
signal CoutAux4: std_logic;

signal Comparador: std_logic_vector(1 downto 0);

begin

A1<=A;
B1<=B;

Inst_complemento2_A: complemento_a_2 PORT MAP (
		A=>A1,
		Complemento2=>complemento_2_A
		);

Inst_complemento2_B: complemento_a_2 PORT MAP (
		A=>B1,
		Complemento2=>complemento_2_B
		);


-- (- A + B) == not(A-B)
Inst_sumador8bits_1: sumador_8bits_sinSigno PORT MAP(
		A => complemento_2_A,
		B => B1,
		Cin => '0',
		Cout => CoutAux1,
		ResultadoSuma => ResultadoResta1
		
	);
	
Inst_complemento2_1: complemento_a_2 PORT MAP (
		A=>ResultadoResta1,
		Complemento2=>ResultadoResta1_final
		);

-- (A - B)
Inst_sumador8bits_2: sumador_8bits_sinSigno PORT MAP(
		A => A1,
		B => complemento_2_B,
		Cin => Cin,
		Cout => CoutAux2,
		ResultadoSuma => ResultadoResta2
	);
	
Inst_complemento2_2: complemento_a_2 PORT MAP (
		A=>ResultadoResta2,
		Complemento2=>ResultadoResta2_final
		);	

-- (- A - B)
Inst_sumador8bits_3: sumador_8bits_sinSigno PORT MAP(
		A => complemento_2_A,
		B => complemento_2_B,
		Cin => Cin,
		Cout => CoutAux3,
		ResultadoSuma => ResultadoResta3
	);

Inst_complemento2_3: complemento_a_2 PORT MAP (
		A=>ResultadoResta3,
		Complemento2=>ResultadoResta3_final
		);
	
	
-- (A + B)
Inst_sumador8bits_4: sumador_8bits_sinSigno PORT MAP(
		A => A1,
		B => B1,
		Cin => Cin,
		Cout => CoutAux4,
		ResultadoSuma => ResultadoResta4
	);


Inst_comparador: Comparador_8bits PORT MAP (
	A=>A1,
	B=>B1,
	Salida=>Comparador
	);
	
	
Cout <= CoutAux3 when (S1 = '1' and S2 = '0')
				else	CoutAux1 when (S1 = '1' and S2 = '1')
				else	CoutAux2 when (S1 = '0' and S2 = '0')
				else  CoutAux4;	
	
ResultadoResta <= ResultadoResta1 when (S1 = '1' and S2 = '1' and Comparador="01")
				else	ResultadoResta1 when (S1 = '1' and S2 = '1' and Comparador="11")
				else  ResultadoResta1_final when (S1 = '1' and S2 = '1' and Comparador="10")
				else	ResultadoResta2 when (S1 = '0' and S2 = '0' and Comparador="10")
				else	ResultadoResta2 when (S1 = '0' and S2 = '0' and Comparador="11")
				else	ResultadoResta2_final when (S1 = '0' and S2 = '0' and Comparador="01")
				else	ResultadoResta3_final when (S1 = '1' and S2 = '0')
				else  ResultadoResta4;
	
S <= '1' when S1 = '1' and S2 = '1' and Comparador="10"
else '0' when S1 = '1' and S2 = '1' and Comparador="01"
else '1' when S1='1' and S2='0'
else '0' when S1='0' and S2='0' and Comparador="10"
else '1' when S1='0' and S2='0' and Comparador="01"
else '0';

end Behavioral;

