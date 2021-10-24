----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:13:56 05/01/2021 
-- Design Name: 
-- Module Name:    PROCESSOR_MC - Behavioral 
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

entity PROCESSOR_MC is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           PC : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0));
end PROCESSOR_MC;

architecture Behavioral of PROCESSOR_MC is

COMPONENT CONTROL_MC is
Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           func : in  STD_LOGIC_VECTOR (5 downto 0);
			  zero : in STD_LOGIC;
			  ALU_func : out STD_LOGIC_VECTOR (3 downto 0);
			  ByteOp : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
			  PC_source :out STD_LOGIC;
           ImmExt : out  STD_LOGIC_VECTOR (1 downto 0);
           RF_B_Sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           RF_WrData_Sel : out  STD_LOGIC;
           Mem_WrEn : out  STD_LOGIC;
			  srcA : out  STD_LOGIC;
			  srcB: out  STD_LOGIC_VECTOR(1 downto 0);
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
			  
			  
			  we_reg_dec_a : out STD_LOGIC;
			  we_reg_dec_b : out STD_LOGIC;
			  we_reg_ALU : out STD_LOGIC;
			  we_reg_PC : out STD_LOGIC;
			  we_reg_MemOut : out STD_LOGIC;
			  PC_sel : out std_logic);
end COMPONENT;

COMPONENT DATAPATH_MC is
    Port ( PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
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
			  Instr : in STD_LOGIC_VECTOR (31 downto 0);
			  
			  
			  srcA : in  STD_LOGIC;
			  srcB: in  STD_LOGIC_VECTOR(1 downto 0);
			  
			  PC_source : in std_logic;
			  we_reg_dec_a : in STD_LOGIC;
			  we_reg_dec_b : in STD_LOGIC;
			  we_reg_alu : in STD_LOGIC;
			  we_reg_MemOut : in STD_LOGIC);
end COMPONENT;


component REG is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           Datain : in STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal  temp_PC_sel : STD_LOGIC;
signal  temp_PC_LdEn :  STD_LOGIC;
signal  temp_PC_source :  STD_LOGIC;
signal  temp_RF_B_sel :  STD_LOGIC;
signal  temp_RF_WrData_sel :  STD_LOGIC;
signal  temp_RF_WrEn :  STD_LOGIC;
signal  temp_srcA :  STD_LOGIC;
signal  temp_srcB :  STD_LOGIC_VECTOR (1 downto 0);
signal  temp_ALU_func :  STD_LOGIC_VECTOR (3 downto 0);
signal  temp_ByteOp : STD_LOGIC;
signal  temp_MEM_WrEn : STD_LOGIC;
signal  temp_ImmExt : STD_LOGIC_VECTOR (1 downto 0);

signal temp_ALU_zero : STD_LOGIC;

signal temp_we_reg_dec_a : STD_LOGIC;
signal temp_we_reg_dec_b : STD_LOGIC;
signal temp_we_regImmed: STD_LOGIC;
signal temp_we_reg_alu : STD_LOGIC;
signal temp_we_reg_PC : STD_LOGIC;
signal temp_we_reg_MemOut : STD_LOGIC;

signal temp_Instr : std_logic_vector(31 downto 0);

begin

-- Instruction Register apothikevei thn eksodo ths mnhmhs gia mia
--anagnwsh entolis. idio kyklo me mdr. krataei mexri to telos tis ekteleshs
IR:
	REG port map(  CLK		=> Clk,
						WrEn		=> temp_we_reg_PC,
						RST		=> Reset,
                  Datain 	=> Instr,
						Dataout	=> temp_Instr);
 
ctr:
	CONTROL_MC port map(Clk				=>Clk,
								Rst			=>Reset, 
								zero			=>temp_ALU_zero,
								OpCode		=>temp_Instr(31 downto 26),
								func			=>temp_Instr(5 downto 0), 
							   PC_sel		=>temp_PC_sel,
							   PC_LdEn		=>temp_PC_LdEn,
								RF_B_sel		=>temp_RF_B_sel,
								RF_WrData_sel=>temp_RF_WrData_sel,
								RF_WrEn		=>temp_RF_WrEn,
								ALU_func		=>temp_ALU_func,
								ByteOp		=>temp_ByteOp, 
								MEM_WrEn		=>temp_MEM_WrEn,
								ImmExt		=>temp_ImmExt,
								we_reg_dec_a	=>temp_we_reg_dec_a,
								we_reg_dec_b	=>temp_we_reg_dec_b,
								we_reg_alu		=>temp_we_reg_alu,
								we_reg_PC		=>temp_we_reg_PC, 
								we_reg_MemOut	=>temp_we_reg_MemOut,
								PC_source		=>temp_PC_source,
								srcA				=>temp_srcA,
								srcB				=>temp_srcB);
			  
data: 
	DATAPATH_MC port map(PC_sel	=>temp_PC_sel,
								PC_LdEn	=>temp_PC_LdEn, 
								RF_B_sel	=>temp_RF_B_sel,
								RF_WrData_sel=>temp_RF_WrData_sel, 
								RF_WrEn		=>temp_RF_WrEn,
								ALU_func		=>temp_ALU_func,
								MEM_WrEn		=>temp_MEM_WrEn,
								ImmExt		=>temp_ImmExt,
								ByteOp		=>temp_ByteOp, 
								ALU_zero		=>temp_ALU_zero, 
								PC				=>PC, 
								MM_Addr		=>MM_Addr, 
								MM_WrData	=>MM_WrData,
								MM_WrEn		=>MM_WrEn, 
								MM_RdData	=>MM_RdData, 
								RST			=>Reset,
								CLK			=>Clk,
								Instr			=>temp_Instr,
								we_reg_dec_a	=>temp_we_reg_dec_a,
								we_reg_dec_b	=>temp_we_reg_dec_b,
								we_reg_alu		=>temp_we_reg_alu, 
								we_reg_MemOut	=>temp_we_reg_MemOut,
								PC_source		=>temp_PC_source,
								srcA				=>temp_srcA,
								srcB				=>temp_srcB);

end Behavioral;

