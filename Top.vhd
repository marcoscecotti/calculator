----------------------------------------------------------------------------------
-- Company: 		UNL - FICH
-- Bachelor: 		Eugenio Juna Padula
-- 
-- Create Date:   15:11:12 
-- Design Name: 	Calculadora
-- Module Name: Top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: El circuito realiza operaciones matenaticas simples con dos operando con signo. 
-- Primer paso: Se introduce el primer operando (en formato BCD) en los switchs y se da entrada;
-- Segundo paso: Se introducen los signos de los operandos junto con la operacion a realizar en los switchs y se da entrada;
-- Tercer paso: Se introduce el segundo operando (en formato BCD) en los switchs y se da entrada;
--	Cuarto paso: Reestablece el circuito para volver a operar.
-- Dependencies: 
--
-- Revision: 0.02
-- Revision 0.01 - File Created
-- Additional Comments: 
-- Se cambia la posicion del signo a la salida.
-- Se modifica el comportamiento de los leds.
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top is
    Port(-- switchs p/ op1; op2; sig_op1, sig_op2 y cod_operacion.
				datos : in  STD_LOGIC_VECTOR (7 downto 0);		
				-- boton p/ entrada de datos.
				carga : in  STD_LOGIC;							
				rst : in std_logic;
				clk : in  STD_LOGIC;
				-- Salidas
				sseg : out  STD_LOGIC_VECTOR (7 downto 0);
				an : out  STD_LOGIC_VECTOR (3 downto 0);
				leds : out  STD_LOGIC_VECTOR (7 downto 0));
end Top;

architecture Behavioral of Top is
-- Declaracion de componentes
component control is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           carga : in  STD_LOGIC;
           verif : out  STD_LOGIC;
           estado : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component registros is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           datos : in  STD_LOGIC_VECTOR (7 downto 0);
           estado_int : in  STD_LOGIC_VECTOR (3 downto 0);
           op1 : out  STD_LOGIC_VECTOR (7 downto 0);
           op2 : out  STD_LOGIC_VECTOR (7 downto 0);
           cod_op : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component alu is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
           cod_op : in  STD_LOGIC_vector (7 downto 0);
			  ce : in std_logic;
           result : out  STD_LOGIC_VECTOR (11 downto 0);
           o : out  STD_LOGIC;
           z : out  STD_LOGIC;
           c : out  STD_LOGIC;
			  s : out std_logic);
end component;

component salida is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           datos : in  STD_LOGIC_VECTOR (7 downto 0);
           result : in  STD_LOGIC_VECTOR (11 downto 0);
           sel : in  STD_LOGIC;
			  s : in std_logic;
           sseg : out  STD_LOGIC_VECTOR (7 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

-- Declaracion de señales de conexion entre modulos
signal carga_int, sig_op1, sig_op2, suma, resta, mult: std_logic;
signal ov, ze, ca, verif, s : std_logic;
signal cuenta_int : std_logic_vector(1 downto 0);
signal op1, op2, cod_op : std_logic_vector(7 downto 0);
signal estado_int : std_logic_vector(3 downto 0);
signal result_unidad, result_decena, result_centena: std_logic_vector(3 downto 0);
signal result ,datos_sal : std_logic_vector(11 downto 0);

begin
-- etapa de control
m_control: control 
    Port map (clk => clk, rst => rst, carga => carga, verif => verif , estado => estado_int);
-- etapa  de almacenamiento		
m_reg: registros
    Port map (clk => clk, rst => rst, datos => datos, estado_int => estado_int, op1 => op1, op2 => op2, cod_op => cod_op);
-- etapa de calculo
	m_alu: alu
		port map(op1 => op1, op2 => op2, cod_op  => cod_op, ce => estado_int(3), result => result, o => ov, z => ze, c => ca, s => s);
-- etapa de salida
	m_salida: salida
    Port map (clk => clk, rst => rst, datos => datos, result => result, sel => estado_int(3), s => s, sseg => sseg, an => an);
-- informacion en leds
process(estado_int)
begin
	if estado_int(3) = '0' then 
			leds(7) <= '0';
			leds(6) <= '0';
			leds(5) <= '0';
			leds(4) <= '0';
			leds(3) <= cod_op(3);
			leds(2) <= cod_op(2);
			leds(1) <= cod_op(1);
			leds(0) <= cod_op(0);
	else 
			leds(7) <= verif;
			leds(6) <= ov;
			leds(5) <= ze;
			leds(4) <= ca;
			leds(3) <= '0';
			leds(2) <= '0';
			leds(1) <= '0';
			leds(0) <= '0';	
	end if;
end process;			
end Behavioral;

