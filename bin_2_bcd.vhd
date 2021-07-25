----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:28:08 05/23/2018 
-- Design Name: 
-- Module Name:    bin_2_bcd - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin_2_bcd is
    Port ( bin : in  STD_LOGIC_VECTOR (8 downto 0);
           bcd : out  STD_LOGIC_VECTOR (10 downto 0));
end bin_2_bcd;

architecture Behavioral of bin_2_bcd is
begin
    proceso_bcd: process(bin)
        variable z: STD_LOGIC_VECTOR(19 downto 0);
    begin
        -- Inicialización de datos en cero.
        z := (others => '0');
        -- Se realizan los primeros tres corrimientos.
        z(11 downto 3) := bin;
        for i in 0 to 5 loop
            -- Unidades (4 bits).
            if z(12 downto 9) > 4 then
                z(12 downto 9) := z(12 downto 9) + 3;
            end if;
            -- Decenas (4 bits).
            if z(16 downto 13) > 4 then
                z(16 downto 13) := z(16 downto 13) + 3;
            end if;
            -- Centenas (3 bits).
            if z(19 downto 17) > 4 then
                z(19 downto 17) := z(19 downto 17) + 3;
            end if;
            -- Corrimiento a la izquierda.
            z(19 downto 1) := z(18 downto 0);
        end loop;
        -- Pasando datos de variable Z, correspondiente a BCD.
        bcd <= z(19 downto 9);
    end process;
end Behavioral;

