--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:42:18 04/11/2021
-- Design Name:   
-- Module Name:   D:/HMMY/project_cpu_1/IFSTAGE_topmodule_test.vhd
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

entity IFSTAGE_topmodule_test is
--  Port ( );
end IFSTAGE_topmodule_test;

architecture Behavioral of IFSTAGE_topmodule_test is

component IFSTAGE_topmodule is
    Port ( PC_Immed : in STD_LOGIC_VECTOR (31 downto 0); --same as RF
           PC_sel : in STD_LOGIC;
           PC_LdEn : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           instr : out STD_LOGIC_VECTOR(31 downto 0)
           );
    end component;
   
  signal PC_Immed:  STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
  signal PC_sel  : STD_LOGIC := '0';
  signal PC_LdEn : STD_LOGIC := '0';
  signal Clk     : STD_LOGIC := '0';
  signal Reset   : STD_LOGIC := '0';
  signal instr   : STD_LOGIC_VECTOR (31 downto 0);
  
  
  -- clock period
  constant Clk_period : time := 100 ns;

begin

    uut: IFSTAGE_topmodule
    port map ( PC_Immed => PC_Immed,
               PC_sel   => PC_sel,
               PC_LdEn  => PC_LdEn,
               Reset    => Reset,
               Clk      => Clk,
               instr       => instr);

   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
   
 stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		Reset<='1';
      wait for 100 ns;	
		
		Reset<='0';
		PC_Immed<="00000000000000000000000000000100";-- 1
      PC_Sel<='0'; --PC=PC=0
      PC_LdEn<='0';
      wait for Clk_period;
      
		PC_Immed<="00000000000000000000000000000100"; --epomeno 2
      PC_LdEn<='1'; --PC=PC+4
      wait for Clk_period;
      
		PC_Immed<="00000000000000000000000000000100"; --epomeno 3
      PC_Sel<='0'; --PC=PC+4
      PC_LdEn<='1';
      wait for Clk_period;
      
		PC_Immed<="00000000000000000000000000000100"; --2*epomeno 5
      PC_Sel<='1'; --PC=PC+4+Immediate=16
      PC_LdEn<='1';
      wait for Clk_period;
		
		PC_Immed<="11111111111111111111111111111000";  -- -8 5  logw load
		PC_Sel<='1'; --PC=PC+4+Immediate=16
      PC_LdEn<='0'; 
      wait for Clk_period;
		
		PC_Immed<="00000000000000000000000000000000"; -- 20
		PC_Sel<='1';
      PC_LdEn<='1'; 
      wait for Clk_period;

		PC_Immed<="11111111111111111111111111111000"; -- meiwnetai -4
		PC_Sel<='1'; 
      PC_LdEn<='1'; 
      wait for Clk_period;
      

      wait;
   end process;   



end Behavioral;