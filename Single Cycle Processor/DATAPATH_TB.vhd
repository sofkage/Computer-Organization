--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:21:45 04/13/2021
-- Design Name:   
-- Module Name:   D:/HMMY/project_cpu_1/DATAPATH_TB_rom4.vhd
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DATAPATH_TB IS
END DATAPATH_TB;
 
ARCHITECTURE behavior OF DATAPATH_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         RF_B_sel : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_WrEn : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_zero : OUT  std_logic;
         ByteOp : IN  std_logic;
         MEM_WrEn : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         PC : OUT  std_logic_vector(31 downto 0);
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         MM_WrData : OUT  std_logic_vector(31 downto 0);
         MM_WrEn : OUT  std_logic;
         MM_RdData : IN  std_logic_vector(31 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0)
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
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal ByteOp : std_logic := '0';
   signal MEM_WrEn : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal ALU_zero : std_logic;
   signal PC : std_logic_vector(31 downto 0);
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal MM_WrData : std_logic_vector(31 downto 0);
   signal MM_WrEn : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN



 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          RF_B_sel => RF_B_sel,
          RF_WrData_sel => RF_WrData_sel,
          RF_WrEn => RF_WrEn,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_zero => ALU_zero,
          ByteOp => ByteOp,
          MEM_WrEn => MEM_WrEn,
          ImmExt => ImmExt,
          PC => PC,
          MM_Addr => MM_Addr,
          MM_WrData => MM_WrData,
          MM_WrEn => MM_WrEn,
          MM_RdData => MM_RdData,
          RST => RST,
          CLK => CLK,
          Instr => Instr
        );

memory: 
		RAM port map(Clk=>CLK,
							inst_addr=>PC(12 downto 2), 
							inst_dout=>Instr, 
							data_we=>MM_WrEn,
							data_addr=>MM_Addr(12 downto 2),
							data_din=>MM_WrData,
							data_dout=>MM_RdData);
		
   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
	


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST<='1';
      wait for 100 ns;	
		
		RST<='0';
		
--addi r2,r0,3; -> 0011
		PC_sel<='0';
		PC_LdEn<='1'; 
		RF_B_sel<='1'; 		--immediate ->rd in ard2
		RF_WrData_sel<='0';  --alu out
		RF_WrEn<='1';
		ALU_Bin_sel<='1'; 	--immediate 
		ALU_func<="0000"; 	--add
		Mem_WrEn<='0';
		ByteOp<='0'; 			--dont care
		ImmExt<="01"; 			--sign extend
      wait for CLK_period;

--li r3, 15; -> 1111
		PC_sel<='0';
		PC_LdEn<='1';
		RF_B_sel<='1'; 		--rd in ard2
		RF_WrData_sel<='0'; 	--alu out
		RF_WrEn<='1';
		ALU_Bin_sel<='1'; 	--immediate
		ALU_func<="0000"; 	--add with r0 ->results in immediate
		Mem_WrEn<='0';
		ByteOp<='0';			--dont care
		ImmExt<="01";			--sign extend
		wait for CLK_period;
		
--nand r4, r2, r3; -> 1100
		PC_sel<='0';
		PC_LdEn<='1';
		RF_B_sel<='0'; 		--rt
		RF_WrData_sel<='0'; 	--alu out
		RF_WrEn<='1';
		ALU_Bin_sel<='0'; 	--rf_b
		ALU_func<="0101"; 	--nand
		Mem_WrEn<='0';
		ByteOp<='0';			--dont care
		ImmExt<="00";			--dont care
		wait for CLK_period;
		
--not r5, r2; --> !0011=1100
		PC_sel<='0';
		PC_LdEn<='1';
		RF_B_sel<='0'; 		--rt dont care
		RF_WrData_sel<='0'; 	--alu out
		RF_WrEn<='1';
		ALU_Bin_sel<='0'; 	-- rfB --dont care
		ALU_func<="0100"; 	--not
		Mem_WrEn<='0';
		ByteOp<='0';			--dont care
		ImmExt<="01";			--dont care
		wait for CLK_period;
		
--beq r4, r5, 2; 			--execute bne, so r7, r8 are zero
		PC_sel<='1'; 		--valid branch -1st execution
		PC_LdEn<='1';
		RF_B_sel<='1'; 		--rd because immediate
		RF_WrData_sel<='0'; 	--alu out
		RF_WrEn<='0'; 			--branch - no write in rf
		ALU_Bin_sel<='0'; 	--rf_b
		ALU_func<="0001"; 	--sub
		Mem_WrEn<='0';
		ByteOp<='0'; --dont care
		ImmExt<="10"; --sign extend<<2
		wait for CLK_period;
		
