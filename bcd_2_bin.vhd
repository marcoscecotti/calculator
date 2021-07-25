----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:45:52 05/16/2018 
-- Design Name: 
-- Module Name:    bcd_2_bin - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bcd_2_bin is
    Port ( bcd : in  STD_LOGIC_VECTOR (7 downto 0);
           bin : out  STD_LOGIC_VECTOR (7 downto 0):=(others => '0'));
end bcd_2_bin;

architecture Behavioral of bcd_2_bin is

COMPONENT multiplicador_8bits 
	 Port ( 
			  AMulti : in  STD_LOGIC_VECTOR (7 downto 0);
           BMulti : in  STD_LOGIC_VECTOR (7 downto 0);
			  Signo1 : in  STD_LOGIC;
			  Signo2 : in  STD_LOGIC;
           ResultadoMulti : out  STD_LOGIC_VECTOR (15 downto 0);
           SignoMulti : out  STD_LOGIC;
           CoutMulti : out  STD_LOGIC);
    END COMPONENT;

COMPONENT sumador_8bits_sinSigno
	Port(
		A : in  STD_LOGIC_VECTOR (7 downto 0);
      B : in  STD_LOGIC_VECTOR (7 downto 0);
		Cin : in STD_LOGIC;
      Cout : out  STD_LOGIC;
      ResultadoSuma : out  STD_LOGIC_VECTOR (7 downto 0));
	END COMPONENT;

signal d1 : STD_LOGIC_VECTOR (3 downto 0);
signal d2 : STD_LOGIC_VECTOR (3 downto 0);
signal decenaBinario : STD_LOGIC_VECTOR(15 downto 0);
signal signo:std_logic;
signal Cout:std_logic;


begin 

d1 <= bcd (3 downto 0);
d2 <= bcd (7 downto 4);

Inst_multi_decenaBCD:multiplicador_8bits PORT MAP (
		AMulti(3 downto 0)=>d2,
		AMulti(7 downto 4)=>"0000",
		BMulti=>"00001010",
		Signo1 => '0',
		Signo2 => '0',
		ResultadoMulti => decenaBinario,
		SignoMulti => signo,
		CoutMulti => Cout
		);
		
Inst_suma_DecenaYUnidad:sumador_8bits_sinSigno PORT MAP (
		A => decenaBinario(7 downto 0),
		B(3 downto 0) => d1,
		B(7 downto 4) => "0000",
		Cin => '0',
		ResultadoSuma => bin
		);

end Behavioral;

