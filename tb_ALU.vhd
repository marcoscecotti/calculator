--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:34:14 06/09/2018
-- Design Name:   
-- Module Name:   C:/Users/Milton/Desktop/VHDLs/TP2018/TP2018/tb_ALU.vhd
-- Project Name:  TP2018
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_ALU IS
END tb_ALU;
 
ARCHITECTURE behavior OF tb_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         op1 : IN  std_logic_vector(7 downto 0);
         op2 : IN  std_logic_vector(7 downto 0);
         cod_op : IN  std_logic_vector(7 downto 0);
         ce : IN  std_logic;
         result : OUT  std_logic_vector(11 downto 0);
         o : OUT  std_logic;
         z : OUT  std_logic;
         c : OUT  std_logic;
         s : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal op1 : std_logic_vector(7 downto 0) := (others => '0');
   signal op2 : std_logic_vector(7 downto 0) := (others => '0');
   signal cod_op : std_logic_vector(7 downto 0) := (others => '0');
   signal ce : std_logic := '0';

 	--Outputs
   signal result : std_logic_vector(11 downto 0);
   signal o : std_logic;
   signal z : std_logic;
   signal c : std_logic;
   signal s : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          op1 => op1,
          op2 => op2,
          cod_op => cod_op,
          ce => ce,
          result => result,
          o => o,
          z => z,
          c => c,
          s => s
        );
 

   -- Stimulus process
   stim_proc: process
   begin	

			op1<="01100000";
         op2<="01100000";
         cod_op<="00000000";
         ce<='1';
			wait for 10 ns;
			op1<="01100000";
         op2<="01100000";
         cod_op<="00001000";
         ce<='1';
			wait for 10 ns;
			op1<="01100000";
         op2<="01100000";
         cod_op<="00000100";
         ce<='1';
			wait for 10 ns;
			op1<="01100000";
         op2<="01100000";
         cod_op<="00001100";
         ce<='1';
     wait;
   end process;

END;
