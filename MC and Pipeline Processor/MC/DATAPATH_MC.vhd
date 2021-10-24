----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:42:00 04/30/2021 
-- Design Name: 
-- Module Name:    DATAPATH_MC - Behavioral 
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
entity DATAPATH_MC is
    Port ( PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
          -- ALU_Bin_sel : in  STD_LOGIC;
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
			  
			  PC_source : in std_logic;
			  srcA : in  STD_LOGIC;
			  srcB: in  STD_LOGIC_VECTOR(1 downto 0);
			  we_reg_dec_a : in STD_LOGIC;
			  we_reg_dec_b : in STD_LOGIC;
			  we_reg_alu : in STD_LOGIC;
			  we_reg_MemOut : in STD_LOGIC);
end DATAPATH_MC;

architecture Behavioral of DATAPATH_MC is

component IFSTAGE is
    Port ( --PC_Immed : in STD_LOGIC_VECTOR (31 downto 0);
	 		  PC_In : in  STD_LOGIC_VECTOR (31 downto 0);
			  PC_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_reg_out : in  STD_LOGIC_VECTOR (31 downto 0); 

           PC_sel : in STD_LOGIC;
           PC_LdEn : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           PC : out STD_LOGIC_VECTOR (31 downto 0));
           --instr : out STD_LOGIC_VECTOR(31 downto 0));
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
    Port ( --RF_A : in STD_LOGIC_VECTOR (31 downto 0);
           --RF_B : in STD_LOGIC_VECTOR (31 downto 0);
			  In_A : in  STD_LOGIC_VECTOR (31 downto 0);
           In_B : in  STD_LOGIC_VECTOR (31 downto 0);
			  PC_out : in  STD_LOGIC_VECTOR (31 downto 0);
			  srcA : in  STD_LOGIC;
			  srcB: in  STD_LOGIC_VECTOR(1 downto 0);
			  
           Immed : in STD_LOGIC_VECTOR (31 downto 0);
           --ALU_Bin_sel : in STD_LOGIC;
           ALU_func : in STD_LOGIC_VECTOR (3 downto 0); --ti praksh tha kanei h ALU
           ALU_out : out STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out STD_LOGIC);
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

 COMPONENT REG
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           WrEn : in STD_LOGIC;
           Datain : in STD_LOGIC_VECTOR (31 downto 0);
           Dataout : out STD_LOGIC_VECTOR (31 downto 0));  
    END COMPONENT;
	 
	

component MUX2x1 is
    Port ( Din0 : in STD_LOGIC_VECTOR (31 downto 0);
           Din1 : in STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR(31 downto 0));
end component;


signal temp_PC_In: std_logic_vector(31 downto 0);
signal temp_PC_Out: std_logic_vector(31 downto 0);
signal temp_RF_A : std_logic_vector(31 downto 0);
signal temp_RF_B : std_logic_vector(31 downto 0);
signal temp_PC_Immed : std_logic_vector(31 downto 0);

signal temp_ALU_out : std_logic_vector(31 downto 0);
signal temp_MEM_out : std_logic_vector(31 downto 0);

signal temp_reg_dec_A_out : std_logic_vector(31 downto 0);
signal temp_reg_dec_B_out : std_logic_vector(31 downto 0);
signal temp_reg_ALU_out : std_logic_vector(31 downto 0);
signal temp_reg_MEMOUT_out : std_logic_vector(31 downto 0);

begin 

ifs: 
    IFSTAGE Port map (    PC_In 	=> temp_PC_In,
								  PC_out => temp_PC_Out,
								  ALU_reg_out => temp_reg_ALU_out ,
								  PC_sel  => PC_sel,
								  PC_LdEn => PC_LdEn,
								  Reset 	 => RST,
								  Clk 	 => CLK,
								  PC 		 => PC );

ex:
    EXSTAGE Port map(  In_A 	=> temp_reg_dec_A_out ,
							  In_B 	=> temp_reg_dec_B_out ,
							  PC_out => temp_PC_Out,
							  srcA 	=> srcA,
							  srcB	=> srcB,
							  Immed  =>temp_PC_Immed ,
							  --ALU_Bin_sel => ,
							  ALU_func  => ALU_func,
							  ALU_out 	=> temp_ALU_out,
							  ALU_zero 	=> ALU_zero );


dec:
 DECSTAGE Port map( Instr 	 => Instr,
						  RF_WrEn => RF_WrEn,
						  ALU_out => temp_reg_ALU_out,
						  MEM_out => temp_reg_MEMOUT_out ,
						  RF_WrData_sel =>RF_WrData_sel ,
						  RF_B_sel 	    => RF_B_sel,
						  ImmExt			 => ImmExt,
						  Immed 	 => temp_PC_Immed,
						  RF_A 	 => temp_RF_A,
						  RF_B 	 => temp_RF_B,	
						  Clk		 => CLK,
						  Rst 	 => RST);

-- PC_source: elegxw ton mux pou evala sto exstage.
--Sto IF exw Pcsource=0 giati h alu xrhsimopoieitai gia to pc=pc+4 kai to apotelesma
--einai sthn eisodo tou kataxwrhth ths. Sto decstage opou elegxw to opcode, an einai branch tote 
--xrhsimopoiw thn alu gia to immed. sto exstage h timh pc =pc +4+immed exei 
--perasei ston katax ths alu kai an exw pcsel=1 valid branch tote pcsource=1 kai pclden=1 ksana. tote o pc tha parei thn timh toy branch.

mux_pc:
   MUX2x1 Port map( Din0 => temp_ALU_out,
						  Din1 => temp_reg_ALU_out,
						  sel  => PC_source,
						  Dout =>temp_PC_In );

--A,B kratane times twn telestewn katax pou diavazontai apo to rf
--dedomena metaksy dyo diadoxikwn kyklwn rologiou
reg_A:
    REG Port map(CLK     => CLK,
					  RST 	 => RST,
					  WrEn 	 => we_reg_dec_a,
					  Datain  => temp_RF_A,
					  Dataout => temp_reg_dec_A_out);
reg_B:
    REG Port map( CLK	 => CLK,
						  RST  => RST,
						  WrEn => we_reg_dec_b,
						  Datain  => temp_RF_B,
						  Dataout => temp_reg_dec_B_out);

ALUout:
	REG port map(CLK		=>CLK,
					  WrEn	=>we_reg_alu, 
					  RST		=>RST,
                 Datain	=> temp_ALU_out, 
					  Dataout=>temp_reg_ALU_out );		
					  
MDR:
 REG Port map (  CLK 	=> CLK ,
					  RST => RST ,
					  WrEn 	=> we_reg_MemOut,
					  Datain => temp_MEM_out,
					  Dataout =>temp_reg_MEMOUT_out);
mem:
   MEMSTAGE Port map( --clk : in STD_LOGIC;  --ti kanw me to roloi
						  Mem_WrEn    	=> Mem_WrEn ,
						  ALU_MEM_Addr => temp_reg_ALU_out,
						  MEM_DataIn 	=> temp_reg_dec_B_out,
						  MEM_DataOut	=> temp_MEM_out,
						  MM_Addr 		=> MM_Addr,
						  MM_WrEn 		=> MM_WrEn,
						  MM_WrData 	=> MM_WrData,
						  MM_RdData 	=> MM_RdData,
						  ByteOp 		=> ByteOp );
			  

					  
			  
end Behavioral;

