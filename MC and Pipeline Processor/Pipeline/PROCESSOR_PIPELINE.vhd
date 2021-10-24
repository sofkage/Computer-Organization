----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:34:38 05/02/2021 
-- Design Name: 
-- Module Name:    PROCESSOR_PIPELINE - Behavioral 
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


entity PROCESSOR_PIPELINE is
 Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           PC : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0));
end PROCESSOR_PIPELINE;

architecture Behavioral of PROCESSOR_PIPELINE is

component DATAPATH_PIPELINE is
    Port ( PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  --ALU_zero : out STD_LOGIC;
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
			  
			  --id/ex
			  we_idex: in STD_LOGIC;  --ta shmata me we energopoiountai mazi gi auto ta exw etsi 
			  we_idex_ctr: in STD_LOGIC;
			  --ex/mem
			  we_exmem: in STD_LOGIC;
			  we_exmem_ctr: in STD_LOGIC;
			  --mem/wb
			  we_memwb: in std_logic; 
			  we_memwb_ctr: in std_logic;
			  we_regpc41 : in STD_LOGIC;
			  
			  forwardA:in std_logic_vector(1 downto 0);
			  forwardB:in std_logic_vector(1 downto 0);
			  rs:out std_logic_vector(4 downto 0);
			  rd_idex:out std_logic_vector(4 downto 0);
			  rd_2_out:out std_logic_vector(4 downto 0);
			  rd_3_out:out std_logic_vector(4 downto 0);
			  rd_rt_out :out std_logic_vector(4 downto 0);
			  rd_rt_hdu:out std_logic_vector(4 downto 0);
			  RFwe2:out std_logic;
			  RFwe3:out std_logic);
end component;

component FORWARD_UNIT is
       Port ( rs : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_rt : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_3 : in  STD_LOGIC_VECTOR (4 downto 0);
           forwardA : out  STD_LOGIC_VECTOR (1 downto 0);
           forwardB : out  STD_LOGIC_VECTOR (1 downto 0);
			  RFwe2:in std_logic;
			  RFwe3:in std_logic);

end component;


component HAZARD_DETECTION_UNIT is
    Port ( rs : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_rt : in  STD_LOGIC_VECTOR (4 downto 0);
           rd_idex : in  STD_LOGIC_VECTOR (4 downto 0);
           memread : in  STD_LOGIC; 
           control_sel : out  STD_LOGIC;
           PC_LdEn_hdu : out  STD_LOGIC; 
           we_ifid_hdu : out  STD_LOGIC); 
end component;


component ControlMUX is
Port ( sel : in  STD_LOGIC;
           RFwe1 : in  STD_LOGIC;
           RFwds1 : in  STD_LOGIC;
			  MemWrEn1 : in  STD_LOGIC;
			  ByteOp1 : in  STD_LOGIC;
           ALUfunc : in  STD_LOGIC_VECTOR (3 downto 0);
			  ALU_Bin_sel : in  STD_LOGIC;
			  MemRead : in  STD_LOGIC;
			  
			  RFwe1_out : out  STD_LOGIC;
           RFwds1_out : out  STD_LOGIC;
			  MemWrEn1_out : out  STD_LOGIC;
			  ByteOp1_out : out  STD_LOGIC;
           ALUfunc_out : out  STD_LOGIC_VECTOR (3 downto 0);
			  ALU_Bin_sel_out : out  STD_LOGIC;
			  MemRead_out : out  STD_LOGIC);
end component;




component CONTROL_PIPELINE is
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
end component;


component REG is
Port ( CLK : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           RST : in STD_LOGIC;
           Datain : in STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0));
end component;


component REG_1bit
 Port ( CLK : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           RST : in STD_LOGIC;
           Datain : in STD_LOGIC;
           Dataout : out STD_LOGIC);
end component;

component INSTR_CONTROLLER is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           enable : out  STD_LOGIC);
end component;

