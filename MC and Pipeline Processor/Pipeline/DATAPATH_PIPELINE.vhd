----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:17:01 05/01/2021 
-- Design Name: 
-- Module Name:    DATAPATH_PIPELINE - Behavioral 
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

entity DATAPATH_PIPELINE is
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
			  we_idex: in STD_LOGIC;
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
			  
end DATAPATH_PIPELINE;

architecture Behavioral of DATAPATH_PIPELINE is

COMPONENT IFSTAGE_PIPELINE is
Port ( PC_4_Immediate : in  STD_LOGIC_VECTOR (31 downto 0);
        PC_4 : out  STD_LOGIC_VECTOR (31 downto 0);
           PC_LdEn : in  STD_LOGIC;
			  PC_Sel : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;


COMPONENT EXSTAGE_PIPELINE is
    Port ( --RF_A : in STD_LOGIC_VECTOR (31 downto 0);
           --RF_B : in STD_LOGIC_VECTOR (31 downto 0);
			  In_A : in  STD_LOGIC_VECTOR (31 downto 0);
           In_B : in  STD_LOGIC_VECTOR (31 downto 0);
			  In_C : in  STD_LOGIC_VECTOR (31 downto 0);
			  In_D : in  STD_LOGIC_VECTOR (31 downto 0);
			  srcA : in  STD_LOGIC_VECTOR(1 downto 0);
			  srcB: in  STD_LOGIC_VECTOR(1 downto 0);
			  
           Immed : in STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in STD_LOGIC;
           ALU_func : in STD_LOGIC_VECTOR (3 downto 0); --ti praksh tha kanei h ALU
           ALU_out : out STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out STD_LOGIC;
			  In_B_out: out  STD_LOGIC_VECTOR (31 downto 0));

end COMPONENT;

COMPONENT DECSTAGE_PIPELINE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrEn : in  STD_LOGIC;
			  write_reg:in  STD_LOGIC_VECTOR (4 downto 0);

           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt : in  STD_LOGIC_VECTOR (1 downto 0);
           Clk : in  STD_LOGIC;
			  Rst : in STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  rd_rt: out  STD_LOGIC_VECTOR (4 downto 0);
			  AM_out: out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT MEMSTAGE is
    Port ( --clk : in STD_LOGIC;  
           Mem_WrEn : in STD_LOGIC;
           ALU_MEM_Addr : in STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr : out STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out STD_LOGIC;
           MM_WrData : out STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in STD_LOGIC_VECTOR (31 downto 0);
           ByteOp : in STD_LOGIC
           );
end COMPONENT;

COMPONENT REG is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           Datain : in STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT REG_1bit is
    Port ( CLK : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           RST : in STD_LOGIC;
           Datain : in STD_LOGIC;
           Dataout : out STD_LOGIC);
end COMPONENT;

COMPONENT REG_4bits is
Port ( CLK : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           RST : in STD_LOGIC;
           Datain : in STD_LOGIC_VECTOR(3 downto 0);
           Dataout : out STD_LOGIC_VECTOR(3 downto 0));
end COMPONENT;


COMPONENT REG_5bits is
Port ( CLK : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           RST : in STD_LOGIC;
           Datain : in STD_LOGIC_VECTOR(4 downto 0);
           Dataout : out STD_LOGIC_VECTOR(4 downto 0));
end COMPONENT;

COMPONENT adder_immed is
    Port ( Din : in STD_LOGIC_VECTOR (31 downto 0);
           PC_Immed : in STD_LOGIC_VECTOR (31 downto 0);
           Dout : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;


COMPONENT MUX2x1 is
    Port ( Din0 : in STD_LOGIC_VECTOR (31 downto 0);
           Din1 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT REG_PIPELINE is
    Port (
           Din1 : in STD_LOGIC_VECTOR (31 downto 0);
			  Din2 : in STD_LOGIC_VECTOR (31 downto 0);
			  Din3 : in STD_LOGIC_VECTOR (31 downto 0);
			  Din4 : in STD_LOGIC_VECTOR (31 downto 0);
			  Din5 : in STD_LOGIC_VECTOR (4 downto 0);
           Dout1 : out STD_LOGIC_VECTOR (31 downto 0);
			  Dout2 : out STD_LOGIC_VECTOR (31 downto 0);
			  Dout3 : out STD_LOGIC_VECTOR (31 downto 0);
			  Dout4 : out STD_LOGIC_VECTOR (31 downto 0);
			  Dout5 : out STD_LOGIC_VECTOR (4 downto 0);
			  CLK : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           RST : in STD_LOGIC);
end COMPONENT;

signal temp_ALU_out : std_logic_vector(31 downto 0);
signal temp_MEM_out : std_logic_vector(31 downto 0);
signal temp_ALU_zero : std_logic;

signal temp_PC_Immed : std_logic_vector(31 downto 0);
signal temp_RF_A : std_logic_vector(31 downto 0);
signal temp_RF_B : std_logic_vector(31 downto 0);

signal temp_regDECA_out : std_logic_vector(31 downto 0);
signal temp_regDECB_out : std_logic_vector(31 downto 0);
signal temp_regDECB_2_out : std_logic_vector(31 downto 0);
signal temp_regALU_out : std_logic_vector(31 downto 0);
signal temp_regALU_2_out : std_logic_vector(31 downto 0);
signal temp_regImmed_out : std_logic_vector(31 downto 0);
signal temp_regMEMOUT_out : std_logic_vector(31 downto 0);

signal temp_pc_4: std_logic_vector(31 downto 0);
signal temp_pc_41_out: std_logic_vector(31 downto 0);
signal temp_pc_42_out: std_logic_vector(31 downto 0);
signal temp_PC_Immed_add : std_logic_vector(31 downto 0);

signal temp_rd_1_out: std_logic_vector(4 downto 0);
signal temp_rd_2_out: std_logic_vector(4 downto 0);
signal temp_rd_3_out: std_logic_vector(4 downto 0);
signal temp_In_B_out: std_logic_vector(31 downto 0);

--control, gia ta stages
signal t1_RF_WrData_sel : std_logic;
signal t2_RF_WrData_sel : std_logic;
signal t3_RF_WrData_sel : std_logic;
signal t1_RF_WrEn : std_logic;
signal t2_RF_WrEn : std_logic;
signal t3_RF_WrEn : std_logic;

signal temp_ALUfunc : std_logic_vector(3 downto 0);
signal temp_ALU_Bin_sel :std_logic;		
				 
signal t1_Mem_WrEn: std_logic;
signal t2_Mem_WrEn: std_logic;
signal t1_ByteOp: std_logic;
signal t2_ByteOp: std_logic;

--forward
signal temp_regForwA_out:std_logic_vector(31 downto 0); 
signal temp_regForwB_out:std_logic_vector(31 downto 0);
signal temp_rd_rt:std_logic_vector(4 downto 0);
--signal temp_rd_rt_out:std_logic_vector(4 downto 0);
signal temp_rd_rt2:std_logic_vector(4 downto 0);

signal temp_AM_out:std_logic_vector(31 downto 0);
signal temp_add_imm_out :std_logic_vector(31 downto 0);

begin



---IFSTAGE---
ifs:
  IFSTAGE_PIPELINE port map(PC_4_Immediate =>temp_PC_Immed_add,
										PC_Sel		=>PC_sel, 
										PC_LdEn		=>PC_LdEn,
										Rst			=>RST,
										PC_4			=>temp_pc_4, 
										PC				=>PC,
										Clk			=>CLK);

regPC4_1: 
	REG port map(CLK=>CLK,
						WrEn=>we_regpc41, 
						RST=>RST,
                  Datain=>temp_pc_4,
						Dataout=>temp_pc_41_out);
---------------------------------------------------------------------------------------------------

---DECSTAGE----
decs:
	DECSTAGE_PIPELINE port map(Instr				=>Instr,
										ImmExt			=>ImmExt, 
										RF_WrData_sel	=> t3_RF_WrData_sel, 
										RF_B_sel			=>RF_B_sel,
										RF_WrEn			=> t3_RF_WrEn,
										Rst				=>RST, 
										ALU_out			=>temp_regALU_2_out,
										MEM_out			=>temp_regMEMOUT_out,
										Immed				=>temp_PC_Immed,
										RF_A				=> temp_RF_A,
										RF_B				=>temp_RF_B, 
										Clk				=>CLK,
										write_reg		=>temp_rd_3_out,
										AM_out			=>temp_AM_out,
										rd_rt				=>temp_rd_rt);

rd_rt_hdu <= temp_rd_rt;	------- hdu 									

id_ex:
 REG_PIPELINE port map(CLK=>CLK,
									WrEn=>we_idex, 
									RST=>RST,
									Din1=>temp_pc_41_out ,
									Dout1=>temp_pc_42_out,
									Din2=> temp_RF_A,
									Dout2=>temp_regDECA_out,
									Din3=>temp_RF_B ,
									Dout3=>temp_regDECB_out,
									Din4=>temp_PC_Immed ,
									Dout4=>temp_regImmed_out,
									Din5=>Instr(20 downto 16) ,
									Dout5=>temp_rd_1_out);
rd_idex<=temp_rd_1_out;					 

---EXSTAGE-------------------------------------------------

exs:
	EXSTAGE_PIPELINE port map(In_A		=>temp_regDECA_out, 
										In_B		=>temp_regDECB_out, 
										Immed		=>temp_regImmed_out,
										ALU_func	=>ALU_func, 
										ALU_out	=>temp_ALU_out,
										ALU_zero	=>open, 
										srcA		=>forwardA,
										srcB		=>forwardB, 
										In_C		=>temp_regALU_out,
										In_D		=>temp_AM_out, 
										ALU_Bin_sel=>temp_ALU_Bin_sel,
										In_B_out	  =>temp_In_B_out); 


adder_imm:
   adder_immed port map (Din		=>temp_pc_42_out,
								 PC_Immed=>temp_regImmed_out,
								 Dout		=>temp_add_imm_out); 

reg_ALU:
	REG port map(CLK=>CLK,
						WrEn	=>we_exmem, 
						RST	=>RST,
                  Datain	=> temp_ALU_out,
						Dataout	=>temp_regALU_out );
reg_PC4_3: 
	REG port map(CLK		=>CLK,
						WrEn	=>we_exmem,
						RST	=>RST,
                  Datain	=>temp_add_imm_out,
						Dataout	=>temp_PC_Immed_add);


reg_rd_2:
	REG_5bits port map(CLK=>CLK,
								WrEn		=>we_exmem, 
								RST		=>RST,
								Datain	=> temp_rd_1_out, 
								Dataout	=>temp_rd_2_out );		
reg_DEC_B_2:
	REG port map(CLK=>CLK,WrEn=>we_exmem, RST=>RST,
                   Datain=>temp_In_B_out, Dataout=>temp_regDECB_2_out);
	--temp_regDECB_out					 
rd_2_out<=temp_rd_2_out;
------------------------------------------------------------------------------------------

---MEMSTAGE---
mems:
	MEMSTAGE port map(ByteOp		=>t2_ByteOp, 
							Mem_WrEn		=>t2_Mem_WrEn, 
							ALU_MEM_Addr=>temp_regALU_out, 
							MEM_DataIn	=>temp_regDECB_2_out,
							MEM_DataOut	=>temp_MEM_out,
							MM_WrEn		=>MM_WrEn,
							MM_Addr		=>MM_Addr, 
							MM_WrData	=>MM_WrData,
							MM_RdData	=>MM_RdData);--,Clk=>CLK,Rst=>RST); 
						 
reg_MEM_out:
	REG port map(CLK=>CLK,
						WrEn	=>we_memwb,
						RST	=>RST,
                  Datain	=>temp_MEM_out,
						Dataout	=>temp_regMEMOUT_out);
reg_rd_3:
	REG_5bits port map(CLK=>CLK,
							WrEn=>we_memwb, 
							RST =>RST,
							Datain => temp_rd_2_out, 
							Dataout=>temp_rd_3_out );		
reg_ALU_2:
	REG port map(CLK=>CLK,
						WrEn		=>we_memwb,
						RST		=>RST,
                  Datain	=> temp_regALU_out, 
						Dataout	=>temp_regALU_2_out );
						
rd_3_out <= temp_rd_3_out;
--------------------------------------------------------------------------------------------

--control registers
--id/ex-----------------1----------------------------
reg_RFwds1:
	REG_1bit port map(CLK=>CLK,
							WrEn=>we_idex_ctr, 
							RST=>RST,
							Datain=> RF_WrData_sel, 
							Dataout=>t1_RF_WrData_sel );
reg_ALUbin:
	REG_1bit port map(CLK=>CLK,
							WrEn=>we_idex_ctr, 
							RST=>RST,
							Datain=> ALU_Bin_sel,
							Dataout=>temp_ALU_Bin_sel );

reg_ALUfunc:
	REG_4bits port map(CLK=>CLK,
								WrEn=>we_idex_ctr,
								RST=>RST,
								Datain=> ALU_func, 
								Dataout=>temp_ALUfunc);

reg_Mem_we_1:
	REG_1bit port map(CLK=>CLK,
							WrEn=>we_idex_ctr,
							RST=>RST,
							Datain=> Mem_WrEn, 
							Dataout=>t1_Mem_WrEn );							
reg_ByteOp_1:
	REG_1bit port map(CLK=>CLK,
							WrEn=>we_idex_ctr, 
							RST=>RST,
							Datain=> ByteOp, 
							Dataout=>t1_ByteOp );							
reg_RF_we_1:
	REG_1bit port map(CLK=>CLK,
							WrEn=>we_idex_ctr, 
							RST=>RST,
							Datain=> RF_WrEn,
							Dataout=>t1_RF_WrEn );							

					
--ex/mem --------------------- 2--------------------------------
reg_RF_wds_2:
	REG_1bit port map(CLK=>CLK,
								WrEn=>we_exmem_ctr, 
								RST=>RST,
								Datain=> t1_RF_WrData_sel,
								Dataout=>t2_RF_WrData_sel );
reg_RF_we_2:
	REG_1bit port map(CLK=>CLK,
								WrEn=>we_exmem_ctr, 
								RST=>RST,
								Datain=>t1_RF_WrEn , 
								Dataout=>t2_RF_WrEn );	
RFwe2<=t2_RF_WrEn;							

reg_Mem_we_2:
	REG_1bit port map(CLK=>CLK,
							WrEn=>we_exmem_ctr, 
							RST=>RST,
							Datain=> t1_Mem_WrEn,
							Dataout=>t2_Mem_WrEn );		
reg_ByteOp2:
	REG_1bit port map(CLK=>CLK,
							WrEn=>we_exmem_ctr, 
							RST=>RST,
							Datain=> t1_ByteOp,
							Dataout=>t2_ByteOp );		

--mem/wb-----------------------------3---------------------------------------------------
reg_RFwds3:
	REG_1bit port map(CLK=>CLK,
								WrEn=>we_memwb_ctr, 
								RST=>RST,
								Datain=> t2_RF_WrData_sel,
								Dataout=>t3_RF_WrData_sel );
reg_RF_we_3:
	REG_1bit port map(CLK=>CLK,
								WrEn=>we_memwb_ctr, 
								RST=>RST,
								Datain=>t2_RF_WrEn ,
								Dataout=>t3_RF_WrEn);	
RFwe3 <= t3_RF_WrEn;							



--forward unit---------------------------------------------------

regs:
	REG_5bits port map(CLK=>CLK,
								WrEn=>we_idex, 
								RST=>RST,
								Datain=>Instr(25 downto 21), 
								Dataout=>rs );		

regd_t1:
	REG_5bits port map(CLK=>CLK,
								WrEn=>we_idex, 
								RST=>RST,
								Datain=> temp_rd_rt,
								Dataout=>rd_rt_out  );		--Datain=> rd_rt from decstage
						
end Behavioral;
