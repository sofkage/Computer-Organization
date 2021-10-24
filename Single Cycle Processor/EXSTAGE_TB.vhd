--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:46:01 04/11/2021
-- Design Name:   
-- Module Name:   D:/HMMY/project_cpu_1/EXSTAGE_test.vhd
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

entity EXSTAGE_test is
--  Port ( );
end EXSTAGE_test;

architecture Behavioral of EXSTAGE_test is
    
    component  EXSTAGE
    port (RF_A : in  std_logic_vector(31 downto 0);
          RF_B : in  std_logic_vector(31 downto 0);
          Immed : in  std_logic_vector(31 downto 0);
          ALU_bin_sel : in  std_logic;  
          ALU_func : in  std_logic_vector(3 downto 0); --ti praksh tha kanei
          ALU_out : out  std_logic_vector(31 downto 0);  
          ALU_zero : out  std_logic
       );
    end component;
   
    signal RF_A :   std_logic_vector(31 downto 0) := (others => '0');
    signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
    signal Immed : std_logic_vector(31 downto 0) := (others => '0');
    signal ALU_bin_sel : std_logic := '0';
    signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
    signal ALU_out : std_logic_vector(31 downto 0);
    signal ALU_zero : std_logic;
    
   
begin

    uut: EXSTAGE port map (
              RF_A  => RF_A,
              RF_B  => RF_B,
              Immed => Immed,
              ALU_bin_sel => ALU_bin_sel,
              ALU_func    => ALU_func,  --prakseis tis alu
              ALU_out     => ALU_out,
              ALU_zero    => ALU_zero
    ); 

stim_proc: process
   begin		

     	ALU_func<="0000";
     	ALU_bin_sel<='0'; --B
     	
        RF_A<="00000000000000000000000000000000";
        RF_B<="00000000000000000000000000000000"; --0
        Immed<="00000000000000000000000000010000";
        wait for 100 ns;
        
        ALU_bin_sel<='1'; --immed
        RF_A<="00000000000000000000000000000000";
        RF_B<="00000000000000000000000001111111";
        Immed<="00000000000000000000000000000001"; --1
        wait for 100 ns;
        
        ALU_bin_sel<='0'; --B
        RF_A<="00000000000000000000000000000101";
        RF_B<="00000000000000000000000000000011";
        Immed<="00000000000000000000000000010000";
        wait for 100 ns;
        
        ALU_func<="0001";
        ALU_bin_sel<='0'; --B
        
        RF_A<="00000000000000000000000000000000";
        RF_B<="00111011100110101100101000000000";--expected 2s complement
        Immed<="00000000000000000000000000010000";
        wait for 100 ns;
        
        ALU_bin_sel<='1';
        
        RF_A<="00000000000000000000000000000000";
        RF_B<="01111111111111111111111111111110";
        Immed<="00000000000000000000000000010000";
        wait for 100 ns;
        
        ALU_func<="0100";
     	ALU_bin_sel<='0';
     	
        RF_A<="00000000000000000000000000000000"; 
        RF_B<="01111111111111111111111111111111"; 
        Immed<="00000000000000000000000000010000";
        wait for 100 ns;
        
        ALU_bin_sel<='1';
        RF_A<="00000000000000000000000000011111";
        RF_B<="11111111111111111111111111111111";
        Immed<="00000000000000000000000000010000";
        wait for 100 ns;
        
        ALU_func<="0011";
     	ALU_bin_sel<='0';
     	
        RF_A<="00000000000000000000000001111111";
        RF_B<="01111111111111111111111111111111";
        Immed<="00000000000000000000000000010000";
        wait for 100 ns;
        
        ALU_bin_sel<='1';
        RF_A<="00000000000000000000000000011111";
        RF_B<="11111111111111111111111111111111";
        Immed<="00000000000000000000000000010000";
        wait for 100 ns;
        
        ALU_func<="0101";
     	ALU_bin_sel<='0';
     	
        RF_A<="00000000000000000000000001111111";
        RF_B<="01111111111111111111111111111111";
        Immed<="00000000000000000000000000010000";
        wait for 100 ns;
        
        ALU_bin_sel<='1';
        RF_A<="00000000000000000000000000011111";
        RF_B<="11111111111111111111111111111111";
        Immed<="10000000000000000000000000010000";
        wait for 100 ns;

        ALU_func<="0110";
     	ALU_bin_sel<='0';
     	
        RF_A<="00000000000000000000000001111111";
        RF_B<="01111111111111111111111111111111";
        Immed<="00000000000000000000000000010000";
        wait for 100 ns;
        
        ALU_bin_sel<='1';
        RF_A<="00000000000000000000000000011111";
        RF_B<="11111111111111111111111111111111";
        Immed<="00000000000000000000000000010000";
        wait for 100 ns;
      -- insert stimulus here 

      wait;
   end process;
end Behavioral;