--forward unit - datapath------------------------
signal temp_rs:STD_LOGIC_VECTOR (4 downto 0); 
signal temp_rd_rt:STD_LOGIC_VECTOR (4 downto 0);
signal temp_rd_2:STD_LOGIC_VECTOR (4 downto 0);
signal temp_rd_3:STD_LOGIC_VECTOR (4 downto 0);
signal temp_forwardA : STD_LOGIC_VECTOR (1 downto 0);
signal temp_forwardB : STD_LOGIC_VECTOR (1 downto 0);
signal temp_rfwe2:std_logic;
signal temp_rfwe3:std_logic;
----------------------------------------------------------
--hazard detection unit - datapath------------------------
signal temp_control_sel : STD_LOGIC; 
signal temp_memread_out:std_logic;
signal temp_PC_LdEn_hdu:std_logic;
signal temp_we_ifid_hdu :std_logic;
signal temp_rd_rt_hdu : std_logic_vector(4 downto 0);
signal temp_rd: std_logic_vector(4 downto 0);
----------------------------------------------------------
---------------control mux - datapath signals---------------------------
signal temp_memread:std_logic;
signal  temp_RF_WrData_sel_out :  STD_LOGIC;
signal  temp_RF_WrEn_out :  STD_LOGIC;
signal  temp_ALU_func_out :  STD_LOGIC_VECTOR (3 downto 0);
signal  temp_ALU_Bin_Sel_out :  STD_LOGIC;	
signal  temp_ByteOp_out : STD_LOGIC;
signal  temp_MEM_WrEn_out : STD_LOGIC;	
signal  temp_ImmExt_out : STD_LOGIC_VECTOR (1 downto 0);
---------------------------------------------------------------------
--control pipeline signals-----------------------------------------
signal  temp_PC_sel : STD_LOGIC;
signal  temp_RF_B_sel :  STD_LOGIC;
signal  temp_RF_WrData_sel :  STD_LOGIC;
signal  temp_RF_WrEn :  STD_LOGIC;
signal  temp_ALU_func :  STD_LOGIC_VECTOR (3 downto 0);
signal  temp_ByteOp : STD_LOGIC;
signal  temp_MEM_WrEn : STD_LOGIC;
signal  temp_MemRead_con:  STD_LOGIC;	
signal  temp_ImmExt : STD_LOGIC_VECTOR (1 downto 0);
signal  temp_ALU_Bin_Sel :  STD_LOGIC;	
signal  temp_we_idex:  STD_LOGIC;
signal  temp_we_idex_ctr:  STD_LOGIC;
signal  temp_we_exmem:  STD_LOGIC;
signal  temp_we_exmem_ctr:  STD_LOGIC;
signal  temp_we_memwb:  std_logic; 
signal  temp_we_memwb_ctr: std_logic;
----------------------------------------------------------------------------
signal tempInstr : std_logic_vector(31 downto 0);

signal controlenable:std_logic;
signal con_sel:std_logic;

begin

IR:
	REG port map(CLK=>Clk,
						WrEn=>temp_we_ifid_hdu, 
						RST=>Reset,
                  Datain=> Instr, 
						Dataout=>tempInstr);

--t_rd<=rd_idex for both forward and hd units

FU:
	FORWARD_UNIT port map(rs=>temp_rs,
									rd_rt=>temp_rd_rt,
									rd_2=>temp_rd_2,
									rd_3=>temp_rd_3, 
									forwardA=>temp_forwardA,
									forwardB=>temp_forwardB, 
									RFwe2=>temp_rfwe2,
									RFwe3=>temp_rfwe3);
HDU:
--t_rd_rt_hdu from datapath
	HAZARD_DETECTION_UNIT port map(rs=>tempInstr(25 downto 21),
												rd_rt			=>temp_rd_rt_hdu,
												rd_idex		=>temp_rd,
												control_sel	=>temp_control_sel,
												memread		=>temp_memread_out,
												we_ifid_hdu	=>temp_we_ifid_hdu,
												PC_LdEn_hdu	=>temp_PC_LdEn_hdu);

MemReadRegister:
	REG_1bit port map(CLK=>CLK,
							WrEn		=>temp_we_idex_ctr,
							RST		=>Reset,
							Datain	=>temp_memread, 
							Dataout	=>temp_memread_out);							
--t_memread ->from controlmux

