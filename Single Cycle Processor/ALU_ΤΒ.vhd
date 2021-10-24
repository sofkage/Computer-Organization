--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:45:03 04/11/2021
-- Design Name:   
-- Module Name:   D:/HMMY/project_cpu_1/ALU_test.vhd
-- Project Name:  project_cpu_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
 
ENTITY ALU_test IS
END ALU_test;
 
ARCHITECTURE behavior OF ALU_test IS 
  
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op: std_logic_vector(3 downto 0)  := (others => '0');

   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
 
BEGIN
 
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

 
   -- Stimulus process
   stim_proc: process
   begin		
    
		Op <= "0000";
		-- Op <= "0001";
	    -- Op <= "0010";
		-- Op <= "0011";
		-- Op <= "0100";
		-- Op <= "0101";
		-- Op <= "1010";
		-- Op <= "1100";
		-- Op <= "1101";

		A <= "00000000000000000000000000000000";
		B <= "00000000000000000000000000000000";
		wait for 100 ns;
		
		A <= "00000000000000000000000000000001";
		B <= "00000000000000000000000000000000";
		wait for 100 ns;
		
		A <= "00000000000000000000000000000000";
		B <= "00000000000000000000000000000001";
		wait for 100 ns;

		A <= "00000000000000000000000000000011";
		B <= "00000000000000000000000000000000";
		wait for 100 ns;
		
		A <= "10000000000000000000000000000000";
		B <= "00000000000000000000000000000000";
		wait for 100 ns;

	
		A <= "00000000000000000000000000000000";
		B <= "10000000000000000000000000000000";
		wait for 100 ns;	
		
		A <= "10000000000000000000000000000001";
		B <= "10000000000000000000000000000001";
		wait for 100 ns;
		
		A <= "00000110100101101000000000000000";
		B <= "00000000000000000000000000000000";
		wait for 100 ns;
		
		A <= "00000011110101010101110000000000";
		B <= "11101010101111101010101010111110";
		wait for 100 ns;

		A <= "00000001111010101010111000000000";
		B <= "11111111111111111111111111111111";
		wait for 100 ns;
		
		A <= "11111111111111111111111111111111";
		B <= "00000001111010101010111000000000";
		wait for 100 ns;
		
		A <= "10000000000000000000000000000000";
		B <= "11111111111111111111111111111111";
		wait for 100 ns;
		
		A <= "01111111111111100000000000000001";
		B <= "00011111111111111111111111111111";
		wait for 100 ns;
		
		
		A <= "00000011000000000000000000000000";
		B <= "00001011010010110100000000000000";
		wait for 100 ns;
		
		A <= "00000000000000000000000000000000";
		B <= "00000000000000000000000000000000";
		wait for 100 ns;
		
				
		A <= "00000000000000000000000000000000";
		B <= "01111111111111111111111111111111";
		wait for 100 ns;
		
		A <= "10001111110101011111100000000001";
		B <= "10000000000000000000000000000001";
		wait for 100 ns;


		A <= "00000000000000000000000000000000";
		B <= "11111111111111111111111111111111";
		wait for 100 ns;
								
		A <= "01111111111111111111111111111111";
		B <= "11111111111111111111111111111111";
		wait for 100 ns;
		
		A <= "01111111111111111111111111111111";
		B <= "11111111111111111111111111111110";
		wait for 100 ns;
		
	    A <= "01111111111111111111111111111111";
		B <= "00000000000000000000000000000000";
		wait for 100 ns;

		A <= "11111111111111111111111111111111";
		B <= "00000000000000000000000000000000";
		wait for 100 ns;

		
		A <= "11111111111111111111111111111111";
		B <= "11111111111111111111111111111110";
		wait for 100 ns;

		A <= "11111111111111111111111111111111";
		B <= "01111111111111111111111111111111";
		wait for 100 ns;

		A <= "11111111111111111111111111111111";
		B <= "11111111111111111111111111111111";
		wait for 100 ns;
		
      wait;
   end process;

END;