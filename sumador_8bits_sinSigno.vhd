----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:56:26 05/21/2018 
-- Design Name: 
-- Module Name:    sumador_8bits_sinSigno - Behavioral 
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

entity sumador_8bits_sinSigno is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
			  Cin : in STD_LOGIC;
           Cout : out  STD_LOGIC;
           ResultadoSuma : out  STD_LOGIC_VECTOR (7 downto 0));
end sumador_8bits_sinSigno;

architecture Behavioral of sumador_8bits_sinSigno is

signal Cinterno: std_logic;
signal A1: std_logic_vector(3 downto 0);
signal A2: std_logic_vector(3 downto 0);
signal B1: std_logic_vector(3 downto 0);
signal B2: std_logic_vector(3 downto 0);
signal Res1: std_logic_vector(3 downto 0);
signal Res2: std_logic_vector(3 downto 0);

COMPONENT sumador_4bits
	PORT(
		A : IN std_logic_vector(3 downto 0);
		B : IN std_logic_vector(3 downto 0);
		Cin : IN std_logic;          
		ResultadoSuma : OUT std_logic_vector(3 downto 0);
		Cout : OUT std_logic
		);
	END COMPONENT;

begin

A1<=A(3 downto 0);
A2<=A(7 downto 4);
B1<=B(3 downto 0);
B2<=B(7 downto 4);

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

ResultadoSuma<= Res2 & Res1;

end Behavioral;

