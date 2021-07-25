----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    control - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Este circuito se encarga de controlar la recepcion de la entrada de datos 
-- en la secuencia correcta.
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

entity control is
    Port ( -- entradas
				clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				carga : in  STD_LOGIC;
				-- salidas
				verif : out  STD_LOGIC;
				estado : out  STD_LOGIC_VECTOR (3 downto 0));
end control;

architecture Behavioral of control is
-- declaracion de componentes
component anti_rebote is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           start : in  STD_LOGIC;
			  verif : out std_logic;
           q : out  STD_LOGIC);
end component;

component contador is
    port(clk, rst, en : in std_logic;
         cuenta : out std_logic_vector(1 downto 0));
end component;

component deco is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ent : in  STD_LOGIC_VECTOR (1 downto 0);
           estado : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

--señales internas
signal carga_int : std_logic;
signal cuenta_int : std_logic_vector(1 downto 0);

begin
-- modulo de verificacion de boton apretado
	a_rebo: anti_rebote
		port map(clk => clk, rst => rst, start => carga ,verif => verif, q => carga_int);
-- modulo de control de secuencia
	cont: contador
		port map(clk => clk, rst => rst, en => carga_int, cuenta => cuenta_int);
-- modulo de instruccion para procesar
	decodifica: deco
   		Port map(clk => clk, rst => rst, ent => cuenta_int, estado => estado);
end Behavioral;

