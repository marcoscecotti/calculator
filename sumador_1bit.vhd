----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:23:35 05/17/2018 
-- Design Name: 
-- Module Name:    sumador_1bit - Behavioral 
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

entity sumador_1bit is
    Port ( Ai : in  STD_LOGIC;
           Bi : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Si : out  STD_LOGIC);
end sumador_1bit;

architecture Behavioral of sumador_1bit is

begin

Si <= (Ai xor Bi) xor Cin;
Cout <= (Ai and Bi) or ((Ai xor Bi) and Cin);

end Behavioral;