-----------------------------------------------------------
--bne r8,r7,1 --false. Will execute next line at first execution and true at second execution = execute addi and skip b
		PC_sel<='0';		 		--invalid branch r7 = r8 = 0
		PC_LdEn<='1';
		RF_B_sel<='1'; 			--rd in ard2 of rf
		RF_WrData_sel<='0'; 		--dont care
		RF_WrEn<='0'; 				--branch
		ALU_Bin_sel<='0'; 		--rf_B
		ALU_func<="0001";			--sub
		Mem_WrEn<='0';
		ByteOp<='1'; 				--dont care
		ImmExt<="10"; 				--sign extend <<2
		wait for CLK_period;
		
--b -4; -> will execute nor at addr 20
		PC_sel<='1'; 				--branch
		PC_LdEn<='1';
		RF_B_sel<='1';			 	--rd in ard2
		RF_WrData_sel<='0'; 		--dont care
		RF_WrEn<='0'; 				--dont write in rf because branch
		ALU_Bin_sel<='0'; 		--rf_B
		ALU_func<="0001"; 		--sub
		Mem_WrEn<='0'; 
		ByteOp<='0'; 				--dont care
		ImmExt<="10"; 				--sign extend<<2
		wait for CLK_period;
-----------------------------------------------------------
		
--nor r8, r3, r4; -> 0000 at r8
		PC_sel<='0';
		PC_LdEn<='1'; 
		RF_B_sel<='0'; 			--rt
		RF_WrData_sel<='0';		--alu out
		RF_WrEn<='1';
		ALU_Bin_sel<='0'; 		--rf_b
		ALU_func<="0110"; 		--nor
		Mem_WrEn<='0';
		ByteOp<='0'; 				--dont care
		ImmExt<="00";				--zero fill -dont care
		wait for CLK_period;
		
--srl r7, r4; -> 0110 in r7
		PC_sel<='0';
		PC_LdEn<='1';
		RF_B_sel<='1'; 			 --dont care
		RF_WrData_sel<='0';		 --alu out
		RF_WrEn<='1';
		ALU_Bin_sel<='0'; 		 --dont care
		ALU_func<="1001"; 		 --srl
		Mem_WrEn<='0';
		ByteOp<='0'; 				 --dont care
		ImmExt<="01"; 				 --dont care
		wait for CLK_period;
		
--bne r8,r7,1 -> false and execute next line at first execution and true at second execution ->execute addi and end (skip b)
		PC_sel<='1'; 			--valid branch because r7 and r8 are not equal
		PC_LdEn<='1';
		RF_B_sel<='1'; 		--rd in ard2 of rf
		RF_WrData_sel<='0'; 	--dont care
		RF_WrEn<='0'; 			--branch
		ALU_Bin_sel<='0'; 	--rf_B
		ALU_func<="0001"; 	--sub
		Mem_WrEn<='0';
		ByteOp<='1'; 			--dont care
		ImmExt<="10"; 			--sign extend <<2
		wait for CLK_period;
		
----b -4; -- go and execute nor at address 20
--		PC_sel<='1'; --branch
--		PC_LdEn<='1';
--		RF_B_sel<='1'; --rd in ard2
--		RF_WrData_sel<='0'; --dont care
--		RF_WrEn<='0'; --dont write in rf because branch
--		ALU_Bin_sel<='0'; --rfB
--		ALU_func<="0001"; --sub
--		Mem_WrEn<='0'; 
--		ByteOp<='0'; --dont care
--		ImmExt<="10"; --sign extend<<2
--		wait for CLK_period;
		
--addi r10, r0, 1;
		PC_sel<='0'; 
		PC_LdEn<='1';
		RF_B_sel<='1'; 		--rd in ard2 of rf
		RF_WrData_sel<='0'; 	--slu out
		RF_WrEn<='1';
		ALU_Bin_sel<='1'; 	--immediate
		ALU_func<="0000"; 	--add
		Mem_WrEn<='0';
		ByteOp<='1'; 			--dont care
		ImmExt<="01"; 			--sign extend 
		wait for CLK_period;
		


      wait;
   end process;

END;
