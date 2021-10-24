----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:58:46 04/11/2021 
-- Design Name: 
-- Module Name:    DATAPATH - Behavioral 
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

entity DATAPATH is
    Port ( PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  ALU_zero : out STD_LOGIC;
           ByteOp : in  STD_LOGIC;
           MEM_WrEn : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           PC : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0);
			  RST : in STD_LOGIC;
			  CLK : in STD_LOGIC;
			  Instr : in STD_LOGIC_VECTOR (31 downto 0));
end DATAPATH;

architecture Behavioral of DATAPATH is

component IFSTAGE is
 Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_Sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0);
           PC_LdEn : in  STD_LOGIC);
end component;

component DECSTAGE is
 Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  Rst : in STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component EXSTAGE is
 Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC);
end component;

component MEMSTAGE is
Port ( Mem_WrEn : in  STD_LOGIC;
			  ByteOp : in STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
			  --Clk : in std_logic;
			  --Rst : in std_logic);
end component;

signal temp_PC_Immed : std_logic_vector(31 downto 0);
signal temp_RF_A : std_logic_vector(31 downto 0);
signal temp_RF_B : std_logic_vector(31 downto 0);

signal temp_ALU_out : std_logic_vector(31 downto 0);
signal temp_MEM_out : std_logic_vector(31 downto 0);

begin

ifs:
  IFSTAGE port map(PC_Immed =>temp_PC_Immed,
							PC_Sel=>PC_sel, 
							PC_LdEn=>PC_LdEn,
							Reset=>RST, 
							PC=>PC,
							Clk=>CLK);
 
exs:
	EXSTAGE port map(RF_A=>temp_RF_A, 
							RF_B=>temp_RF_B, 
							Immed=>temp_PC_Immed, 
							ALU_bin_sel=>ALU_Bin_sel, 
							ALU_func=>ALU_func, 
							ALU_out=>temp_ALU_out,
							ALU_zero=>ALU_zero);
	
decs:
	DECSTAGE port map(Instr=>Instr,
							ImmExt=>ImmExt,
							RF_WrData_sel=> RF_WrData_sel,
							RF_B_sel=>RF_B_sel, 
							RF_WrEn=> RF_WrEn,
							Rst=>RST,
							ALU_out=>temp_ALU_out ,
							MEM_out=>temp_MEM_out ,
							Immed=>temp_PC_Immed,
							RF_A=> temp_RF_A,
							RF_B=>temp_RF_B, 
							Clk=>CLK);

mems:
	MEMSTAGE port map(ByteOp=>ByteOp, 
							Mem_WrEn=>Mem_WrEn,
							ALU_MEM_Addr=>temp_ALU_out,
							MEM_DataIn=>temp_RF_B,
							MEM_DataOut=>temp_MEM_out,
							MM_WrEn=>MM_WrEn, 
							MM_Addr=>MM_Addr,
							MM_WrData=>MM_WrData, 
							MM_RdData=>MM_RdData);--,Clk=>CLK,Rst=>RST); 


end Behavioral;