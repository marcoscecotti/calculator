----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:24:55 05/17/2018 
-- Design Name: 
-- Module Name:    sumador_4bits - Behavioral 
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

entity sumador_4bits is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           Cin : in  STD_LOGIC;
           Cout : out  STD_LOGIC;
           ResultadoSuma : out  STD_LOGIC_VECTOR (3 downto 0));
end sumador_4bits;

architecture Behavioral of sumador_4bits is

signal Cinterno: std_logic_vector(2 downto 0);

COMPONENT sumador_1bit
	PORT(
		Ai : IN std_logic;
		Bi : IN std_logic;
		Cin : IN std_logic;          
		Si : OUT std_logic;
		Cout : OUT std_logic
		);
	END COMPONENT;


begin

Inst_primerasuma: sumador_1bit PORT MAP(
		Ai => A(0),
		Bi => B(0),
		Cin => Cin,
		Si => ResultadoSuma(0),
		Cout => Cinterno(0)
	);

Inst_segundasuma: sumador_1bit PORT MAP(
		Ai => A(1),
		Bi => B(1),
		Cin => Cinterno(0),
		Si => ResultadoSuma(1),
		Cout => Cinterno(1)
	);

	Inst_tercerasuma: sumador_1bit PORT MAP(
		Ai => A(2),
		Bi => B(2),
		Cin => Cinterno(1),
		Si => ResultadoSuma(2),
		Cout => Cinterno(2)
	);

	Inst_cuartasuma: sumador_1bit PORT MAP(
		Ai => A(3),
		Bi => B(3),
		Cin => Cinterno(2),
		Si => ResultadoSuma(3),
		Cout => Cout
	);


end Behavioral;

