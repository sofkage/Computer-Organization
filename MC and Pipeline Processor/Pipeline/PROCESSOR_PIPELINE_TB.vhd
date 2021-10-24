--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:46:26 05/02/2021
-- Design Name:   
-- Module Name:   D:/HMMY/project_cpu_1/PROCESSOR_PIPELINE_TB.vhd
-- Project Name:  project_cpu_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PROCESSOR_PIPELINE
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
 
ENTITY PROCESSOR_PIPELINE_TB IS
END PROCESSOR_PIPELINE_TB;
 
ARCHITECTURE behavior OF PROCESSOR_PIPELINE_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROCESSOR_PIPELINE
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         MM_RdData : IN  std_logic_vector(31 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         PC : OUT  std_logic_vector(31 downto 0);
         MM_WrData : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    
component RAM
    port(
    	clk : in std_logic;
		inst_addr : in std_logic_vector(10 downto 0);
		inst_dout : out std_logic_vector(31 downto 0);
		data_we : in std_logic;
		data_addr : in std_logic_vector(10 downto 0);
		data_din : in std_logic_vector(31 downto 0);
		data_dout : out std_logic_vector(31 downto 0)
    );
    end component;

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MM_WrEn : std_logic;
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal PC : std_logic_vector(31 downto 0);
   signal MM_WrData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 200 ns;
 
BEGIN 
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROCESSOR_PIPELINE PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Instr => Instr,
          MM_RdData => MM_RdData,
          MM_WrEn => MM_WrEn,
          MM_Addr => MM_Addr,
          PC => PC,
          MM_WrData => MM_WrData
        );


memory: 
		RAM port map(Clk=>Clk,
							inst_addr=>PC(12 downto 2),
							inst_dout=>Instr,
							data_we=>MM_WrEn,
							data_addr=>MM_Addr(12 downto 2),
							data_din=>MM_WrData, 
							data_dout=>MM_RdData);
						
						
   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
			
		Reset<='1';
      wait for Clk_period*5;
		
		Reset<='0';
      wait for Clk_period;

      -- insert stimulus here 

      wait;
   end process;

END;
