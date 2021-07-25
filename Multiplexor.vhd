----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:47:58 05/21/2018 
-- Design Name: 
-- Module Name:    MultiplexorSalidaResultado - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MultiplexorSalidaResultado is
    Port ( A : in  STD_LOGIC_VECTOR (11 downto 0);
           B : in  STD_LOGIC_VECTOR (11 downto 0);
           C : in  STD_LOGIC_VECTOR (11 downto 0);
           CodigoOp : in  STD_LOGIC_VECTOR (1 downto 0);
           Salida : out  STD_LOGIC_VECTOR (11 downto 0));
end MultiplexorSalidaResultado;

architecture Behavioral of MultiplexorSalidaResultado is

begin

Salida <= A WHEN CodigoOp ="00" ELSE 
            B WHEN CodigoOp ="01" ELSE 
				C WHEN CodigoOp ="10" ELSE 
				"000000000000" ;


end Behavioral;

