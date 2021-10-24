----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:28:36 05/02/2021 
-- Design Name: 
-- Module Name:    CONTROL_IF_PIPELINE - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity CONTROL_IF_PIPELINE is
    Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           Rst : in  STD_LOGIC;
           ALU_Op : out  STD_LOGIC_VECTOR (3 downto 0);
           ImmExt : out  STD_LOGIC_VECTOR (1 downto 0);
			  RF_B_Sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           RF_WrData_Sel : out  STD_LOGIC;
           ALU_Bin_Sel : out  STD_LOGIC;
           Mem_WrEn : out  STD_LOGIC;	
			   MemRead: out  STD_LOGIC;	
			  --id/ex
			  we_idex: out STD_LOGIC;  --prosthetw ta shmata we
			  we_idex_ctr: out STD_LOGIC;
			  --ex/mem
			  we_exmem: out STD_LOGIC;
			  we_exmem_ctr: out STD_LOGIC;
			  --mem/wb
			  we_memwb: out std_logic; 
			  we_memwb_ctr: out std_logic);
			  			  
end CONTROL_IF_PIPELINE;

architecture Behavioral of CONTROL_IF_PIPELINE is

begin
process(OpCode,Rst)
begin
	if Rst='1' then
			RF_B_Sel<='0';
			RF_WrEn<='0';
			RF_WrData_Sel<='0';
			ALU_Bin_Sel<='0';
			ALU_Op<="1111";
			Mem_WrEn<='0';
			ImmExt<="00";
			MemRead<='0';
					
			we_idex<='0';
			we_idex_ctr<='0';
			we_exmem<='0';
			we_exmem_ctr<='0';
			we_memwb<='0';
			we_memwb_ctr<='0';
				  
	else
		 we_memwb<='1';  --energa shmata we
		 we_memwb_ctr<='1';
		 we_exmem<='1';
		 we_exmem_ctr<='1';
		 we_idex<='1';
		 we_idex_ctr<='1';
		 
		 MemRead<='0';

		if OpCode="100000" then
			RF_B_Sel<='0';
			RF_WrEn<='1';
			RF_WrData_Sel<='0';
			ALU_Bin_Sel<='0';
			ALU_Op<="1000";
			Mem_WrEn<='0';
			ImmExt<="00"; --dont care;
			
		elsif OpCode="110011" then --ori
			RF_B_Sel<='1';
			RF_WrEn<='1';
			RF_WrData_Sel<='0';
			ALU_Bin_Sel<='1';
			ALU_Op<="0011";
			Mem_WrEn<='0';
			ImmExt<="00";
			
		elsif OpCode="110010" then --nandi
		
			RF_B_Sel<='1';
			RF_WrEn<='1';
			RF_WrData_Sel<='0';
			ALU_Bin_Sel<='1';
			ALU_Op<="0101";
			Mem_WrEn<='0';
			ImmExt<="00";
			
		elsif (OpCode="000000" or OpCode="111111") then --b beq
			
			RF_B_Sel<='1';
			RF_WrEn<='0';
			RF_WrData_Sel<='0';--dont care
			ALU_Bin_Sel<='0';
			ALU_Op<="0001";
			Mem_WrEn<='0';
			ImmExt<="10";
			
		elsif OpCode="000001" then --bne
		
			RF_B_Sel<='1';
			RF_WrEn<='0';
			RF_WrData_Sel<='0';--dont care
			ALU_Bin_Sel<='0';
			ALU_Op<="0001";
			Mem_WrEn<='0';
			ImmExt<="10";
			
		elsif OpCode="111001" then --lui
			
			RF_B_Sel<='1';
			RF_WrEn<='1';
			RF_WrData_Sel<='0';
			ALU_Bin_Sel<='1';
			ALU_Op<="0000";
			Mem_WrEn<='0';
			ImmExt<="11";
			
		elsif (OpCode="110000" or OpCode="111000") then --addi li
			RF_B_Sel<='1';
			RF_WrEn<='1';
			RF_WrData_Sel<='0';
			ALU_Bin_Sel<='1';
			ALU_Op<="0000";
			Mem_WrEn<='0';
			ImmExt<="01";
		elsif (OpCode="000011" or OpCode="001111") then --lb lw
			
			RF_B_Sel<='1';
			RF_WrEn<='1';
			RF_WrData_Sel<='1';
			ALU_Bin_Sel<='1';
			ALU_Op<="0000";
			Mem_WrEn<='0';
			ImmExt<="01";
			MemRead<='1';
			
		elsif (OpCode="000111" or OpCode="011111") then --sw sb
			
			RF_B_Sel<='1';
			RF_WrEn<='0';
			RF_WrData_Sel<='0';--dont care
			ALU_Bin_Sel<='1';
			ALU_Op<="0000";
			Mem_WrEn<='1';
			ImmExt<="01";
			
		else
			
			RF_B_Sel<='0';
			RF_WrEn<='0';
			RF_WrData_Sel<='0';
			ALU_Bin_Sel<='0';
			ALU_Op<="1111";
			Mem_WrEn<='0';
			ImmExt<="00";
			
		end if;
	end if;		
			
end process;	
end Behavioral;



