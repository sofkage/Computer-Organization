----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:29:43 05/02/2021 
-- Design Name: 
-- Module Name:    CONTROL_PIPELINE - Behavioral 
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

entity CONTROL_PIPELINE is
	 Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           Rst : in  STD_LOGIC;
			  func : in STD_LOGIC_VECTOR(5 downto 0);
			  ALU_func : out STD_LOGIC_VECTOR (3 downto 0);
			  PC_Sel : out STD_LOGIC;
           ImmExt : out  STD_LOGIC_VECTOR (1 downto 0);
			  ByteOp :out  STD_LOGIC;
           RF_B_Sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           RF_WrData_Sel : out  STD_LOGIC;
			  ALU_Bin_Sel : out  STD_LOGIC;
			  Mem_WrEn : out  STD_LOGIC;
			  MemRead: out  STD_LOGIC;	
			  we_idex: out STD_LOGIC;
			  we_idex_ctr: out STD_LOGIC;
			  we_exmem: out STD_LOGIC;
			  we_exmem_ctr: out STD_LOGIC;
			  we_memwb: out std_logic; 
			  we_memwb_ctr: out std_logic
			  );
end CONTROL_PIPELINE;

architecture Behavioral of CONTROL_PIPELINE is

component CONTROL_ALU is
    Port ( func : in  STD_LOGIC_VECTOR (5 downto 0);
           ALU_op : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0)
); 

end component;

component CONTROL_IF_PIPELINE is
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
			  -- stage signals 
			  --id/ex
			  we_idex: out STD_LOGIC;
			  we_idex_ctr: out STD_LOGIC;
			  --ex/mem
			  we_exmem: out STD_LOGIC;
			  we_exmem_ctr: out STD_LOGIC;
			  --mem/wb
			  we_memwb: out std_logic; 
			  we_memwb_ctr: out std_logic);
end component;


signal temp_ALU_Op : std_logic_vector(3 downto 0);


begin

ifcon:
	CONTROL_IF_PIPELINE port map(OpCode		=>OpCode,
											Rst		=>Rst,
											ALU_Op	=>temp_ALU_Op,
											ImmExt	=>ImmExt,
											RF_B_Sel	=>RF_B_Sel, 
											RF_WrEn	=>RF_WrEn,
											RF_WrData_Sel=>RF_WrData_Sel,
											ALU_Bin_Sel	 =>ALU_Bin_Sel,
											Mem_WrEn		 =>Mem_WrEn,
											we_idex		 =>we_idex,
											we_idex_ctr	 =>we_idex_ctr,
											we_exmem		 =>we_exmem,
											we_exmem_ctr =>we_exmem_ctr,
											we_memwb     =>we_memwb,
											we_memwb_ctr =>we_memwb_ctr, 
											MemRead      =>MemRead);
	
alu: CONTROL_ALU port map (func		=>func,
									ALU_op	=>temp_ALU_Op,
									ALU_func =>ALU_func);


PC_Sel <= '0';
ByteOp <= not(OpCode(3));

end Behavioral;
