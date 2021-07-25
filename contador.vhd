----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    contador - Behavioral 
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
--use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity contador is
    port(clk, rst, en : in std_logic;
         cuenta : out std_logic_vector(1 downto 0));
end contador;

architecture arch_1 of contador is
    signal tmp: unsigned(1 downto 0);	--r_reg, r_next : unsigned(1 downto 0); 	
begin
    process (clk, rst, en)
    begin
		if (clk'event and clk='1') then
			if (rst='1') then
            	tmp <= "00";
			elsif (en='1') then
				 	tmp <= tmp + 1;	--r_reg <= r_next; 	
		  	end if;
		end if;
    end process;
	 -- r_next <= r_reg + 1;
    cuenta <= std_logic_vector(tmp);
end arch_1;
