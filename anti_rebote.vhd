----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    anti_rebote - Behavioral 
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
-- Se modifica la salida Verif.
-- Se comenta.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity anti_rebote is
    Port ( -- entradas
				clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           -- entrada de control
			  start : in  STD_LOGIC;
			  -- salidas
			  verif : out std_logic;
			  q : out  STD_LOGIC);
end anti_rebote;

architecture Behavioral of anti_rebote is
--  provee un pulso de disparo estable
signal Q1, Q2, Q3 : std_logic;
begin
process(clk, start, q1, q2, q3)
variable tmp : std_logic :='0';
	begin
	   if (clk'event and clk = '1') then
		  if (rst = '1') then
			  Q1 <= '0';
		     Q2 <= '0';
		     Q3 <= '0'; 
		  else
		     Q1 <= start;
		     Q2 <= Q1;
		     Q3 <= Q2;
		  end if;
	   end if;
		tmp := Q1 and Q2 and (not Q3);
		q <= tmp;
		verif <= tmp;
end process;


end Behavioral;

