----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:   
-- Design Name: 
-- Module Name:    registros - Behavioral 
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

entity registros is
    Port ( -- entradas
				clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           datos : in  STD_LOGIC_VECTOR (7 downto 0);
           estado_int : in  STD_LOGIC_VECTOR (3 downto 0);
           -- salidas
			  op1 : out  STD_LOGIC_VECTOR (7 downto 0);
           op2 : out  STD_LOGIC_VECTOR (7 downto 0);
           cod_op : out  STD_LOGIC_VECTOR (7 downto 0));
end registros;

architecture Behavioral of registros is
-- declaracion de componentes
component reg is
    Port( d : in  STD_LOGIC_VECTOR (7 downto 0);
          l : in  STD_LOGIC;
          clk : in  STD_LOGIC;
		    rst : in std_logic;
          q : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

begin
	reg01: reg		-- registro p/ op1.
		port map(d => datos, l => estado_int(0), clk => clk, rst => rst ,q => op1);
	reg02: reg		--registro p/ op2.
		port map(d => datos, l => estado_int(2), clk => clk, rst => rst, q => op2);
	reg03: reg		--registro p/ sig_op1, sig_op2, cod_operacion.
		port map(d => datos, l => estado_int(1), clk => clk, rst => rst, q => cod_op);
end Behavioral;

