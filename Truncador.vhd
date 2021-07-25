----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:59:43 06/09/2018 
-- Design Name: 
-- Module Name:    Truncador - Behavioral 
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

entity Truncador is
    Port ( ResultadoMulti : in  STD_LOGIC_VECTOR (15 downto 0);
           ResultadoTruncado : out  STD_LOGIC_VECTOR (7 downto 0));
end Truncador;

architecture Behavioral of Truncador is

begin

ResultadoTruncado(7 downto 0) <= ResultadoMulti(15 downto 8) when ResultadoMulti(15) = '1'
else ResultadoMulti(14 downto 7) when ResultadoMulti(14) = '1'
else ResultadoMulti(13 downto 6) when ResultadoMulti(13) = '1'
else ResultadoMulti(12 downto 5) when ResultadoMulti(12) = '1'
else ResultadoMulti(11 downto 4) when ResultadoMulti(11) = '1'
else ResultadoMulti(10 downto 3) when ResultadoMulti(10) = '1'
else ResultadoMulti(9 downto 2) when ResultadoMulti(9) = '1'
else ResultadoMulti(8 downto 1) when ResultadoMulti(8) = '1'
else ResultadoMulti(7 downto 0);

	
end Behavioral;

