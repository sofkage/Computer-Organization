----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:14:11 05/01/2021 
-- Design Name: 
-- Module Name:    CONTROL_MC - Behavioral 
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

entity CONTROL_MC is
Port (     OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
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
end CONTROL_MC;

architecture Behavioral of CONTROL_MC is

component CONTROL_FSM is
Port ( OpCode : in  STD_LOGIC_VECTOR (5 downto 0);
           ALU_Op : out  STD_LOGIC_VECTOR (3 downto 0);
           bne : out  STD_LOGIC;
           b_beq : out  STD_LOGIC;
           PC_LdEn : out  STD_LOGIC;
			  PC_source :out STD_LOGIC;
           ImmExt : out  STD_LOGIC_VECTOR (1 downto 0);
           RF_B_Sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           RF_WrData_Sel : out  STD_LOGIC;
           Mem_WrEn : out  STD_LOGIC;
			  we_reg_dec_a : out STD_LOGIC;
			  we_reg_dec_b : out STD_LOGIC;
			  we_reg_ALU : out STD_LOGIC;
			  we_reg_PC : out STD_LOGIC;
			  we_reg_MemOut : out STD_LOGIC;
			  PC_sel : in std_logic;
			  srcA : out  STD_LOGIC;
			  srcB: out  STD_LOGIC_VECTOR(1 downto 0);
           Clk : in  STD_LOGIC;
           Rst : in  STD_LOGIC);
end component;

component CONTROL_ALU is
    Port ( func : in  STD_LOGIC_VECTOR (5 downto 0);
           ALU_op : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0)); 

end component;

signal temp_b_beq : std_logic;
signal temp_bne : std_logic;
signal temp_ALU_Op : std_logic_vector(3 downto 0);
signal temp_PC_Sel : std_logic;

begin


fsm: 
	CONTROL_FSM port map (Clk		=>Clk,
								OpCode	=>OpCode, 
								Rst		=>Rst, 
								ALU_Op	=>temp_ALU_Op, 
								bne		=>temp_bne, 
								b_beq		=>temp_b_beq,
								PC_LdEn	=>PC_LdEn, 
								ImmExt	=>ImmExt, 
								RF_B_Sel	=>RF_B_Sel,
								RF_WrEn	=>RF_WrEn,
								RF_WrData_Sel  =>RF_WrData_Sel,
								Mem_WrEn		   =>Mem_WrEn, 
								we_reg_dec_a	=>we_reg_dec_a, 
								we_reg_dec_b	=>we_reg_dec_b,
								we_reg_ALU 		=>we_reg_ALU  ,
								we_reg_PC 		=>we_reg_PC ,
								we_reg_MemOut 	=>we_reg_MemOut,
								PC_Sel			=>temp_PC_Sel, 
								PC_source		=>PC_source,
								srcA	=>srcA,
								srcB	=>srcB);
									
alu:
 CONTROL_ALU port map (func	  => func,
							  ALU_op   => temp_ALU_Op,
							  ALU_func => ALU_func);


temp_PC_Sel<=((zero AND temp_b_beq) OR ((NOT zero) AND temp_bne)) after 4 ns; --2 ns for and gate and 2 ns for or gate

-- orizw pc sel kai byte op 
PC_Sel <= temp_PC_Sel;
ByteOp <= not(OpCode(3));


end Behavioral;

