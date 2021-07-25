----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:40:03 05/18/2018 
-- Design Name: 
-- Module Name:    Inversor - Behavioral 
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

entity Inversor is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           Inverso : out  STD_LOGIC_VECTOR (7 downto 0));
end Inversor;

architecture Behavioral of Inversor is

begin

	Inverso(0)<=not(A(0));
	Inverso(1)<=not(A(1));
	Inverso(2)<=not(A(2));
	Inverso(3)<=not(A(3));
	Inverso(4)<=not(A(4));
	Inverso(5)<=not(A(5));
	Inverso(6)<=not(A(6));
	Inverso(7)<=not(A(7));

end Behavioral;

