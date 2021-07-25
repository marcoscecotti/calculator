----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:47:30 05/18/2018 
-- Design Name: 
-- Module Name:    Complemento_a_2 - Behavioral 
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

entity Complemento_a_2 is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           Complemento2 : out  STD_LOGIC_VECTOR (7 downto 0));
end Complemento_a_2;

architecture Behavioral of Complemento_a_2 is

COMPONENT Inversor
	PORT (
		A : in  STD_LOGIC_VECTOR (7 downto 0);
      Inverso : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;
	
COMPONENT sumador_8bits_sinSigno
	Port ( 
		A : in  STD_LOGIC_VECTOR (7 downto 0);
      B : in  STD_LOGIC_VECTOR (7 downto 0);
		Cin : in STD_LOGIC;
      Cout : out  STD_LOGIC;
		ResultadoSuma : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;
	
signal A1:std_logic_vector(7 downto 0);
signal Invertido:std_logic_vector(7 downto 0);
signal cout1:std_logic;
begin

A1<=A;

Inst_inversor: Inversor PORT MAP(
		A => A1,
		Inverso => Invertido
	);

Inst_sumador8bits: sumador_8bits_sinSigno PORT MAP(
		A => Invertido,
		B => "00000001",
		Cin => '0',
		Cout => cout1,
		ResultadoSuma => Complemento2
	);
	
end Behavioral;

