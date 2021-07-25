----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:55:48 06/12/2018 
-- Design Name: 
-- Module Name:    reg - Behavioral 
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
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:13:43 05/04/2016 
-- Design Name: 
-- Module Name:    reg - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 0.02
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
    Port ( -- dato de entrada
				d : in  STD_LOGIC_VECTOR (7 downto 0);
				-- señal de carga
				l : in  STD_LOGIC;
				clk : in  STD_LOGIC;
				rst : in std_logic;
				-- dato de salida
				q : out  STD_LOGIC_VECTOR (7 downto 0));
end reg;

architecture Behavioral of reg is
begin
	process (clk, rst)
	begin
	   if rst ='1' then   
		  q <= (others => '0');
	   elsif (clk'event and clk='0') then 
		  if l = '1' then 
		     q <= d;
		  end if; 
	   end if;
	end process;
end Behavioral;


