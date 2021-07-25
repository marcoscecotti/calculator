library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Comparador_8bits is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           salida : out STD_LOGIC_VECTOR (1 downto 0));
-- salida = '10' si A>B
-- salida = '01' si A<B
-- salida = "11" si A=B
end Comparador_8bits;

architecture Behavioral of Comparador_8bits is

begin  

process (A,B) BEGIN
	 if ((A(7)='1' AND B(7)='0'))	 THEN
		salida<="10";
		elsif (A(7)=B(7) AND (A(6)='1' AND B(6)='0')) THEN
		salida<="10";
			elsif (A(7)=B(7) AND A(6)=B(6) AND (A(5)='1' AND B(5)='0')) THEN
		salida<="10";
				elsif (A(7)=B(7) AND A(6)=B(6) AND A(5)=B(5) AND (A(4)='1' AND B(4)='0')) THEN
		salida<="10";
					elsif (A(7)=B(7) AND A(6)=B(6) AND A(5)=B(5) AND A(4)=B(4) AND (A(3)='1' AND B(3)='0')) THEN
		salida<="10";
						elsif (A(7)=B(7) AND A(6)=B(6) AND A(5)=B(5) AND A(4)=B(4) AND A(3)=B(3) AND (A(2)='1' AND B(2)='0')) THEN
		salida<="10";
							elsif (A(7)=B(7) AND A(6)=B(6) AND A(5)=B(5) AND A(4)=B(4) AND A(3)=B(3) AND A(2)=B(2) AND (A(1)='1' AND B(1)='0')) THEN
		salida<="10";
								elsif (A(7)=B(7) AND A(6)=B(6) AND A(5)=B(5) AND A(4)=B(4) AND A(3)=B(3) AND A(2)=B(2) AND A(1)=B(1) AND (A(0)='1' AND B(0)='0')) THEN
		salida<="10";
									elsif (A(7)=B(7) AND A(6)=B(6) AND A(5)=B(5) AND A(4)=B(4) AND A(3)=B(3) AND A(2)=B(2) AND A(1)=B(1) AND A(0)=B(0)) THEN
		salida<="11";
										else 
		salida<="01";
	end if;
end process;

end Behavioral;

