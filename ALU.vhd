----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:     
-- Design Name: 
-- Module Name:    Top_ALU - Behavioral 
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

entity ALU is
    Port ( op1 : in  STD_LOGIC_VECTOR (7 downto 0);
           op2 : in  STD_LOGIC_VECTOR (7 downto 0);
			  cod_op : in  STD_LOGIC_VECTOR (7 downto 0);
			  ce : in STD_LOGIC;
           result : out  STD_LOGIC_VECTOR (11 downto 0);
			  o : out  STD_LOGIC;
           z : out  STD_LOGIC;
           c : out  STD_LOGIC;
           s : out  STD_LOGIC);
end ALU;


architecture Behavioral of ALU is


COMPONENT Comparador_8bits
	 PORT ( 
		A : in  STD_LOGIC_VECTOR (7 downto 0);
      B : in  STD_LOGIC_VECTOR (7 downto 0);
      salida : out STD_LOGIC_VECTOR (1 downto 0)
		);
	END COMPONENT;


COMPONENT bin_bcd
		PORT(
			num_bin: in  STD_LOGIC_VECTOR(7   downto 0);
			num_bcd: out STD_LOGIC_VECTOR(11 downto 0)
			);
		END COMPONENT;
		
COMPONENT bin_bcd_multi
		PORT(
			num_bin: in  STD_LOGIC_VECTOR(15   downto 0);
			num_bcd: out STD_LOGIC_VECTOR(15 downto 0)
			);
		END COMPONENT;		

COMPONENT sumador_8bits
		PORT(
			A : IN std_logic_vector(7 downto 0);
			B : IN std_logic_vector(7 downto 0);
			Cin : IN std_logic;
			Signo1: IN std_logic;
			Signo2: IN std_logic;
			Cout : OUT std_logic;
			S: OUT std_logic;
			ResultadoSuma : OUT std_logic_vector(7 downto 0)
			);
	END COMPONENT;
	
COMPONENT sumador_8bits_sinSigno
	Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
          B : in  STD_LOGIC_VECTOR (7 downto 0);
			 Cin : in STD_LOGIC;
          Cout : out  STD_LOGIC;
          ResultadoSuma : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;
	
	
COMPONENT Restador
    PORT ( 
			  A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
			  Cin : in STD_LOGIC;
			  S1 : in STD_LOGIC;
			  S2 : in STD_LOGIC;
           ResultadoResta : out  STD_LOGIC_VECTOR (7 downto 0);
			  S: out STD_LOGIC;
           Cout : out  STD_LOGIC
			);
	END COMPONENT;

COMPONENT multiplicador_8bits	
		PORT ( 
			AMulti : in  STD_LOGIC_VECTOR (7 downto 0);
         BMulti : in  STD_LOGIC_VECTOR (7 downto 0);
			Signo1 : in  STD_LOGIC;
			Signo2 : in  STD_LOGIC;
         ResultadoMulti : out  STD_LOGIC_VECTOR (15 downto 0);
         SignoMulti : out  STD_LOGIC;
         CoutMulti : out  STD_LOGIC
			);
	END COMPONENT;
	
COMPONENT bcd_2_bin 
		PORT ( 
			bcd : in  STD_LOGIC_VECTOR (7 downto 0);
         bin : out  STD_LOGIC_VECTOR (7 downto 0):=(others => '0')
			);
END COMPONENT;

COMPONENT Multiplexor_4_a_1
    PORT ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           C : in  STD_LOGIC;
           sel : in  STD_LOGIC_VECTOR(1 downto 0);
           Salida : out  STD_LOGIC
			  );
END COMPONENT;

COMPONENT MultiplexorSalidaResultado
		PORT ( 
			A : in  STD_LOGIC_VECTOR (11 downto 0);
         B : in  STD_LOGIC_VECTOR (11 downto 0);
         C : in  STD_LOGIC_VECTOR (11 downto 0);
         CodigoOp : in  STD_LOGIC_VECTOR (1 downto 0);
         Salida : out  STD_LOGIC_VECTOR (11 downto 0)
			);
END COMPONENT;

COMPONENT Truncador
    PORT ( 
			ResultadoMulti : in  STD_LOGIC_VECTOR (15 downto 0);
         ResultadoTruncado : out  STD_LOGIC_VECTOR (7 downto 0)
			);
END COMPONENT;


-- Creacion de señales auxiliares

signal SignoBinario1:std_logic;
signal SignoBinario2:std_logic;

signal CodOp:std_logic_vector(1 downto 0);

signal RSuma:std_logic_vector(7 downto 0);
signal RResta:std_logic_vector(7 downto 0);
signal RMulti:std_logic_vector(15 downto 0);
signal RMultiTruncado:std_logic_vector(7 downto 0);

signal Binario1:std_logic_vector(7 downto 0);
signal Binario2:std_logic_vector(7 downto 0);