IC:
	INSTR_CONTROLLER port map(Instr	=>tempInstr,
									  enable =>controlenable);

Control:
	CONTROL_PIPELINE port map(OpCode		=>tempInstr(31 downto 26),
										func		=>tempInstr(5 downto 0), 
										Rst		=>Reset,
										ALU_func	=>temp_ALU_func,
										PC_Sel	=>temp_PC_sel,
										ImmExt	=>temp_ImmExt,
										ByteOp	=>temp_ByteOp,
										RF_B_Sel	=>temp_RF_B_Sel,
										RF_WrEn	=>temp_RF_WrEn,
										RF_WrData_Sel	=>temp_RF_WrData_Sel,
										ALU_Bin_Sel		=>temp_ALU_Bin_Sel,
										Mem_WrEn			=>temp_Mem_WrEn,
										we_idex			=>temp_we_idex,
										we_idex_ctr		=>temp_we_idex_ctr, 
										we_exmem			=>temp_we_exmem, 
										we_exmem_ctr	=>temp_we_exmem_ctr,
										we_memwb			=>temp_we_memwb,
										we_memwb_ctr	=>temp_we_memwb_ctr,
										MemRead			=>temp_MemRead_con);

con_sel<=(controlenable or temp_control_sel);

contol_MUX:--pc sel and immext at datapath
	ControlMUX port map(sel				=>con_sel,
								MemRead_out	=>temp_memread,
								ALUfunc		=>temp_ALU_func,
								ByteOp1		=>temp_ByteOp,
								RFwe1			=>temp_RF_WrEn,
								RFwds1		=>temp_RF_WrData_Sel,
								ALU_Bin_sel	=>temp_ALU_Bin_Sel,
								MemWrEn1		=>temp_Mem_WrEn,
								MemRead		=>temp_MemRead_con,
								ALUfunc_out	=>temp_ALU_func_out,
								ByteOp1_out	=>temp_ByteOp_out,
								RFwe1_out	=>temp_RF_WrEn_out,
								RFwds1_out	=>temp_RF_WrData_Sel_out,
								ALU_Bin_sel_out=>temp_ALU_Bin_sel_out,
								MemWrEn1_out	=>temp_Mem_WrEn_out);
	
Data:
	DATAPATH_PIPELINE port map(PC_sel			=>temp_PC_sel, 
										PC_LdEn			=>temp_PC_LdEn_hdu,
										RF_B_sel			=>temp_RF_B_sel, 
										RF_WrData_sel	=>temp_RF_WrData_Sel_out,
										RF_WrEn			=>temp_RF_WrEn_out,
										ALU_func			=>temp_ALU_func_out,
										MEM_WrEn			=>temp_MEM_WrEn_out,
										ImmExt			=>temp_ImmExt,
										ALU_Bin_sel		=>temp_ALU_Bin_Sel_out,
										ByteOp			=>temp_ByteOp,
										PC					=>PC, 
										MM_Addr			=>MM_Addr, 
										MM_WrData		=>MM_WrData, 
										MM_WrEn			=>MM_WrEn, 
										MM_RdData		=>MM_RdData, 
										RST				=>Reset, 
										CLK				=>Clk, 
										Instr				=>tempInstr,
										we_idex			=>temp_we_idex,
										we_idex_ctr		=>temp_we_idex_ctr, 
										we_exmem			=>temp_we_exmem, 
										we_exmem_ctr	=>temp_we_exmem_ctr,
										we_memwb			=>temp_we_memwb,
										we_memwb_ctr	=>temp_we_memwb_ctr,
										we_regpc41		=>temp_we_ifid_hdu,
										forwardA			=>temp_forwardA,
										forwardB			=>temp_forwardB,
										rs					=>temp_rs,
										rd_idex			=>temp_rd,
										rd_2_out			=>temp_rd_2,
										rd_3_out			=>temp_rd_3,
										rd_rt_out		=>temp_rd_rt,
										rd_rt_hdu		=>temp_rd_rt_hdu,
										RFwe2				=>temp_rfwe2 ,
										RFwe3				=>temp_rfwe3);
	
end Behavioral;