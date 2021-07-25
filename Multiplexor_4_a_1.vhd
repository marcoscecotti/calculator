----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:27:18 06/09/2018 
-- Design Name: 
-- Module Name:    Multiplexor_4_a_1 - Behavioral 
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

entity Multiplexor_4_a_1 is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           C : in  STD_LOGIC;
           sel : in  STD_LOGIC_VECTOR (1 downto 0);
           Salida : out  STD_LOGIC);
end Multiplexor_4_a_1;

architecture Behavioral of Multiplexor_4_a_1 is

begin

Salida <= A WHEN sel ="00" ELSE 
          B WHEN sel ="01" ELSE 
		    C WHEN sel ="10" ELSE 
			'0';

end Behavioral;

