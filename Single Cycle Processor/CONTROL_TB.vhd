--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:01:37 04/17/2021
-- Design Name:   
-- Module Name:   D:/HMMY/project_cpu_1/CONTROL2_TB.vhd
-- Project Name:  project_cpu_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL2
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
 
ENTITY CONTROL2_TB IS
END CONTROL2_TB;
 
ARCHITECTURE behavior OF CONTROL2_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL2
    PORT(
         zero : IN  std_logic;
			OpCode : IN  std_logic_vector(5 downto 0);
         func : IN  std_logic_vector(5 downto 0);
         ByteOp : OUT  std_logic;
         Reset : IN  std_logic;
         PC_Reset : OUT  std_logic;
         MeM_WrEn : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         PC_Sel : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         ImmExt : OUT  std_logic_vector(1 downto 0));
       --  Clk : IN  std_logic
        
    END COMPONENT;
    

   --Inputs
   signal zero : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';
 signal OpCode : std_logic_vector(5 downto 0) := (others => '0');
   signal func : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal ByteOp : std_logic;
   signal PC_Reset : std_logic;
   signal MeM_WrEn : std_logic;
   signal PC_LdEn : std_logic;
   signal PC_Sel : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal ImmExt : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL2 PORT MAP (
          zero => zero,
          OpCode => OpCode,
			 func=>func,
          ByteOp => ByteOp,
          Reset => Reset,
          PC_Reset => PC_Reset,
          MeM_WrEn => MeM_WrEn,
          PC_LdEn => PC_LdEn,
          PC_Sel => PC_Sel,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ImmExt => ImmExt);

   -- Stimulus process
   stim_proc: process
   begin		
 		Reset<='1';
      wait for 100 ns;	

		Reset<='0';
		
		OpCode<="100000";
		func<="110000"; --add
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110000"; --add
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110001";--sub
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110001";--sub
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110010"; --and
		zero<='0';
      wait for 100 ns;
		
		OpCode<="100000";
		func<="110010"; --and
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110011";--or
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110011";--or
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110100";--not
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110100";--not
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110101";--nand
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110101";--nand
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110110";--nor
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="110110";--nor
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="111000";--sra
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="111000";--sra
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="111001";--srl
		zero<='0';
      wait for 100 ns;
		
		OpCode<="100000";
		func<="111001";--srl
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="111010";--sll
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="111010";--sll
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="111100";--rol
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="111100";--rol
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="111101";--ror
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="100000";
		func<="111101";--ror
		zero<='1';
      wait for 100 ns;	
		
		----------------------------------------
		func<="110100";--not --dont care

	
		OpCode<="111000";--li
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="111000";--li
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="111001";--lui
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="111001";--lui
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="110000";--addi
		zero<='0';
      wait for 100 ns;
		
		OpCode<="110000";--addi
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="110010";--nandi
		zero<='0';
      wait for 100 ns;
		
		OpCode<="110010";--nandi
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="110011";--ori
		zero<='0';
      wait for 100 ns;
		
		OpCode<="110011";--ori
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="111111"; --b
		zero<='0';
      wait for 100 ns;
		
		OpCode<="111111"; --b
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="000000";--beq
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="000000";--beq
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="000001";--bne
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="000001";--bne
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="000011";--lb
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="000011";--lb
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="000111";--sb
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="000111";--sb
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="001111";--lw
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="001111";--lw
		zero<='1';
      wait for 100 ns;	
		
		OpCode<="011111";--sw
		zero<='0';
      wait for 100 ns;	
		
		OpCode<="011111";--sw
		zero<='1';
      wait for 100 ns;	
		      wait;
   end process;
END;
