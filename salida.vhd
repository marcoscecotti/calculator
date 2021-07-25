----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    salida - Behavioral 
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

entity salida is
    Port ( -- entradas
				clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           datos : in  STD_LOGIC_VECTOR (7 downto 0);
           result : in  STD_LOGIC_VECTOR (11 downto 0);
           sel : in  STD_LOGIC;
			  s : in std_logic;
           -- salidas
			  sseg : out  STD_LOGIC_VECTOR (7 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0));
end salida;

architecture Behavioral of salida is
-- declaracion de componentes
component mux
    Port ( datos : in  STD_LOGIC_VECTOR (7 downto 0);
           result : in  STD_LOGIC_VECTOR (11 downto 0);
           sel : in  STD_LOGIC;
           datos_sal : out  STD_LOGIC_VECTOR (11 downto 0));
end component;

component hex2led is
   port( hex: in std_logic_vector(3 downto 0);
         dp: in std_logic;
         sseg: out std_logic_vector(7 downto 0));
end component;

component disp_mux is
   port( clk, rst: in std_logic;
      	in3, in2, in1, in0: in std_logic_vector(7 downto 0);
      	an: out std_logic_vector(3 downto 0);
      	sseg: out std_logic_vector(7 downto 0));
end component;

--señales internas
signal datos_sal : std_logic_vector (11 downto 0);
signal signo : std_logic_vector (7 downto 0);
signal unidad, decena, centena : std_logic_vector (7 downto 0);

begin
-- señal de signo p display
signo <= "1111111" & (not s) ;
	-- selector de datos de entrada o resultado de la alu
	m_mux: mux
		port map(datos => datos, result => result, sel => sel, datos_sal => datos_sal);
	-- modulos conversores:
	-- modulo para unidad
	sseg_unidad: hex2led
      port map(hex=>datos_sal(3 downto 0), dp =>'1', sseg=>unidad);
   -- modulo para decena
   sseg_decena: hex2led
      port map(hex=>datos_sal(7 downto 4), dp =>'1', sseg=>decena);
   -- modulo para centena
	sseg_centena: hex2led
      port map(hex=>datos_sal(11 downto 8), dp =>'1', sseg=>centena);
   -- modulo de visualizacion simultanea
   disp_unit: disp_mux
      port map(clk => clk, rst => rst, in3=> signo, in2=> centena, in1=>decena, in0=>unidad,   an=>an, sseg=>sseg);
end Behavioral;

