--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:45:30 04/11/2021
-- Design Name:   
-- Module Name:   D:/HMMY/project_cpu_1/DECSTAGE_test.vhd
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DECSTAGE_test is
--  Port ( );
end DECSTAGE_test;

architecture Behavioral of DECSTAGE_test is

component DECSTAGE 
    Port ( Instr : in STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in STD_LOGIC;
           ALU_out : in STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in STD_LOGIC;
           RF_B_sel : in STD_LOGIC;
           ImmExt : in STD_LOGIC_VECTOR (1 downto 0);
           Clk : in STD_LOGIC;
           Immed : out STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out STD_LOGIC_VECTOR (31 downto 0);
           Rst : in STD_LOGIC);
           
     end component;
     
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Rst : STD_LOGIC := '0';
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   constant Clk_period : time := 100 ns; 

begin

    uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          Clk => Clk,
			 Rst => Rst,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
        );
        
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
		Rst<='1';
      wait for 100 ns;
		Rst<='0';
 
		Instr<="01010000001000110001011111111111"; --emfaniz 1 2 graph 3
		
		 RF_WrEn <='0';
		 ALU_out <=x"00000001";
		 MEM_out <=x"00000002";
		 RF_WrData_sel <='1'; --alu
		 RF_B_sel <='0';
		 ImmExt <="00";
      wait for Clk_period;
		
		Instr<="01010000001000110001011111111111"; --emfaniz 1 2 graph 3
		
		 RF_WrEn <='0';
		 ALU_out <=x"00000001";
		 MEM_out <=x"00000002";
		 RF_WrData_sel <='0'; --mem
		 RF_B_sel <='0';
		 ImmExt <="00";
      wait for Clk_period;

		Instr<="01010000001000110001011111111111"; --emfaniz 1 2 graph 3
		--theloume na doume to 0
		 RF_WrEn <='1';
		 ALU_out <=x"00000001";
		 MEM_out <=x"00000002";
		 RF_WrData_sel <='1'; --alu
		 RF_B_sel <='0';
		 ImmExt <="00";
      wait for Clk_period;
		
		Instr<="01010000001000110001011111111111"; --emfaniz 1 2 graph 3
		--theloume na doume to 0
		 RF_WrEn <='0';
		 ALU_out <=x"00000001";
		 MEM_out <=x"00000002";
		 RF_WrData_sel <='0'; --mem
		 RF_B_sel <='0';
		 ImmExt <="00";
      wait for Clk_period;




		Instr<="01010000001000110001111111111111"; --emfaniz 1 3 graph 3
		--theloume na doume to 2 apo ton prohg kyklo 
		 RF_WrEn <='0';
		 ALU_out <=x"00000001";
		 MEM_out <=x"00000002";
		 RF_WrData_sel <='1'; --alu
		 RF_B_sel <='0';
		 ImmExt <="00";
      wait for Clk_period;
		
		Instr<="01010000001000110001111111111111"; --emfaniz 1 3 graph 3
		--theloume na doume to 1
		 RF_WrEn <='1';
		 ALU_out <=x"00000001";
		 MEM_out <=x"00000002";
		 RF_WrData_sel <='1'; --alu
		 RF_B_sel <='0';
		 ImmExt <="00";
      wait for Clk_period;
		
		Instr<="01010000001001001100011111111111"; --emfaniz 1 4 graph 4 Immed 1100011111111111
		--theloume na doume to 1 kai Immed zerofill
		 RF_WrEn <='0';
		 ALU_out <=x"00000001";
		 MEM_out <=x"00000002";
		 RF_WrData_sel <='1'; --alu
		 RF_B_sel <='1';
		 ImmExt <="00";
		
      wait for Clk_period;
		
		Instr<="01010000001001001100011111111111"; --emfaniz 1 4 graph 4 Immed 1100011111111111
		--theloume na doume to 2 kai Immed signextend
		 RF_WrEn <='1';
		 ALU_out <=x"00000001";
		 MEM_out <=x"00000002";
		 RF_WrData_sel <='0'; --mem
		 RF_B_sel <='1';
		 ImmExt <="01";
		
      wait for Clk_period;
		
		Instr<="01010000001001001100011111111111"; --emfaniz 1 4 graph 4 Immed 1100011111111111
		--theloume na doume to 1 kai Immed signextend<<2
		 RF_WrEn <='1';
		 ALU_out <=x"00000001";
		 MEM_out <=x"00000002";
		 RF_WrData_sel <='1'; --alu
		 RF_B_sel <='1';
		 ImmExt <="10";
		
      wait for Clk_period;
		
		Instr<="01010000001001001100011111111111"; --emfaniz 1 4 graph 4 Immed 1100011111111111
		--theloume na doume to 1 kai Immed<<16 zerofill
		 RF_WrEn <='0';
		 ALU_out <=x"00000001";
		 MEM_out <=x"00000002";
		 RF_WrData_sel <='1'; --alu
		 RF_B_sel <='1';
		 ImmExt <="11";
		
      wait for Clk_period;
      -- insert stimulus here 

      wait;
   end process;

end Behavioral;