signal SigSuma:std_logic;
signal SigResta:std_logic;
signal SigMulti:std_logic;

signal SalidaSigno:std_logic; 
signal SalidaOverlFlow:std_logic;
signal SalidaCarry:std_logic; 
signal SalidaZeros:std_logic;

signal over_flow_multi:std_logic;
signal s_aux_o:std_logic_vector(1 downto 0);

signal AcarreoSuma:std_logic;
signal AcarreoResta:std_logic;
signal AcarreoMulti:std_logic;

signal bcd_suma:std_logic_vector(11 downto 0);
signal bcd_resta:std_logic_vector(11 downto 0);
signal bcd_multi:std_logic_vector(15 downto 0);
signal bcd_multi_final:std_logic_vector(11 downto 0);

signal AuxResultado:std_logic_vector(11 downto 0);

begin

-- Inicializacion de señales

SignoBinario1<=cod_op(3);
SignoBinario2<=cod_op(2);
CodOp<=cod_op(1 downto 0);

-- Creacion de instancias

Inst_bcd_a_bin1: bcd_2_bin PORT MAP(
			bcd=>op1,
			bin=>Binario1
		);
			
Inst_bcd_a_bin2: bcd_2_bin PORT MAP(
			bcd=>op2,
			bin=>Binario2
		);
		
Inst_sumador_8bits: sumador_8bits PORT MAP(
			A => Binario1,
			B => Binario2,
			Cin => '0',
			Signo1 => SignoBinario1,
			Signo2 => SignoBinario2,
			Cout => AcarreoSuma,
			S => SigSuma,
			ResultadoSuma => RSuma
		);
		
Inst_restador_8bits: Restador PORT MAP(
			A => Binario1,
			B => Binario2,
			S1 => SignoBinario1,
			S2 => SignoBinario2,
			Cin => '0',
			Cout => AcarreoResta,
			ResultadoResta => RResta,
			S => SigResta
		);		

Inst_multiplicador_8bits: multiplicador_8bits PORT MAP(
			AMulti=>Binario1,
			BMulti=>Binario2,
			Signo1=>SignoBinario1,
			Signo2=>SignoBinario2,
			ResultadoMulti=>RMulti,
			SignoMulti=>SigMulti,
			CoutMulti=>AcarreoMulti
		);
		
Inst_truncador: Truncador PORT MAP(
			ResultadoMulti=>RMulti,
			ResultadoTruncado=>RMultiTruncado
			);
			
			
Inst_Binario_BCD_Suma: bin_bcd PORT MAP(
			num_bin=>RSuma,
			num_bcd=>bcd_suma
			);
			
Inst_Binario_BCD_Resta: bin_bcd PORT MAP(
			num_bin=>RResta,
			num_bcd=>bcd_resta
			);
			
Inst_Binario_BCD_Multi: bin_bcd_multi PORT MAP(
			num_bin=>RMulti,
			num_bcd=>bcd_multi
			);
			
Inst_Binario_BCD_MultiTruncado: bin_bcd PORT MAP(
			num_bin=>RMultiTruncado,
			num_bcd=>bcd_multi_final
			);
				
		
Inst_multiplexor_salida_resultado: MultiplexorSalidaResultado PORT MAP(
			A=>bcd_suma,
			B=>bcd_resta,
			C=>bcd_multi_final,
			CodigoOp=>CodOp,
			Salida=>AuxResultado
		);
			

--Overflow de la multiplicacion
	over_flow_multi <= '0' when bcd_multi(15 downto 12)="0000" else
				'1';
				

--Salida signo
Inst_Mux_signo: Multiplexor_4_a_1 PORT MAP(
		A=>SigSuma, 
		B=>SigResta, 
		C=>SigMulti, 
		sel=>CodOp, 
		Salida=>SalidaSigno
		);
		
--Salida overflow
Inst_Mux_overflow: Multiplexor_4_a_1 PORT MAP(
		A=>'0', 
		B=>'0', 
		C=>over_flow_multi, 
		sel=>CodOp, 
		Salida=>SalidaOverlFlow
		);

--Salida carry 
Inst_Mux_carry: Multiplexor_4_a_1 PORT MAP(
		A=>AcarreoSuma, 
		B=>AcarreoResta, 
		C=>'0', 
		sel=>CodOp, 
		Salida=>SalidaCarry
		);
	
--Salida zero
	SalidaZeros <= '1' WHEN AuxResultado="000000000000" ELSE
			'0';
	
	--SALIDA TOTAL segun CE  ResultadoFinal
	result <= AuxResultado WHEN ce='1' ELSE
				"000000000000";
	
	c <= SalidaCarry WHEN ce='1' ELSE
			'0';
	
	o <= SalidaOverlFlow WHEN ce='1' ELSE
			'0';
			
	s <= SalidaSigno WHEN ce='1' ELSE
			'0';
			
	z <= SalidaZeros WHEN ce='1' ELSE
			'0';

end Behavioral;

