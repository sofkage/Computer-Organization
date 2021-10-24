--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:41:20 04/11/2021
-- Design Name:   
-- Module Name:   D:/HMMY/project_cpu_1/RAM_test.vhd
-- Project Name:  project_cpu_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RAM
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
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RAM_test IS
END RAM_test;
 
ARCHITECTURE behavior OF RAM_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM
    PORT(
         clk : IN  std_logic;
         inst_addr : IN  std_logic_vector(10 downto 0);
         inst_dout : OUT  std_logic_vector(31 downto 0);
         data_we : IN  std_logic;
         data_addr : IN  std_logic_vector(10 downto 0);
         data_din : IN  std_logic_vector(31 downto 0);
         data_dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal inst_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal data_we : std_logic := '0';
   signal data_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal data_din : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal inst_dout : std_logic_vector(31 downto 0);
   signal data_dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM PORT MAP (
          clk => clk,
          inst_addr => inst_addr,
          inst_dout => inst_dout,
          data_we => data_we,
          data_addr => data_addr,
          data_din => data_din,
          data_dout => data_dout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	data_we <='0';
      data_addr <="00000000000";
      data_din <=x"00000000";
      inst_addr <= "00000000000";
       wait for clk_period*10;
		 
      --opcode
      for i in 0 to 12 loop
      inst_addr <= inst_addr + "00000000001";
      wait for clk_period*10;
      end loop;
      
      --func
      for i in 13 to 21 loop
      inst_addr <= inst_addr + "00000000001";
      wait for clk_period*10;
      end loop;
      
      --check data segment
      data_we <='1';
      data_addr <="10000000001";
      data_din <=x"00000001";
      wait for clk_period*10;
      
      data_we <='0';
      data_addr <="10000000001";
      data_din <=x"00000111";
      wait for clk_period*10;
      
      data_we <='0';
      data_addr <="10000000000";
      data_din <=x"00000011";
      wait for clk_period*10;
      
      data_we <='1';
      data_addr <="10000000000";
      data_din <=x"00000011";
      wait for clk_period*10;
      
      data_we <='0';
      data_addr <="10000000000";
      data_din <=x"00001111";
      wait for clk_period*10;    
		wait;
   end process;

END;
