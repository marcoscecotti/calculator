----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    deco - Behavioral 
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

entity deco is
    Port ( -- entradas
				clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ent : in  STD_LOGIC_VECTOR (1 downto 0);
           -- salida
			  estado : out  STD_LOGIC_VECTOR (3 downto 0));
end deco;

architecture Behavioral of deco is
begin
process(clk)
begin
   if ( clk'event and clk ='1') then 
      if ( rst = '1') then
         estado <= "0000";
      else
         case ent is
            when "00" => estado <= "0001";
            when "01" => estado <= "0010";
            when "10" => estado <= "0100";
            when "11" => estado <= "1000";
            when others => estado <= "0000";
         end case;
      end if;
   end if;
end process;
end Behavioral;

