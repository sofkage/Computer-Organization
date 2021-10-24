--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:43:01 04/11/2021
-- Design Name:   
-- Module Name:   D:/HMMY/project_cpu_1/MEMSTAGE_topmodule_test.vhd
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

entity MEMSTAGE_topmodule_test is
--  Port ( );
end MEMSTAGE_topmodule_test;

architecture Behavioral of MEMSTAGE_topmodule_test is

    component topModule_MEM 
        Port ( ByteOp : in STD_LOGIC;
            Mem_WrEn : in STD_LOGIC;
            ALU_MEM_Addr : in STD_LOGIC_VECTOR (31 downto 0);
            MEM_DataIn : in STD_LOGIC_VECTOR (31 downto 0);
            MEM_DataOut : out STD_LOGIC_VECTOR (31 downto 0);
            clk : in STD_LOGIC);
            
         end component;

   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal MEM_DataOut : std_logic_vector(31 downto 0);


   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
begin

	-- Instantiate the Unit Under Test (UUT)
   uut: topModule_MEM PORT MAP (
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut,
          Clk => Clk
        );
        
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
      -- hold reset state for 100 ns
		
		
      ByteOp<='0'; --lw
		MEM_WrEn<='0';
		ALU_MEM_Addr<=x"00000001";  									-- apotelesma alu
		MEM_DataIn<="11111111111111111111111111111111";			-- gia apothikeysh sth mnhmh
      wait for Clk_period;
		
		ByteOp<='0'; --sw
		MEM_WrEn<='1';  -- eggrafh
		ALU_MEM_Addr<=x"00000001";
		MEM_DataIn<="11111111111111111111111111111111";
      wait for Clk_period;
		
		ByteOp<='0'; --sw
		MEM_WrEn<='1'; -- eggrafh
		ALU_MEM_Addr<=x"00000001";
		MEM_DataIn<="11111111111111111111111100000000";
      wait for Clk_period;
		
		ByteOp<='0'; --lw
		MEM_WrEn<='0';
		ALU_MEM_Addr<=x"00000001";
		MEM_DataIn<="00000000111111111111111111111111";
      wait for Clk_period;
		
		ByteOp<='1'; --lb
		MEM_WrEn<='0';
		ALU_MEM_Addr<=x"00000011";
		MEM_DataIn<="11111111111111111111111111111111";
      wait for Clk_period;
		
		ByteOp<='1'; --sb
		MEM_WrEn<='1'; -- eggrafh
		ALU_MEM_Addr<=x"00000011";
		MEM_DataIn<="11111111111111111111111111111111";
      wait for Clk_period;
		
		ByteOp<='1'; --sb 
		MEM_WrEn<='1'; -- eggrafh
		ALU_MEM_Addr<=x"00000011";
		MEM_DataIn<="11111111111111111111111100000000";
      wait for Clk_period;
		
		ByteOp<='1'; --lb
		MEM_WrEn<='0';
		ALU_MEM_Addr<=x"00000011";
		MEM_DataIn<="00000000111111111111111111111110";
      wait for Clk_period;
		
		ByteOp<='0'; --sw
		MEM_WrEn<='1'; -- eggrafh
		ALU_MEM_Addr<=x"00000010";
		MEM_DataIn<="11111111111111111100000000000111";
      wait for Clk_period;
		
		ByteOp<='0'; --sw
		MEM_WrEn<='1'; -- eggrafh
		ALU_MEM_Addr<=x"00000010";
		MEM_DataIn<="11111000000000000001111111111111";
      wait for Clk_period;
      -- insert stimulus here 
		
		ByteOp<='1'; --lb
		MEM_WrEn<='0';
		ALU_MEM_Addr<=x"00000011";
		MEM_DataIn<="00000000111111111111111111111110";
      wait for Clk_period;

      wait;
   end process;

end Behavioral;
