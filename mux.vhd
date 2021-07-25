----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    mux - Behavioral 
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

entity mux is
    Port ( datos : in  STD_LOGIC_VECTOR (7 downto 0);
           result : in  STD_LOGIC_VECTOR (11 downto 0);
           sel : in  STD_LOGIC;
           datos_sal : out  STD_LOGIC_VECTOR (11 downto 0));
end mux;

architecture Behavioral of mux is
-- señal auxiliar de paso
signal datos_i : std_logic_vector(11 downto 0);
begin
datos_i <= "0000" & datos;
datos_sal <= result WHEN sel ='1' ELSE 
            datos_i;
end Behavioral;

